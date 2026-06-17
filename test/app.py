import sqlite3
import os

# --- Configuration ---
OUTPUT_DB = "test_scenes.db"

# Put your actual file paths here.
# If a file isn't found, the script will insert dummy bytes automatically.
BACKGROUND_FILES = [
    r"C:\Users\Elijah Ang\Desktop\Projects\Coding\Flutter\prac_res\assets\misc\background.jpg",
    r"C:\Users\Elijah Ang\Desktop\Projects\Coding\Flutter\prac_res\assets\misc\library.png"
]

POSE_FILES = [
    r"C:\Users\Elijah Ang\Desktop\Projects\Coding\Flutter\prac_res\assets\misc\sprites by judas la carotte\sprite1 sad.png",
    r"C:\Users\Elijah Ang\Desktop\Projects\Coding\Flutter\prac_res\assets\misc\sprites by judas la carotte\sprite1 happy.png",
]

# --- Helper Functions ---


def get_image_bytes(filepath: str) -> bytes:
    if os.path.exists(filepath):
        with open(filepath, 'rb') as f:
            return f.read()
    else:
        print(f"  [Warning] Image '{filepath}' not found. Using dummy data.")
        return b"DUMMY_IMAGE_DATA"


def create_schema(cursor: sqlite3.Connection) -> None:
    # 1. Image Groups & Metadata
    cursor.executescript("""
        CREATE TABLE IF NOT EXISTS places (
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
            name TEXT NOT NULL
        );
        CREATE TABLE IF NOT EXISTS background_metadatas (
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
            group_id INTEGER NOT NULL REFERENCES places(id) ON DELETE CASCADE, 
            name TEXT NOT NULL
        );
        CREATE TABLE IF NOT EXISTS background_images (
            metadata_id INTEGER NOT NULL REFERENCES background_metadatas(id) ON DELETE CASCADE PRIMARY KEY, 
            image_data BLOB NOT NULL
        );

        CREATE TABLE IF NOT EXISTS actors (
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
            name TEXT NOT NULL
        );
        CREATE TABLE IF NOT EXISTS pose_metadatas (
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
            group_id INTEGER NOT NULL REFERENCES actors(id) ON DELETE CASCADE, 
            name TEXT NOT NULL
        );
        CREATE TABLE IF NOT EXISTS pose_images (
            metadata_id INTEGER NOT NULL REFERENCES pose_metadatas(id) ON DELETE CASCADE PRIMARY KEY, 
            image_data BLOB NOT NULL
        );

        -- Choices 
        CREATE TABLE IF NOT EXISTS choices (
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
            name TEXT NOT NULL
        );
        CREATE TABLE IF NOT EXISTS choice_options (
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
            choice_id INTEGER NOT NULL REFERENCES choices(id) ON DELETE CASCADE, 
            option_text TEXT NOT NULL,
            is_selected INTEGER NOT NULL DEFAULT 0 CHECK(is_selected IN (0, 1))
        );
        CREATE UNIQUE INDEX IF NOT EXISTS one_selected_per_choice ON choice_options(choice_id) WHERE is_selected = 1;

        -- Scenes
        CREATE TABLE IF NOT EXISTS scenes (
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
            name TEXT NOT NULL
        );
        CREATE TABLE IF NOT EXISTS scene_parts (
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
            scene_id INTEGER NOT NULL REFERENCES scenes(id) ON DELETE CASCADE, 
            "order" REAL NOT NULL, 
            part_type TEXT NOT NULL CHECK(part_type IN ('frame', 'resolver', 'custom'))
        );
        CREATE TABLE IF NOT EXISTS frames (
            scene_part_id INTEGER NOT NULL REFERENCES scene_parts(id) ON DELETE CASCADE PRIMARY KEY, 
            background_id INTEGER REFERENCES background_metadatas(id) ON DELETE SET NULL
        );
        CREATE TABLE IF NOT EXISTS scene_part_resolvers (
            scene_part_id INTEGER NOT NULL REFERENCES scene_parts(id) ON DELETE CASCADE PRIMARY KEY, 
            resolver_script TEXT NOT NULL
        );
        CREATE TABLE IF NOT EXISTS custom_scene_parts (
            scene_part_id INTEGER NOT NULL REFERENCES scene_parts(id) ON DELETE CASCADE PRIMARY KEY, 
            event_id TEXT NOT NULL
        );
        CREATE TABLE IF NOT EXISTS dialogue_boxes (
            frame_scene_part_id INTEGER NOT NULL REFERENCES frames(scene_part_id) ON DELETE CASCADE PRIMARY KEY, 
            name TEXT, 
            dialogue TEXT NOT NULL
        );
        CREATE TABLE IF NOT EXISTS frame_poses (
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
            frame_scene_part_id INTEGER NOT NULL REFERENCES frames(scene_part_id) ON DELETE CASCADE, 
            pose_id INTEGER NOT NULL REFERENCES pose_metadatas(id) ON DELETE CASCADE, 
            "order" REAL NOT NULL
        );

        -- Drift Views
        CREATE VIEW IF NOT EXISTS frame_poses_view AS
            SELECT fp.id, fp.frame_scene_part_id, fp.pose_id, fp."order", pm.group_id, pm.name
            FROM frame_poses fp
            INNER JOIN pose_metadatas pm ON pm.id = fp.pose_id;
            
        CREATE VIEW IF NOT EXISTS scene_timeline_view AS
            SELECT sp.id, sp.scene_id, sp."order", sp.part_type, f.background_id, spr.resolver_script, csp.event_id
            FROM scene_parts sp
            LEFT OUTER JOIN frames f ON f.scene_part_id = sp.id
            LEFT OUTER JOIN scene_part_resolvers spr ON spr.scene_part_id = sp.id
            LEFT OUTER JOIN custom_scene_parts csp ON csp.scene_part_id = sp.id;
    """)


def populate_database(conn: sqlite3.Connection) -> None:
    cursor = conn.cursor()

    # --- 1. Populate Places & Backgrounds ---
    cursor.execute("INSERT INTO places (name) VALUES ('High School')")
    place_id = cursor.lastrowid

    bg_metadata_ids = []
    for i, file_path in enumerate(BACKGROUND_FILES):
        cursor.execute("INSERT INTO background_metadatas (group_id, name) VALUES (?, ?)",
                       (place_id, f"Background {i+1}"))
        bg_meta_id = cursor.lastrowid
        bg_metadata_ids.append(bg_meta_id)

        img_bytes = get_image_bytes(file_path)
        cursor.execute(
            "INSERT INTO background_images (metadata_id, image_data) VALUES (?, ?)", (bg_meta_id, img_bytes))

    # Fallback if empty
    if not bg_metadata_ids:
        cursor.execute(
            "INSERT INTO background_metadatas (group_id, name) VALUES (?, 'Default BG')", (place_id,))
        bg_metadata_ids.append(cursor.lastrowid)

    # --- 2. Populate Actors & Poses ---
    cursor.execute("INSERT INTO actors (name) VALUES ('Alice')")
    actor_id = cursor.lastrowid

    pose_metadata_ids = []
    for i, file_path in enumerate(POSE_FILES):
        cursor.execute(
            "INSERT INTO pose_metadatas (group_id, name) VALUES (?, ?)", (actor_id, f"Pose {i+1}"))
        pose_meta_id = cursor.lastrowid
        pose_metadata_ids.append(pose_meta_id)

        img_bytes = get_image_bytes(file_path)
        cursor.execute(
            "INSERT INTO pose_images (metadata_id, image_data) VALUES (?, ?)", (pose_meta_id, img_bytes))

    if not pose_metadata_ids:
        cursor.execute(
            "INSERT INTO pose_metadatas (group_id, name) VALUES (?, 'Default Pose')", (actor_id,))
        pose_metadata_ids.append(cursor.lastrowid)

    bg_ref = bg_metadata_ids[0]
    pose_ref = pose_metadata_ids[0]

    # --- Helper to create a Frame ---
    def make_frame(scene_id: int | None, order: float, dialogue_text: str) -> int | None:
        cursor.execute(
            "INSERT INTO scene_parts (scene_id, \"order\", part_type) VALUES (?, ?, 'frame')", (scene_id, order))
        part_id = cursor.lastrowid
        cursor.execute(
            "INSERT INTO frames (scene_part_id, background_id) VALUES (?, ?)", (part_id, bg_ref))
        cursor.execute(
            "INSERT INTO dialogue_boxes (frame_scene_part_id, name, dialogue) VALUES (?, 'Alice', ?)", (part_id, dialogue_text))
        cursor.execute(
            "INSERT INTO frame_poses (frame_scene_part_id, pose_id, \"order\") VALUES (?, ?, 1.0)", (part_id, pose_ref))
        return part_id

    # --- 3. Build Scenes ---

    # Scene 1: Only Frames (5 parts)
    cursor.execute(
        "INSERT INTO scenes (name) VALUES ('Scene 1: Introduction')")
    scene1_id = cursor.lastrowid
    for i in range(5):
        make_frame(scene1_id, float(
            i), f"This is purely frame dialogue {i+1}.")

    # Scene 2: Frames + Resolver (4 frames, 1 resolver)
    cursor.execute("INSERT INTO scenes (name) VALUES ('Scene 2: Branching')")
    scene2_id = cursor.lastrowid
    for i in range(4):
        make_frame(scene2_id, float(i), f"Approaching a resolver {i+1}...")

    cursor.execute(
        "INSERT INTO scene_parts (scene_id, \"order\", part_type) VALUES (?, ?, 'resolver')", (scene2_id, 4.0))
    resolver_part_id = cursor.lastrowid
    cursor.execute("INSERT INTO scene_part_resolvers (scene_part_id, resolver_script) VALUES (?, ?)",
                   (resolver_part_id, "jump_to_scene('Scene 3')"))

    # Scene 3: Frames, Resolvers, and Customs (3 frames, 1 resolver, 1 custom)
    cursor.execute("INSERT INTO scenes (name) VALUES ('Scene 3: The Finale')")
    scene3_id = cursor.lastrowid
    for i in range(3):
        make_frame(scene3_id, float(i), f"Action sequence {i+1}!")

    cursor.execute(
        "INSERT INTO scene_parts (scene_id, \"order\", part_type) VALUES (?, ?, 'resolver')", (scene3_id, 3.0))
    res_part2 = cursor.lastrowid
    cursor.execute("INSERT INTO scene_part_resolvers (scene_part_id, resolver_script) VALUES (?, ?)",
                   (res_part2, "calculate_score()"))

    cursor.execute(
        "INSERT INTO scene_parts (scene_id, \"order\", part_type) VALUES (?, ?, 'custom')", (scene3_id, 4.0))
    custom_part = cursor.lastrowid
    cursor.execute("INSERT INTO custom_scene_parts (scene_part_id, event_id) VALUES (?, ?)",
                   (custom_part, "play_credits_video"))

    conn.commit()


# --- Execution ---
if __name__ == "__main__":
    if os.path.exists(OUTPUT_DB):
        os.remove(OUTPUT_DB)

    print(f"Generating {OUTPUT_DB}...")

    with sqlite3.connect(OUTPUT_DB) as conn:
        # Enforce foreign keys strictly
        conn.execute("PRAGMA foreign_keys = ON;")
        create_schema(conn)
        populate_database(conn)

    print("Database generated successfully!")

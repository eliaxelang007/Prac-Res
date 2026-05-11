import sqlite3
import os

# ==========================================
# 1. CONFIGURATION: SPECIFY YOUR IMAGE PATHS
# ==========================================
# Point these to your actual image files.
# If a file isn't found, the script will fall back to a dummy 1x1 PNG.

IMAGE_PATHS = {
    "background": r"C:\Users\Elijah Ang\Desktop\Projects\Coding\Flutter\prac_res\assets\misc\background.jpg",
    "actor_alice_pose": r"C:\Users\Elijah Ang\Desktop\Projects\Coding\Flutter\prac_res\assets\misc\sprites by judas la carotte\sprite1 happy.png",
    "actor_bob_pose": r"C:\Users\Elijah Ang\Desktop\Projects\Coding\Flutter\prac_res\assets\misc\sprites by judas la carotte\sprite3 happy.png"
}

OUTPUT_DB_NAME = "sample_scenes.db"

# Minimal 1x1 transparent PNG bytes used as a fallback
DUMMY_PNG_BYTES = (
    b'\x89PNG\r\n\x1a\n\x00\x00\x00\rIHDR\x00\x00\x00\x01\x00\x00\x00\x01'
    b'\x08\x06\x00\x00\x00\x1f\x15\xc4\x89\x00\x00\x00\nIDATx\x9cc\x00\x01'
    b'\x00\x00\x05\x00\x01\r\n-\xb4\x00\x00\x00\x00IEND\xaeB`\x82'
)


def get_image_bytes(path_key):
    """Reads image bytes from disk, falling back to a dummy PNG if missing."""
    path = IMAGE_PATHS.get(path_key, "")
    if os.path.exists(path):
        print(f"Loading image for '{path_key}' from: {path}")
        with open(path, "rb") as f:
            return f.read()
    else:
        print(
            f"⚠️ Warning: Image '{path}' not found for '{path_key}'. Using dummy 1x1 PNG.")
        return DUMMY_PNG_BYTES

# ==========================================
# 2. DATABASE SCHEMA (DRIFT DDL MAPPING)
# ==========================================


def create_schema(cursor):
    # Enable foreign keys
    cursor.execute("PRAGMA foreign_keys = ON;")

    # Places & Backgrounds
    cursor.executescript("""
        CREATE TABLE IF NOT EXISTS places (
            id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL
        );

        CREATE TABLE IF NOT EXISTS backgrounds (
            id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
            place_id INTEGER NOT NULL REFERENCES places (id) ON DELETE CASCADE,
            name TEXT NOT NULL,
            image_data BLOB NOT NULL
        );

        -- Actors & Poses
        CREATE TABLE IF NOT EXISTS actors (
            id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL
        );

        CREATE TABLE IF NOT EXISTS poses (
            id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
            actor_id INTEGER NOT NULL REFERENCES actors (id) ON DELETE CASCADE,
            name TEXT NOT NULL,
            image_data BLOB NOT NULL
        );

        -- Choices & Options
        CREATE TABLE IF NOT EXISTS choices (
            id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL
        );

        CREATE TABLE IF NOT EXISTS choice_options (
            id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
            choice_id INTEGER NOT NULL REFERENCES choices (id) ON DELETE CASCADE,
            option_text TEXT NOT NULL,
            is_selected INTEGER NOT NULL DEFAULT 0 CHECK (is_selected IN (0, 1))
        );

        CREATE UNIQUE INDEX IF NOT EXISTS one_selected_per_choice 
        ON choice_options(choice_id) 
        WHERE is_selected = 1;

        -- Scenes & Scene Parts
        CREATE TABLE IF NOT EXISTS scenes (
            id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL
        );

        CREATE TABLE IF NOT EXISTS scene_parts (
            id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
            scene_id INTEGER NOT NULL REFERENCES scenes (id) ON DELETE CASCADE,
            "order" REAL NOT NULL,
            part_type TEXT NOT NULL CHECK (part_type IN ('frame', 'resolver', 'custom'))
        );

        -- Specific Scene Part Types
        CREATE TABLE IF NOT EXISTS frames (
            scene_part_id INTEGER NOT NULL PRIMARY KEY REFERENCES scene_parts (id) ON DELETE CASCADE,
            background_id INTEGER REFERENCES backgrounds (id) ON DELETE SET NULL
        );

        CREATE TABLE IF NOT EXISTS frame_resolvers (
            scene_part_id INTEGER NOT NULL PRIMARY KEY REFERENCES scene_parts (id) ON DELETE CASCADE,
            resolver_script TEXT NOT NULL
        );

        CREATE TABLE IF NOT EXISTS custom (
            scene_part_id INTEGER NOT NULL PRIMARY KEY REFERENCES scene_parts (id) ON DELETE CASCADE,
            event_id TEXT NOT NULL
        );

        -- Frame Components
        CREATE TABLE IF NOT EXISTS dialogue_boxes (
            frame_scene_part_id INTEGER NOT NULL PRIMARY KEY REFERENCES frames (scene_part_id) ON DELETE CASCADE,
            name TEXT,
            dialogue TEXT NOT NULL
        );

        CREATE TABLE IF NOT EXISTS frame_poses (
            id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
            frame_scene_part_id INTEGER NOT NULL REFERENCES frames (scene_part_id) ON DELETE CASCADE,
            pose_id INTEGER NOT NULL REFERENCES poses (id) ON DELETE CASCADE,
            "order" REAL NOT NULL
        );

        -- Views
        CREATE VIEW IF NOT EXISTS frame_poses_view AS
        SELECT 
            frame_poses.id,
            frame_poses.frame_scene_part_id,
            frame_poses.pose_id,
            frame_poses."order",
            poses.actor_id,
            poses.name,
            poses.image_data
        FROM frame_poses
        INNER JOIN poses ON poses.id = frame_poses.pose_id;

        CREATE VIEW IF NOT EXISTS scene_timeline_view AS
        SELECT 
            scene_parts.id,
            scene_parts.scene_id,
            scene_parts."order",
            scene_parts.part_type,
            frames.background_id,
            frame_resolvers.resolver_script,
            custom.event_id
        FROM scene_parts
        LEFT OUTER JOIN frames ON frames.scene_part_id = scene_parts.id
        LEFT OUTER JOIN frame_resolvers ON frame_resolvers.scene_part_id = scene_parts.id
        LEFT OUTER JOIN custom ON custom.scene_part_id = scene_parts.id;
    """)

# ==========================================
# 3. POPULATE SAMPLE DATA
# ==========================================


def populate_data(conn):
    cursor = conn.cursor()

    # Load Image Blobs
    bg_blob = get_image_bytes("background")
    alice_blob = get_image_bytes("actor_alice_pose")
    bob_blob = get_image_bytes("actor_bob_pose")

    # 1. Insert Place & Background
    cursor.execute("INSERT INTO places (name) VALUES (?);", ("High School",))
    place_id = cursor.lastrowid

    cursor.execute(
        "INSERT INTO backgrounds (place_id, name, image_data) VALUES (?, ?, ?);",
        (place_id, "Classroom Day", bg_blob)
    )
    bg_id = cursor.lastrowid

    # 2. Insert Actors & Poses
    cursor.execute("INSERT INTO actors (name) VALUES (?);", ("Alice",))
    alice_actor_id = cursor.lastrowid
    cursor.execute(
        "INSERT INTO poses (actor_id, name, image_data) VALUES (?, ?, ?);",
        (alice_actor_id, "Alice Standing", alice_blob)
    )
    alice_pose_id = cursor.lastrowid

    cursor.execute("INSERT INTO actors (name) VALUES (?);", ("Bob",))
    bob_actor_id = cursor.lastrowid
    cursor.execute(
        "INSERT INTO poses (actor_id, name, image_data) VALUES (?, ?, ?);",
        (bob_actor_id, "Bob Greeting", bob_blob)
    )
    bob_pose_id = cursor.lastrowid

    # 3. Insert Scene
    cursor.execute("INSERT INTO scenes (name) VALUES (?);",
                   ("Chapter 1: The Meeting",))
    scene_id = cursor.lastrowid

    # ------------------------------------------
    # FRAME 1: Alice speaks
    # ------------------------------------------
    # Create the base scene_part
    cursor.execute(
        "INSERT INTO scene_parts (scene_id, \"order\", part_type) VALUES (?, ?, ?);",
        (scene_id, 1.0, "frame")
    )
    frame1_part_id = cursor.lastrowid

    # Attach it to the frames table
    cursor.execute(
        "INSERT INTO frames (scene_part_id, background_id) VALUES (?, ?);",
        (frame1_part_id, bg_id)
    )

    # Add Dialogue Box
    cursor.execute(
        "INSERT INTO dialogue_boxes (frame_scene_part_id, name, dialogue) VALUES (?, ?, ?);",
        (frame1_part_id, "Alice", "Hey! Are you new here? I haven't seen you around.")
    )

    # Add Frame Pose (Alice standing on the left, order 1.0)
    cursor.execute(
        "INSERT INTO frame_poses (frame_scene_part_id, pose_id, \"order\") VALUES (?, ?, ?);",
        (frame1_part_id, alice_pose_id, 1.0)
    )

    # ------------------------------------------
    # FRAME 2: Bob responds
    # ------------------------------------------
    # Create the base scene_part
    cursor.execute(
        "INSERT INTO scene_parts (scene_id, \"order\", part_type) VALUES (?, ?, ?);",
        (scene_id, 2.0, "frame")
    )
    frame2_part_id = cursor.lastrowid

    # Attach it to the frames table (using same background)
    cursor.execute(
        "INSERT INTO frames (scene_part_id, background_id) VALUES (?, ?);",
        (frame2_part_id, bg_id)
    )

    # Add Dialogue Box
    cursor.execute(
        "INSERT INTO dialogue_boxes (frame_scene_part_id, name, dialogue) VALUES (?, ?, ?);",
        (frame2_part_id, "Bob", "Yeah, I just transferred in today. Nice to meet you!")
    )

    # Add Frame Poses (Keep Alice on screen, but add Bob responding)
    cursor.execute(
        "INSERT INTO frame_poses (frame_scene_part_id, pose_id, \"order\") VALUES (?, ?, ?);",
        (frame2_part_id, alice_pose_id, 1.0)
    )
    cursor.execute(
        "INSERT INTO frame_poses (frame_scene_part_id, pose_id, \"order\") VALUES (?, ?, ?);",
        (frame2_part_id, bob_pose_id, 2.0)
    )

    conn.commit()
    print("✅ Sample data populated successfully!")

# ==========================================
# EXECUTION FLOW
# ==========================================


def main():
    # Remove existing DB file to ensure clean test generation
    if os.path.exists(OUTPUT_DB_NAME):
        os.remove(OUTPUT_DB_NAME)
        print(f"Removed old '{OUTPUT_DB_NAME}'.")

    conn = sqlite3.connect(OUTPUT_DB_NAME)
    try:
        print("Creating schema...")
        create_schema(conn.cursor())

        print("Inserting records...")
        populate_data(conn)

        print(f"🎉 All done! Database saved as '{OUTPUT_DB_NAME}'.")
    except Exception as e:
        print(f"❌ An error occurred: {e}")
        conn.rollback()
    finally:
        conn.close()


if __name__ == "__main__":
    main()

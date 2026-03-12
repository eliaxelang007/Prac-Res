// import 'package:flutter/material.dart';

// class Frame extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Positioned.fill(
//           child: Image.asset(
//             "assets/prototype/background.jpg",
//             fit: BoxFit.cover,
//           ),
//         ),
//         Positioned.fill(
//           child: Column(
//             children: [
//               Expanded(child: SizedBox()),
//               Expanded(
//                 flex: 6,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [Image.asset("assets/prototype/sprite.png")],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Positioned.fill(
//           child: Column(
//             children: [
//               Expanded(flex: 5, child: SizedBox()),
//               Expanded(
//                 flex: 2,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Expanded(flex: 1, child: SizedBox()),
//                     Expanded(
//                       flex: 3,
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: Color(0xFF0b0914),
//                             borderRadius: BorderRadius.circular(16.0),
//                           ),
//                           child: SizedBox.expand(
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Text(
//                                 "Hello!",
//                                 style: Theme.of(context).textTheme.headlineSmall
//                                     ?.copyWith(color: Colors.white),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Expanded(flex: 1, child: SizedBox()),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Frame extends StatefulWidget {
  const Frame({super.key});

  @override
  State<Frame> createState() => _FrameState();
}

class _FrameState extends State<Frame> {
  late Future<int> _syncValueFuture;
  late Future<int> _delayedFuture;
  late Future<int> _synchronousFuture;

  @override
  void initState() {
    super.initState();
    _loadFutures();
  }

  void _loadFutures() {
    // 1. Dart 3.10+ Future.syncValue
    _syncValueFuture = Future.syncValue(10);

    // 2. Slow Future taking time to complete
    _delayedFuture = Future.delayed(const Duration(seconds: 2), () => 42);

    // 3. Flutter's SynchronousFuture (The real instant future)
    _synchronousFuture = SynchronousFuture(99);
  }

  void _reload() {
    setState(() {
      _loadFutures();
    });
  }

  @override
  Widget build(BuildContext context) {
    print("render...");

    return Scaffold(
      appBar: AppBar(title: const Text('Future.syncValue Test')),

      body: Padding(
        padding: const EdgeInsets.all(0),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,

          children: [
            const Text(
              '1. Future.syncValue(10)',

              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),

            const Text(
              'Notice how it STILL briefly flashes the red loading text!',
            ),

            const SizedBox(height: 8),

            FutureBuilder<int>(
              future: _syncValueFuture,

              builder: (context, snapshot) {
                print("Ok!");

                if (snapshot.connectionState == ConnectionState.waiting) {
                  print("Oh no!");

                  return const Text(
                    '⏳ Loading temporarily flashed!',
                    style: TextStyle(
                      fontSize: 10000000,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }

                if (snapshot.hasData) {
                  print("oh yes!");

                  return Text('✅ Value is: ${snapshot.data}');
                }

                return const Text('Error');
              },
            ),

            const Divider(height: 32),

            const Text(
              '2. Future.delayed(2 seconds)',

              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),

            const SizedBox(height: 8),

            FutureBuilder<int>(
              future: _delayedFuture,

              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Align(
                    alignment: Alignment.centerLeft,

                    child: const Text(
                      '⏳ Loading temporarily flashed!',
                      style: TextStyle(
                        fontSize: 10000000,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ), // CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasData) {
                  return Text('✅ Value is: ${snapshot.data}');
                }

                return const Text('Error');
              },
            ),

            const Divider(height: 32),

            const Text(
              '3. The Fixes (No Flashing)',

              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.green,
              ),
            ),

            const SizedBox(height: 8),

            const Text('Fix A: Future.syncValue with initialData'),

            FutureBuilder<int>(
              future: _syncValueFuture,

              initialData: 10,

              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting &&
                    !snapshot.hasData) {
                  return const Text(
                    '⏳ Loading...',
                    style: TextStyle(color: Colors.red),
                  );
                }

                return Text('✅ Value is immediately: ${snapshot.data}');
              },
            ),

            const SizedBox(height: 16),

            const Text('Fix B: Flutter\'s SynchronousFuture(99)'),

            FutureBuilder<int>(
              future: _synchronousFuture,

              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text(
                    '⏳ Loading temporarily flashed!',
                    style: TextStyle(color: Colors.red),
                  );
                }

                if (snapshot.hasData) {
                  return Text('✅ Value is immediately: ${snapshot.data}');
                }

                return const Text('Error');
              },
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _reload,

        tooltip: 'Reload Futures',

        child: const Icon(Icons.refresh),
      ),
    );
  }
}

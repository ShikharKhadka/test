// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:go_routering/providers.dart';
import 'package:go_routering/routes.dart';
import 'package:go_routering/test.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(futurePostProvider);
    final post = ref.watch(postProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Home'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ...post.map((e) => Column(
                  children: [
                    Text(e.userId.toString()),
                    Text(e.body ?? ''),
                  ],
                )),
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).go('/first/details');
              },
              child: const Text('First'),
            ),
          ],
        ),
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({required this.child, super.key});
  final Widget child;

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  int currentIndex = 0;

  @override
  void initState() {
    print(Test.kd.displayName);

    super.initState();
  }

  Widget getpage() {
    switch (currentIndex) {
      case 1:
        return HomeScreen();
      case 2:
        return SecondScreen();
      default:
        return ThirdScreen();
    }
  }

  // static int _calculateSelectedIndex(BuildContext context) {
  //   final String location = GoRouterState.of(context).uri.path;
  //   if (location.startsWith('/first')) {
  //     return 0;
  //   }
  //   if (location.startsWith('/second')) {
  //     return 1;
  //   }
  //   if (location.startsWith('/third')) {
  //     return 2;
  //   }
  //   return 0;
  // }

  // void _onItemTapped(int index, BuildContext context) {
  //   switch (index) {
  //     case 0:
  //       GoRouter.of(context).go('/first');
  //     case 1:
  //       GoRouter.of(context).go('/second');
  //     case 2:
  //       GoRouter.of(context).go('/third');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
          onTap:
              // (value)
              //  => _onItemTapped(value, context),
              (value) {
            setState(() {
              currentIndex = value;
            });
            switch (value) {
              case 0:
                context.go('/first');
              case 1:
                context.go('/second');
              case 2:
                context.go('/third');
              default:
            }
          },
          currentIndex: currentIndex,
          // _calculateSelectedIndex(context),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.abc), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.abc_outlined), label: 'Second'),
            BottomNavigationBarItem(
                icon: Icon(Icons.abc_sharp), label: 'Third'),
          ]),
    );
  }
}

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              context.push('/first/details');
            },
            child: const Text('First'),
          ),
        ],
      ),
    );
  }
}

class SecondScreen extends ConsumerWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Second'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ref.watch(futurePostProvider).when(
                data: (data) => Column(
                      children: [
                        ...data.map((e) => Column(
                              children: [
                                Text(e.userId.toString()),
                                Text(e.body ?? ''),
                              ],
                            )),
                        ElevatedButton(
                          onPressed: () {
                            GoRouter.of(context).go('/first/details');
                          },
                          child: const Text('First'),
                        ),
                      ],
                    ),
                error: (e, s) => Text('data'),
                loading: () => CircularProgressIndicator()),
            ElevatedButton(
              onPressed: () {
                context.push('/second/details');
              },
              child: const Text('Second'),
            ),
          ],
        ),
      ),
    );
  }
}

class ThirdScreen extends ConsumerWidget {
  const ThirdScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(myStateProvider);
    final count1 = ref.watch(myStateProvider1);
    final post = ref.watch(myStateProvider2);

    return Scaffold(
      appBar: AppBar(
        title: Text('Third'),
      ),
      body: Column(
        children: [
          post.when(
              data: (data) => Column(
                    children: [
                      ...data.map((e) => Column(
                            children: [
                              Text(e.userId.toString()),
                              Text(e.body ?? ''),
                            ],
                          )),
                      ElevatedButton(
                        onPressed: () {
                          GoRouter.of(context).go('/first/details');
                        },
                        child: const Text('First'),
                      ),
                    ],
                  ),
              error: (e, s) => Text('data'),
              loading: () => CircularProgressIndicator()),
          Text(count.count.toString()),
          Text(count1.edit.toString()),
          Checkbox(
              value: count1.edit,
              onChanged: (value) =>
                  ref.read(myStateProvider1.notifier).increment()),
          ElevatedButton(
            onPressed: () {
              // ref.read(myStateProvider.notifier).increment();
              ref.read(myStateProvider1.notifier).increment();

              // context.push('/third/details');
            },
            child: const Text('Third'),
          ),
        ],
      ),
    );
  }
}

class DetailsScreen extends StatelessWidget {
  /// Constructs a [DetailsScreen].
  const DetailsScreen({
    required this.label,
    super.key,
  });

  /// The label to display in the center of the screen.
  final String label;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('Details Screen'),
      ),
      body: Center(
        child: Text(
          'Details for $label',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: Text('UniqueKey Example')),
//         body: ItemList(),
//       ),
//     );
//   }
// }

// class Test {
//   String name;
//   VoidCallback onTap;
//   Test({
//     required this.name,
//     required this.onTap,
//   });
// }

// class ItemList extends StatefulWidget {
//   @override
//   _ItemListState createState() => _ItemListState();
// }

// class _ItemListState extends State<ItemList> {
//   List<Test> items = [
//     Test(
//         name: 'name',
//         onTap: () {
//           print('object');
//         }),
//     Test(
//         name: 'name1',
//         onTap: () {
//           print('object1');
//         })
//   ];

//   @override
//   void initState() {
//     super.initState();
//   }

//   void _shuffleItems() {
//     setState(() {
//       items.shuffle();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Text('Shuffle Items'),
//         Expanded(
//           child: ListView(
//               children: items
//                   .map((e) => ListItem(
//                         index: e.name,
//                         onTap: e.onTap,
//                       ))
//                   .toList()),
//         ),
//       ],
//     );
//   }
// }

// class ListItem extends StatelessWidget {
//   final String index;
//   final VoidCallback onTap;

//   const ListItem({super.key, required this.index, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: SizedBox(
//         height: 300,
//         width: 300,
//         child: Text(index),
//       ),
//     );
//   }
// }

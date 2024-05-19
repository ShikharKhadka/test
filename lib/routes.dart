import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:go_routering/main.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

final router = GoRouter(
    initialLocation: '/first',
    navigatorKey: _rootNavigatorKey,
    routes: [
      // GoRoute(
      //     path: '/first',
      //     builder: (context, state) => const HomeScreen(),
      //     routes: [
      //       GoRoute(
      //         path: 'details',
      //         builder: (BuildContext context, GoRouterState state) {
      //           return const DetailsScreen(label: 'A');
      //         },
      //       ),
      //     ]),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return MyWidget(
            child: child,
          );
        },
        routes: [
          GoRoute(
              path: '/first',
              builder: (context, state) => const HomeScreen(),
              routes: [
                GoRoute(
                  path: 'details',
                  builder: (BuildContext context, GoRouterState state) {
                    return const DetailsScreen(label: 'A');
                  },
                ),
              ]),
          GoRoute(
              path: '/second',
              builder: (context, state) => const SecondScreen(),
              routes: [
                GoRoute(
                  path: 'details',
                  builder: (BuildContext context, GoRouterState state) {
                    return const DetailsScreen(label: 'A');
                  },
                )
              ]),
          GoRoute(
              path: '/third',
              builder: (context, state) => const ThirdScreen(),
              routes: [
                // GoRoute(
                //   path: 'details',
                //   builder: (BuildContext context, GoRouterState state) {
                //     return const DetailsScreen(label: 'A');
                //   },
                // )
              ])
        ],
      ),
      GoRoute(
          path: '/third',
          builder: (context, state) => const ThirdScreen(),
          routes: [
            GoRoute(
              path: 'details',
              builder: (BuildContext context, GoRouterState state) {
                return const DetailsScreen(label: 'A');
              },
            )
          ])
    ]);

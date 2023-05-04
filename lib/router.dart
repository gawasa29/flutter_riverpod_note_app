import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_note_app/screen/home/home_screen.dart';
import 'package:go_router/go_router.dart';

import 'screen/edit_note/edit_note_screen.dart';

final navigatorKey = Provider((ref) => GlobalKey<NavigatorState>());

final routerProvider = Provider(
  (ref) => GoRouter(
    initialLocation: '/',
    navigatorKey: ref.watch(navigatorKey),
    routes: [
      GoRoute(
          path: '/',
          name: HomeScreen.routeName,
          //HomeScreenに行くときにアニメーションする
          pageBuilder: (BuildContext context, GoRouterState state) {
            return CustomTransitionPage<void>(
              key: state.pageKey,
              child: const HomeScreen(),
              transitionDuration: const Duration(milliseconds: 150),
              transitionsBuilder: (BuildContext context,
                  Animation<double> animation,
                  Animation<double> secondaryAnimation,
                  Widget child) {
                return FadeTransition(
                  opacity:
                      CurveTween(curve: Curves.easeInOut).animate(animation),
                  child: child,
                );
              },
            );
          }),
      GoRoute(
        path: '/EditNote',
        name: EditNoteScreen.routeName,
        builder: (context, state) => const EditNoteScreen(),
      ),
    ],
  ),
);

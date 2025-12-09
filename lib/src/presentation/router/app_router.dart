import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../pages/detail_page.dart';
import '../pages/downloads_page.dart';
import '../pages/home_page.dart';
import '../pages/player_page.dart';
import '../pages/profile_page.dart';
import '../pages/search_page.dart';

final appRouter = GoRouter(
  routes: [
    ShellRoute(
      builder: (context, state, child) => _MainShell(child: child),
      routes: [
        GoRoute(
          path: '/',
          name: 'home',
          pageBuilder: (context, state) => _buildPageWithFadeTransition(
            context,
            state,
            const HomePage(),
          ),
          routes: [
            GoRoute(
              path: 'movie/:id',
              name: 'movieDetail',
              pageBuilder: (context, state) {
                final id = state.pathParameters['id']!;
                return _buildPageWithSlideTransition(
                  context,
                  state,
                  DetailPage(movieId: id),
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: '/search',
          name: 'search',
          pageBuilder: (context, state) => _buildPageWithFadeTransition(
            context,
            state,
            const SearchPage(),
          ),
        ),
        GoRoute(
          path: '/downloads',
          name: 'downloads',
          pageBuilder: (context, state) => _buildPageWithFadeTransition(
            context,
            state,
            const DownloadsPage(),
          ),
        ),
        GoRoute(
          path: '/profile',
          name: 'profile',
          pageBuilder: (context, state) => _buildPageWithFadeTransition(
            context,
            state,
            const ProfilePage(),
          ),
        ),
      ],
    ),
    GoRoute(
      path: '/player',
      name: 'player',
      pageBuilder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        final videoUrl = extra?['videoUrl'] as String?;
        final title = extra?['title'] as String? ?? 'Player';
        if (videoUrl == null) {
          return _buildPageWithSlideTransition(
            context,
            state,
            const Scaffold(
              body: Center(child: Text('Video URL is missing')),
            ),
          );
        }
        return _buildPageWithSlideTransition(
          context,
          state,
          PlayerPage(videoUrl: videoUrl, title: title),
        );
      },
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(child: Text(state.error.toString())),
  ),
);

/// Builds a page with fade transition animation
CustomTransitionPage<void> _buildPageWithFadeTransition(
  BuildContext context,
  GoRouterState state,
  Widget child,
) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
        child: child,
      );
    },
    transitionDuration: const Duration(milliseconds: 250),
  );
}

/// Builds a page with horizontal slide transition animation
CustomTransitionPage<void> _buildPageWithSlideTransition(
  BuildContext context,
  GoRouterState state,
  Widget child,
) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      final tween = Tween(begin: begin, end: end);
      final offsetAnimation = animation.drive(
        tween.chain(CurveTween(curve: Curves.easeInOut)),
      );

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
    transitionDuration: const Duration(milliseconds: 250),
  );
}

class _MainShell extends StatefulWidget {
  final Widget child;
  const _MainShell({required this.child});

  @override
  State<_MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<_MainShell> {
  int _indexFromLocation(String location) {
    if (location.startsWith('/search')) return 1;
    if (location.startsWith('/downloads')) return 2;
    if (location.startsWith('/profile')) return 3;
    return 0;
  }

  void _onTap(int index) {
    switch (index) {
      case 0:
        context.goNamed('home');
        break;
      case 1:
        context.goNamed('search');
        break;
      case 2:
        context.goNamed('downloads');
        break;
      case 3:
        context.goNamed('profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _indexFromLocation(GoRouterState.of(context).uri.toString());
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(child: widget.child),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: _onTap,
        selectedItemColor: theme.bottomNavigationBarTheme.selectedItemColor,
        unselectedItemColor: theme.bottomNavigationBarTheme.unselectedItemColor,
        backgroundColor: theme.bottomNavigationBarTheme.backgroundColor,
        type: theme.bottomNavigationBarTheme.type,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
              icon: Icon(Icons.download), label: 'Downloads'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}


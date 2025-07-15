import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/multiplication/presentation/pages/account_page.dart';
import 'features/multiplication/presentation/pages/multiplication_challenge_page.dart';
import 'features/multiplication/presentation/pages/multiplication_selection_page.dart';
import 'features/multiplication/presentation/pages/register_user_page.dart';
import 'features/multiplication/presentation/pages/result_page.dart';
import 'features/multiplication/presentation/providers/user_provider.dart';
import 'common/widgets/app_bottom_navigation_bar.dart'; // ボトムナビゲーションバーの共通ウィジェット
import 'features/multiplication/domain/entities/challenge_problem_result/challenge_problem_result.dart'; // このimportを追加

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
// StatefulShellRoute は内部でキーを管理するため、_shellNavigatorKey は不要になります。

final goRouterProvider = Provider<GoRouter>((ref) {
  final userAsyncValue = ref.watch(userNotifierProvider);

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        redirect: (context, state) {
          return userAsyncValue.when(
            data: (user) {
              if (user == null) {
                return '/register';
              }
              // ユーザーが存在する場合は、シェルルートのデフォルトパスにリダイレクト
              return '/home/selection';
            },
            loading: () => null,
            error: (err, stack) => '/register',
          );
        },
        builder: (context, state) =>
            const Scaffold(body: Center(child: CircularProgressIndicator())),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterUserPage(),
      ),
      // StatefulShellRoute を定義
      StatefulShellRoute.indexedStack(
        // index を使用した BottomNavigationBar に最適
        builder: (context, state, navigationShell) {
          // 現在のパスが '/challenge' でない場合にのみ BottomNavigationBar を表示
          final bool showBottomNav = !state.uri.toString().contains(
            '/challenge',
          );

          return Scaffold(
            body: navigationShell, // navigationShell を直接 body に渡す
            bottomNavigationBar: showBottomNav
                ? AppBottomNavigationBar(
                    navigationShell: navigationShell,
                  ) // navigationShell を渡す
                : null, // /challenge の場合は null を返して非表示
          );
        },
        // 各ブランチ（タブ）のルートを定義
        branches: [
          // チャレンジ画面（段位選択）ブランチ
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home/selection',
                builder: (context, state) =>
                    const MultiplicationSelectionPage(),
              ),
            ],
          ),
          // アカウント画面ブランチ
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home/account',
                builder: (context, state) => const AccountPage(),
              ),
            ],
          ),
        ],
      ),
      // チャレンジ画面と結果画面は ShellRoute の外
      GoRoute(
        path: '/challenge',
        builder: (context, state) => const MultiplicationChallengePage(),
      ),
      GoRoute(
        path: '/result',
        builder: (context, state) {
          final args = state.extra as Map<String, dynamic>?;
          return ResultPage(
            correctAnswers: args?['correctAnswers'] ?? 0,
            totalProblems: args?['totalProblems'] ?? 0,
            starsEarned: args?['starsEarned'] ?? 0,
            problemResults:
                args?['problemResults']?.cast<ChallengeProblemResult>() ??
                [], // problemResultsを渡す
          );
        },
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('エラー')),
      body: Center(child: Text('ページが見つかりません: ${state.error}')),
    ),
  );
});

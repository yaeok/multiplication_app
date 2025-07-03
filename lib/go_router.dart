import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/multiplication/presentation/pages/account_page.dart';
import 'features/multiplication/presentation/pages/multiplication_challenge_page.dart';
import 'features/multiplication/presentation/pages/multiplication_selection_page.dart';
import 'features/multiplication/presentation/pages/register_user_page.dart';
import 'features/multiplication/presentation/pages/result_page.dart';
import 'features/multiplication/presentation/providers/user_provider.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  // UserNotifierの状態を監視
  // loadUser() は UserNotifier の build メソッドで既に呼ばれるので、
  // ここではその結果を待つだけで良い
  final userAsyncValue = ref.watch(userNotifierProvider);

  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        // ここでのリダイレクトは、UserNotifierのAsyncValueの状態に基づいて行う
        // AsyncLoadingの場合はまだ判断できないのでnullを返す
        // AsyncDataでuserがnullなら登録画面、そうでなければ選択画面へ
        redirect: (context, state) {
          return userAsyncValue.when(
            data: (user) {
              if (user == null) {
                return '/register';
              }
              return '/multiplication_selection';
            },
            loading: () => null, // ロード中はリダイレクトしない (Routerは次のビルドで再評価する)
            error: (err, stack) => '/register', // エラー時は登録画面へ
          );
        },
        builder: (context, state) => const Scaffold(
          body: Center(child: CircularProgressIndicator()), // 初期ロード画面
        ),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterUserPage(),
      ),
      GoRoute(
        path: '/multiplication_selection',
        builder: (context, state) => const MultiplicationSelectionPage(),
      ),
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
          );
        },
      ),
      GoRoute(
        path: '/account',
        builder: (context, state) => const AccountPage(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('エラー')),
      body: Center(child: Text('ページが見つかりません: ${state.error}')),
    ),
  );
});

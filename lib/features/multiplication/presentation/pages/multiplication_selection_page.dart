import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/multiplication_challenge_provider.dart';
import '../providers/user_provider.dart';

class MultiplicationSelectionPage extends ConsumerWidget {
  const MultiplicationSelectionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsyncValue = ref.watch(userNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('かけ算チャレンジ'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () => GoRouter.of(context).go('/account'),
          ),
        ],
      ),
      body: userAsyncValue.when(
        data: (user) {
          if (user == null) {
            // ユーザーがロードされていない、またはnullの場合
            return const Center(child: Text('ユーザー情報がありません。'));
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          'ようこそ、${user.username}さん！',
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '現在の星の数: ${user.stars}個',
                          style: Theme.of(context).textTheme.titleLarge,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                const Text(
                  '段を選んでチャレンジ！',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.2,
                  ),
                  itemCount: 9,
                  itemBuilder: (context, index) {
                    final table = index + 1;
                    return ElevatedButton(
                      onPressed: () {
                        ref
                            .read(
                              multiplicationChallengeNotifierProvider.notifier,
                            )
                            .startChallenge(table, 10);
                        GoRouter.of(context).go('/challenge');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.lightBlue[100 * table], // 段ごとに色を変える
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        '$tableの段',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),
                const Text(
                  'ランダムチャレンジ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    ref
                        .read(multiplicationChallengeNotifierProvider.notifier)
                        .startChallenge(0, 10); // 0でランダム
                    GoRouter.of(context).go('/challenge');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purpleAccent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: const Text(
                    'ランダム10問に挑戦！',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('エラー: $err')),
      ),
    );
  }
}

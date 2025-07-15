import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:multiplication_app/common/widgets/user_summary_card.dart';
import '../providers/multiplication_challenge_provider.dart';
import '../providers/user_provider.dart';

class MultiplicationSelectionPage extends ConsumerWidget {
  const MultiplicationSelectionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsyncValue = ref.watch(userNotifierProvider);
    final challengeNotifierState = ref.watch(
      multiplicationChallengeNotifierProvider,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('くくべん')),
      body: userAsyncValue.when(
        data: (user) {
          if (user == null) {
            return const Center(child: Text('ユーザー情報がありません。'));
          }

          final bool isOverallLoading = challengeNotifierState.isLoading;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
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
                    final bool isTableCompleted = user.completedTables.contains(
                      table,
                    );

                    return ElevatedButton(
                      onPressed: isOverallLoading
                          ? null
                          : () {
                              ref
                                  .read(
                                    multiplicationChallengeNotifierProvider
                                        .notifier,
                                  )
                                  .startChallenge(table, 9);
                              GoRouter.of(context).go('/challenge');
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isTableCompleted
                            ? Colors
                                  .lightGreen
                                  .shade100 // 獲得済みは別の色に
                            : Colors.green[100 * table],
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Column(
                        // ★修正: Stack から Column に変更★
                        mainAxisAlignment:
                            MainAxisAlignment.center, // コンテンツを垂直方向中央に配置
                        crossAxisAlignment:
                            CrossAxisAlignment.center, // コンテンツを水平方向中央に配置
                        mainAxisSize:
                            MainAxisSize.min, // Column のサイズをコンテンツに合わせて最小限にする
                        children: [
                          Text(
                            '$tableの段',
                            textAlign: TextAlign.center, // テキストを中央揃えにする
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (isTableCompleted) ...[
                            // ★修正: 星がある場合のみ表示★
                            const SizedBox(height: 5), // テキストと星の間に少しスペースを追加
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 24,
                            ),
                          ],
                        ],
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
                  // isOverallLoading が true の間はボタンを無効化
                  onPressed: isOverallLoading
                      ? null
                      : () {
                          ref
                              .read(
                                multiplicationChallengeNotifierProvider
                                    .notifier,
                              )
                              .startChallenge(0, 10); // ランダムの場合、countは10
                          GoRouter.of(context).go('/challenge');
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: isOverallLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'ランダム10問に挑戦！',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
                if (challengeNotifierState.isLoading)
                  const Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                if (challengeNotifierState.hasError)
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Center(
                      child: Text(
                        '問題設定エラー: ${challengeNotifierState.error}',
                        style: const TextStyle(color: Colors.red),
                      ),
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

import 'package:flutter/material.dart';
import 'package:multiplication_app/features/multiplication/domain/entities/user/user.dart';

/// ユーザーの概要情報を表示する共通カードウィジェット
class UserSummaryCard extends StatelessWidget {
  final User user;
  final CrossAxisAlignment crossAxisAlignment; // テキストの水平方向の配置
  final String title; // カードのタイトル（例: 「ようこそ、〜さん！」または「ユーザー名: 〜」）

  const UserSummaryCard({
    super.key,
    required this.user,
    required this.title,
    this.crossAxisAlignment = CrossAxisAlignment.center, // デフォルトは中央揃え
  });

  @override
  Widget build(BuildContext context) {
    // テーマから色Schemeを取得
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      elevation: 4, // CardThemeDataのデフォルト値
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16), // CardThemeDataのデフォルト値
      ),
      // 背景を単色に戻す（デフォルトのCardの色を使用）
      color: colorScheme.surface, // あるいはTheme.of(context).cardColor;

      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: crossAxisAlignment, // 指定された配置を適用
          children: [
            Text(
              title, // 引数で受け取ったタイトルを使用
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface, // テーマのonSurfaceカラーを使用
              ),
              textAlign: crossAxisAlignment == CrossAxisAlignment.center
                  ? TextAlign.center
                  : TextAlign.start,
            ),
            const SizedBox(height: 10), // タイトルとコンテンツの間のスペース
            // 提供されたコードブロックをここに入れる
            if (user.completedTables.isEmpty)
              Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Icon(
                        Icons.emoji_events,
                        size: 48,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'まだ達成した段位はありません。',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'チャレンジして星を獲得しましょう！',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontStyle: FontStyle.italic,
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurfaceVariant.withOpacity(0.7),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              )
            else
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, // よりコンパクトなグリッド
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1,
                ),
                itemCount: user.completedTables.length,
                itemBuilder: (context, index) {
                  final table = user.completedTables[index];
                  return Card(
                    elevation: 4,
                    color: Colors.amber[100 * (table % 9) + 100], // カラフルなカード
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.star, color: Colors.amber[700], size: 30),
                        Text(
                          '$tableの段',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.brown[900],
                              ),
                        ),
                      ],
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}

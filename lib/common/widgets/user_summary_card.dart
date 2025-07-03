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
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: crossAxisAlignment, // 指定された配置を適用
          children: [
            Text(
              title, // 引数で受け取ったタイトルを使用
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              textAlign: crossAxisAlignment == CrossAxisAlignment.center
                  ? TextAlign.center
                  : TextAlign.start,
            ),
            const SizedBox(height: 8),
            Text(
              '星の数: ${user.stars}個', // 共通のテキスト
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontSize: 20),
              overflow: TextOverflow.clip,
              maxLines: 1,
              textAlign: crossAxisAlignment == CrossAxisAlignment.center
                  ? TextAlign.center
                  : TextAlign.start,
            ),
            const SizedBox(height: 8),
            Text(
              '獲得済み段位: ${user.completedTables.isEmpty ? 'なし' : user.completedTables.join(', ')}',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: crossAxisAlignment == CrossAxisAlignment.center
                  ? TextAlign.center
                  : TextAlign.start,
            ),
          ],
        ),
      ),
    );
  }
}

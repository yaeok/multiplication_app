import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// アプリケーション全体のボトムナビゲーションバー
class AppBottomNavigationBar extends StatelessWidget {
  /// StatefulNavigationShell インスタンス
  final StatefulNavigationShell navigationShell;

  const AppBottomNavigationBar({super.key, required this.navigationShell});

  // onTap メソッド
  void _onTap(int index) {
    // goBranch を使用してブランチを切り替える
    // initialLocation: false を設定することで、同じブランチに再度移動してもスタックをリセットせず、状態を維持します。
    navigationShell.goBranch(index, initialLocation: false);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: navigationShell.currentIndex, // 現在のブランチのインデックス
      onTap: _onTap, // onTap メソッドを渡す
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.calculate), label: 'チャレンジ'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'アカウント'),
      ],
    );
  }
}

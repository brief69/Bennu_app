import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/providers/main_page_provider.dart';
import '/views/homepages/home_view.dart';
import '/views/searchpages/search_page.dart';
import '/views/postpages/poststep1/post_tab_modal.dart';
import 'cartpages/cart_view.dart';
import '/views/profilepages/profile_page.dart';


class MainPage extends ConsumerWidget { // MainPageクラスをConsumerWidgetとして定義
  final List<Widget> _children = [ // メインページの子ウィジェットをリストとして定義
    const HomeView(), // ホームビュー
    const SearchPage(), // 検索ページ
    const PostTabModal(), // 投稿タブモーダル
    const CartView(), // カートビュー
    const ProfilePage(), // プロフィールページ
  ];

  MainPage({Key? key}) : super(key: key); // MainPageクラスのコンストラクタ

  @override
  Widget build(BuildContext context, WidgetRef ref) { // buildメソッドをオーバーライド
    final viewModel = ref.watch(mainPageViewModelProvider); // ViewModelを監視
    final theme = Theme.of(context); // テーマを取得

    return Scaffold( // Scaffoldウィジェットを返す
      body: _children[viewModel.currentIndex], // 現在のインデックスに対応する子ウィジェットを表示
      bottomNavigationBar: BottomNavigationBar( // ボトムナビゲーションバーを定義
        onTap: viewModel.changeIndex, // タップ時にインデックスを変更
        currentIndex: viewModel.currentIndex, // 現在のインデックスを取得
        type: BottomNavigationBarType.fixed, // ナビゲーションバータイプを固定に設定
        backgroundColor: Theme.of(context).bottomAppBarTheme.color, // バックグラウンドカラーを設定
        selectedItemColor: theme.tabBarTheme.labelColor, // 選択されたアイテムの色を設定
        unselectedItemColor: theme.tabBarTheme.unselectedLabelColor, // 選択されていないアイテムの色を設定
          items: const [ // ナビゲーションバーアイテムを定義
            BottomNavigationBarItem( // ナビゲーションバーアイテムを定義
              icon: Icon(Icons.home), // アイコンを設定
              label: 'HOME', // ラベルを設定
            ),
            BottomNavigationBarItem( // ナビゲーションバーアイテムを定義
              icon: Icon(Icons.search), // アイコンを設定
              label: 'SEARCH', // ラベルを設定
            ),
            BottomNavigationBarItem( // ナビゲーションバーアイテムを定義
              icon: Icon(Icons.add_box), // アイコンを設定
              label: 'POST', // ラベルを設定
            ),
            BottomNavigationBarItem( // ナビゲーションバーアイテムを定義
              icon: Icon(Icons.shopping_cart), // アイコンを設定
              label: 'BOX', // ラベルを設定
            ),
            BottomNavigationBarItem( // ナビゲーションバーアイテムを定義
              icon: Icon(Icons.account_circle), // アイコンを設定
              label: 'PROFILE', // ラベルを設定
            ),
          ],
        ),
    );
  }
}


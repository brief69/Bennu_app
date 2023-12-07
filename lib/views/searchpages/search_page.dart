import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/viewmodels/search_viewmodel.dart';

// 検索ページのウィジェットを定義
class SearchPage extends ConsumerWidget {
  // コンストラクタ
  const SearchPage({Key? key}) : super(key: key);

  // ウィジェットのビルドメソッド
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    // 検索結果を取得
    final searchResult = ref.watch(searchProvider);

    // タブコントローラを使用したウィジェットを返す
    return DefaultTabController(
      length: 10,
      child: Scaffold(
        // アプリバーの設定
        appBar: AppBar(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          titleTextStyle: Theme.of(context).appBarTheme.titleTextStyle,
          // 検索フィールドの設定
          title: TextField(
            controller: ref.read(searchProvider).searchController,
            // 検索結果を取得するメソッドを呼び出す
            onSubmitted: (query) {
              ref.read(searchProvider).fetchSearchResults(query);
            },
            style: const TextStyle(color: Colors.black),
            decoration: const InputDecoration(
              fillColor: Colors.white,
              filled: true,
              hintText: 'Search...',
              hintStyle: TextStyle(color: Colors.grey),
              suffixIcon: Icon(Icons.search, color: Colors.grey),
            ),
          ),
          // タブバーの設定
          bottom: const TabBar(
            isScrollable: true, // タブバーをスクロール可能にする
            labelColor: Colors.white,
            tabs: [
              Tab(text: '新着'),
              Tab(text: '家電'),
              Tab(text: '本'),
              Tab(text: '箱'),
              Tab(text: 'カメラ'),
              Tab(text: 'おすすめ'),
              Tab(text: '優良'),
              Tab(text: 'Site'),
              Tab(text: 'Product'),
              Tab(text: 'User'),
            ],
          ),
        ),
        // タブバービューの設定
        body: TabBarView(
          children: [
            // 新着の検索結果を表示するグリッドビュー
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: searchResult.sites?.length ?? 0,
              itemBuilder: (context, index) {
                return Image.network(searchResult.sites?[index].imageUrl ?? '');
              },
            ),
            // 家電の検索結果を表示するグリッドビュー
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: searchResult.products?.length ?? 0,
              itemBuilder: (context, index) {
                return Image.network(searchResult.products?[index].imageUrl ?? '');
              },
            ),
            // 本の検索結果を表示するグリッドビュー
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: searchResult.users?.length ?? 0,
              itemBuilder: (context, index) {
                return Image.network(searchResult.users?[index].profileImageUrl ?? '');
              },
            ),
            // 箱の検索結果を表示するグリッドビュー
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: searchResult.sites?.length ?? 0,
              itemBuilder: (context, index) {
                return Image.network(searchResult.sites?[index].imageUrl ?? '');
              },
            ),
            // カメラの検索結果を表示するグリッドビュー
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: searchResult.products?.length ?? 0,
              itemBuilder: (context, index) {
                return Image.network(searchResult.products?[index].imageUrl ?? '');
              },
            ),
            // おすすめの検索結果を表示するグリッドビュー
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: searchResult.users?.length ?? 0,
              itemBuilder: (context, index) {
                return Image.network(searchResult.users?[index].profileImageUrl ?? '');
              },
            ),
            // 優良の検索結果を表示するグリッドビュー
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: searchResult.sites?.length ?? 0,
              itemBuilder: (context, index) {
                return Image.network(searchResult.sites?[index].imageUrl ?? '');
              },
            ),
            // サイトの検索結果を表示するグリッドビュー
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: searchResult.sites?.length ?? 0,
              itemBuilder: (context, index) {
                return Image.network(searchResult.sites?[index].imageUrl ?? '');
              },
            ),
            // 製品の検索結果を表示するグリッドビュー
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: searchResult.products?.length ?? 0,
              itemBuilder: (context, index) {
                return Image.network(searchResult.products?[index].imageUrl ?? '');
              },
            ),
            // ユーザーの検索結果を表示するグリッドビュー
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: searchResult.users?.length ?? 0,
              itemBuilder: (context, index) {
                return Image.network(searchResult.users?[index].profileImageUrl ?? '');
              },
            ),
          ],
        ),
      ),
    );
  }
}

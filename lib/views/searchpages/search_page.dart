

// search_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../viewmodels/search_viewmodel.dart';


class SearchPage extends ConsumerWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final searchResult = ref.watch(searchProvider);
    final theme = Theme.of(context); 

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          titleTextStyle: Theme.of(context).appBarTheme.titleTextStyle,
          title: TextField(
            controller: ref.read(searchProvider).searchController,
            onSubmitted: (query) {
              ref.read(searchProvider).fetchSearchResults(query);
            },
            style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
          ),
          bottom: const TabBar(
            labelColor: Colors.white,
            tabs: [
              Tab(text: 'Site'),
              Tab(text: 'Product'),
              Tab(text: 'User'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: searchResult.sites.length,
              itemBuilder: (context, index) {
                return Image.network(searchResult.sites[index].imageUrl);
              },
            ),
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: searchResult.products.length,
              itemBuilder: (context, index) {
                return Image.network(searchResult.products[index].imageUrl);
              },
            ),
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: searchResult.users.length,
              itemBuilder: (context, index) {
                return Image.network(searchResult.users[index].profileImageUrl);
              },
            ),
          ],
        ),
      ),
    );
  }
}

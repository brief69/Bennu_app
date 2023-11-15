

// main_page.dart
import 'package:bennu_app/providers/main_page_provider.dart';
import 'package:bennu_app/views/cart_view.dart';
import 'package:bennu_app/views/postpages/post_view.dart';
import 'package:bennu_app/views/profilepages/profile_page.dart';
import 'package:bennu_app/views/searchpages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bennu_app/views/homepages/home_view.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MainPage extends ConsumerWidget {
  final List<Widget> _children = [
    HomeView(),
    const SearchPage(),
    const PostView(),
    const CartView(),
    const ProfilePage(),
  ];

  MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(mainPageViewModelProvider);
    final theme = Theme.of(context);

    return Scaffold(
      body: _children[viewModel.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: viewModel.changeIndex,
        currentIndex: viewModel.currentIndex,
        type: BottomNavigationBarType.fixed,
        // ignore: deprecated_member_use
        backgroundColor: theme.bottomAppBarColor,
        selectedItemColor: theme.tabBarTheme.labelColor,
        unselectedItemColor: theme.tabBarTheme.unselectedLabelColor,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'HOME',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'SEARCH',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_box),
              label: 'POST',
            ),
            BottomNavigationBarItem(
              icon: Icon(MdiIcons.box),
              label: 'BOX',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'PROFILE',
            ),
          ],
        ),
    );
  }
}

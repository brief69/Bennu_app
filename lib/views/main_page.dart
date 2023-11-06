

// main_page.dart
import 'package:dms/viewmodels/mainpage_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bennu_app/views/homepages/home_view.dart';
import 'package:dms/views/search_page.dart';
import 'package:dms/views/postpages/post_view.dart';
import 'package:dms/views/box_view.dart';
import 'package:dms/views/profilepages/profile_page.dart';

class MainPage extends ConsumerWidget {
  final List<Widget> _children = [
    HomeView(),
    const SearchPage(),
    const PostView(),
    const BoxView(),
    const ProfilePage(),
  ];

  MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(mainPageViewModelProvider);

    return Scaffold(
      body: _children[viewModel.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: viewModel.changeIndex,
        currentIndex: viewModel.currentIndex,
        type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.white),
              backgroundColor: Color.fromARGB(255, 30, 1, 1),
              label: 'HOME',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search, color: Colors.white),
              backgroundColor: Color.fromARGB(255, 30, 1, 1),
              label: 'SEARCH',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_box, color: Colors.white),
              backgroundColor: Color.fromARGB(255, 30, 1, 1),
              label: 'POST',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat, color: Colors.white),
              backgroundColor: Color.fromARGB(255, 30, 1, 1),
              label: 'BOX',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle, color: Colors.white),
              backgroundColor: Color.fromARGB(255, 30, 1, 1),
              label: 'PROFILE',
            ),
          ],
        ),
    );
  }
}

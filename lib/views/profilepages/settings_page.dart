import 'package:bennu/views/profilepages/settingpages/contact_support_page.dart';
import 'package:bennu/views/profilepages/settingpages/edit_address_page.dart';
import 'package:flutter/material.dart';
import 'package:bennu/views/profilepages/settingpages/rules_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final settingsProvider = Provider<Settings>((ref) => Settings());

class Settings {
  final items = [
    {'title': 'Bennu Rules', 'page': const RulesPage()},
    {'title': 'Address Set', 'page': const AddressSetPage()},
    {'title': 'Contact', 'page': ContactPage()},
  ];
}

class SettingsPage extends ConsumerWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context); 
    final settings = ref.watch(settingsProvider);
    return Scaffold(
      // AppBarを設定
      appBar: AppBar(
        title: Text('Settings', style: theme.textTheme.titleLarge), 
        backgroundColor: theme.appBarTheme.backgroundColor,
      ),
      // 背景色をテーマのプライマリカラーに設定
      backgroundColor: Theme.of(context).primaryColor,
      // ボディには区切り線付きのリストビューを設定
      body: ListView.separated(
        // アイテムの数を3に設定
        itemCount: settings.items.length,
        // 区切り線のビルダーを定義
        separatorBuilder: (BuildContext context, int index) {
          // 区切り線の色をグレーに設定
          return const Divider(color: Colors.grey);
        },
        // アイテムのビルダーを定義
        itemBuilder: (BuildContext context, int index) {
          // ListTileウィジェットを返す
          return ListTile(
            // タイトルにはテキストウィジェットを設定
            title: Text(
              settings.items[index]['title'] as String,
              // テキストの色を白に設定
              style: const TextStyle(color: Colors.white),
            ),
            // タップ時には対応するページに遷移
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => settings.items[index]['page'] as Widget),
              );
            },
          );
        },
      ),
    );
  }
}


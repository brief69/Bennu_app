


// rules_page.dart
import 'package:flutter/material.dart';

class RulesPage extends StatelessWidget {
  const RulesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Bennu Rules', style: theme.textTheme.titleLarge),
        backgroundColor: theme.appBarTheme.backgroundColor,
          bottom: const TabBar(
            tabs: [
            Tab(text: 'Bennu User Rules'),
              Tab(text: 'Bennu Management Rules'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            UserRulesTab(),
            ManagementRulesTab(),
          ],
        ),
      ),
    );
  }
}

class UserRulesTab extends StatelessWidget {
  const UserRulesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        ListTile(
          title: Text('正直に取引を行いましょう。'),
        ),
        ListTile(
          title: Text('実際に新品かどうかよりも、使えるかどうかを重視する。'),
        ),
        ListTile(
          title: Text('Bennuは、完全に民主制の取引アプリです。'),
        ),
        ListTile(
          title: Text('商品を売る人も商品を買う人も、自分の判断で取引を行うことができるということです。'),
        ),
        ListTile(
          title: Text('取引トラブルが起これば、コメントに書く、書かれる'),
        ),
        ListTile(
          title: Text('相手に多くを求めなすぎないこと'),
        ),
        ListTile(
          title: Text('Bennuには複利があります。商品は定価の半額にすること'),
        ),
        ListTile(
          title: Text('個人の発明家が、商品を販売して良い(※ただし、以下に注意)'),
        ),
        ListTile(
          title: Text('コメントのbadボタンは、コメントがステマだと判断した時に押す'),
        ),
        ListTile(
          title: Text('badボタンが一定以上になると、アカウント停止、収益没収の対象です')
        ),
      ],
    );
  }
}

class ManagementRulesTab extends StatelessWidget {
  const ManagementRulesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        ListTile(
          title: Text('運営ルール1'),
        ),
        ListTile(
          title: Text('運営ルール2'),
        ),
        ListTile(
          title: Text('運営ルール3'),
        ),
        ListTile(
          title: Text('運営ルール4'),
        ),
        ListTile(
          title: Text('運営ルール5'),
        ),
        ListTile(
          title: Text('運営ルール6'),
        ),
        ListTile(
          title: Text('運営ルール7'),
        ),
        ListTile(
          title: Text('運営ルール8'),
        ),
        ListTile(
          title: Text('運営ルール9'),
        ),
      ],
    );
  }
}
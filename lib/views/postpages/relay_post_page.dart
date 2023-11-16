

// relay_post_page.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../widgets/postbuttonwidgets/repost_button_widget.dart';

class RelayPostPage extends StatefulWidget {
  const RelayPostPage({super.key});

  @override
  RelayPostPageState createState() => RelayPostPageState();
}

class RelayPostPageState extends State<RelayPostPage> {
  List<DocumentSnapshot>? _buyHistory; // Lists holding purchase history data

  @override
  void initState() {
    super.initState();
    buyHistory();
  }

  buyHistory() async {
    // buyHistoryコレクションから購入履歴を取得するとします。
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('buyHistory').get();
    setState(() {
      _buyHistory = snapshot.docs;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Add RePost', style: theme.textTheme.titleLarge),
        backgroundColor: theme.appBarTheme.backgroundColor,
      ),
      body: Padding(
        padding:  const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
              backgroundColor: theme.primaryColor,
              ),
              onPressed: () {
                // Display purchase history in modal
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                      itemCount: _buyHistory?.length ?? 0,
                      itemBuilder: (context, index) {
                        // ここで_mediaUrlはFirestoreの構造に依存するので、適切なフィールド名に変更してください。
                        String mediaUrl = _buyHistory![index]['mediaUrl'];
                        return GestureDetector(
                          onTap: () {
                            // 選択したアイテムの処理を実装する
                            Navigator.pop(context); // モーダルを閉じる
                          },
                          child: Image.network(mediaUrl), // 画像を表示する
                        );
                      },
                    );
                  },
                );
              },
              child:  Text(
                '購入履歴を選択', 
                style: theme.textTheme.labelLarge
              ), 
            ),
            TextField(
              decoration: InputDecoration(
                hintText: '変わった点を記載する',
                hintStyle: theme.textTheme.bodyMedium,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                hintText: '異なる点を説明する',
                hintStyle: theme.textTheme.bodyMedium,
              ),
            ),
            const Spacer(),
              const RePostButton(),
          ],
        ),
      ),
    );
  }
}


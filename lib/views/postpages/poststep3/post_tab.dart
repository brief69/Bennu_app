import 'package:bennu/viewmodels/post_viewmodel.dart';
import 'package:bennu/widgets/input_field_widget.dart';
import 'package:bennu/widgets/video_preview_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bennu/widgets/postbuttonwidgets/post_button_widget.dart';
import 'package:bennu/widgets/actionwidgets/simple_count_widget.dart';
import '/widgets/postbuttonwidgets/price_edit_widget.dart';
import '/viewmodels/postwidgetviewmodels/price_edit_viewmodel.dart'; 
import 'dart:io';


class PostTab extends StatelessWidget { // PostTabクラスを定義。StatelessWidgetを継承
  final File videoData; 
  final TextEditingController captionController = TextEditingController(); // キャプション用のTextEditingControllerを作成
  final TextEditingController stockController = TextEditingController(); // 在庫用のTextEditingControllerを作成
  final String userId; // ユーザーIDを保持

  PostTab({super.key, required this.videoData, required this.userId});

  @override
  Widget build(BuildContext context) { // buildメソッドオーバーライド
    final theme = Theme.of(context);  // テーマデータを取得
    return Scaffold( // Scaffoldウィジェットを返す
      appBar: AppBar( // AppBarを設定
        title: Text('Post', style: theme.textTheme.titleLarge), // タイトルを設定
        backgroundColor: theme.appBarTheme.backgroundColor, // AppBarの背景色を設定
      ),
      body: ListView( // bodyにListViewを設定
        children: <Widget>[ // 子ウィジェットのリストを設定
          VideoPreviewWidget(videoFile: videoData),
          InputField(
          controller: captionController,
          hint: 'Caption',
          maxLines: 3,
          ),
          const PriceEditWidget(), // 価格編集ウィジェット
          SimpleCountWidget( // シンプルカウントウィジェットを追加
            initialCount: 0, // 初期カウントを0に設定
            onCountChanged: (count) { // カウントが変更されたときの処理を設定
              stockController.text = count.toString(); // 在庫数を更新
            },
          ),
        ],
      ),

      floatingActionButton: 
      Consumer( // Consumerウィジェットを追加
        builder: (BuildContext context, WidgetRef ref, Widget? child) { // builderメソッドを定義
          final postViewModel = ref.watch(postViewModelProvider.notifier); // PostViewModelをウォッチ
          final product = ref.watch(priceEditViewModelProvider); // PriceEditViewModelから価格と通貨情報を取得
          return PostButton( // PostButtonを返す
            onPressed: () async { // 押下時の処理を定義
              int stock;
              try {
                stock = int.parse(stockController.text); // 在庫数を取得
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Invalid stock input')),
                );
                return;
              }

              // プログレスインジケーターを表示
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return const Center(child: CircularProgressIndicator());
                },
              );

              // isPriceInBerryをPriceEditViewModelから取得
              bool isPriceInBerry = product.isPriceInBerry;

              await postViewModel.uploadMediaAndCaption( // メディアとキャプションをアップロード
                videoData,
                userId, // ユーザーIDを指定
                captionController.text,  // キャプションを指定
                product.price, // 価格を指定
                stock, // 在庫数を指定
                isPriceInBerry // 価格がベリーであるかどうかを指定

              );
              // プログレスインジケーターを非表示にし、画面を閉じる
              // ignore: use_build_context_synchronously
              Navigator.pop(context); // プログレスダイアログを閉じる
              // ignore: use_build_context_synchronously
              Navigator.pop(context); // ホーム画面に戻る
            }
          );
        },
      ),
    );
  }
}

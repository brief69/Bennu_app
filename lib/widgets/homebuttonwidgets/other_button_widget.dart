import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/viewmodels/widgetsviewmodels/other_viewmodel.dart';


class OtherWidget extends StatelessWidget { // StatelessWidgetを継承したOtherWidgetクラスを定義します。
  const OtherWidget({Key? key}) : super(key: key); // コンストラクタを定義します。

  @override
  Widget build(BuildContext context) { // ウィジェットをビルドするメソッドを定義します。
    return Consumer( // Consumerウィジェットを使用して、Riverpodの状態を購読します。
      builder: (context, ref, child) { // ビルダーを定義します。
        final viewModel = ref.watch(otherViewModelProvider); // OtherViewModelの状態を購読します。
    
    return PopupMenuButton<String>( // PopupMenuButtonを作成します。
      onSelected: (String result) { // メニュー項目が選択されたときの処理を定義します。
        viewModel.handleMenuAction(result); // 選択されたメニュー項目に対応するアクションを実行します。
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[ // メニュー項目を作成します。
        const PopupMenuItem<String>( // PopupMenuItemを作成します。
          value: 'report', // メニュー項目の値を設定します。
          child: Text('報告'), // メニュー項目のテキストを設定します。
        ),
        const PopupMenuItem<String>( // PopupMenuItemを作成します。
          value: 'block', // メニュー項目の値を設定します。
          child: Text('通報'), // メニュー項目のテキストを設定します。
        ),
        const PopupMenuItem<String>( // PopupMenuItemを作成します。
          value: 'hide', // メニュー項目の値を設定します。
          child: Text('表示しない'), // メニュー項目のテキストを設定します。
        ),
      ],
      icon: const Icon(Icons.more_horiz),  // メニューボタンのアイコンを設定します。
    );
  },
    );
  }
}

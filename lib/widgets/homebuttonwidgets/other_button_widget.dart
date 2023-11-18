

// other_button_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../viewmodels/widgetsviewmodels/other_viewmodel.dart';

class OtherWidget extends StatelessWidget {
  const OtherWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final viewModel = ref.watch(otherViewModelProvider);
    
    return PopupMenuButton<String>(
      onSelected: (String result) {
        viewModel.handleMenuAction(result);
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'report',
          child: Text('報告'),
        ),
        const PopupMenuItem<String>(
          value: 'block',
          child: Text('通報'),
        ),
        const PopupMenuItem<String>(
          value: 'hide',
          child: Text('表示しない'),
        ),
      ],
      icon: const Icon(Icons.more_horiz), 
    );
  },
    );
  }
}

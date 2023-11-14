

// bell_tab_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/widgetsviewmodels/bell_viewmodel.dart';

class BellTabWidget extends ConsumerWidget {
  const BellTabWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(bellTabViewModelProvider);

    return StreamBuilder<int>(
      stream: viewModel.unreadNotificationsCount,
      builder: (context, snapshot) {
        final count = snapshot.data ?? 0;
        return InkWell(
          onTap: () => _showNotificationsPopup(context, viewModel),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(Icons.notifications, color: Theme.of(context).iconTheme.color),
              if (count > 0)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text('$count', style: const TextStyle(color: Colors.white, fontSize: 10)),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  void _showNotificationsPopup(BuildContext context, BellTabViewModel viewModel) {
    // 通知のポップアップを表示するロジック
  }
}

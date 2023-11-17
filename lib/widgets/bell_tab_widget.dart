

// bell_tab_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/widgetsviewmodels/bell_viewmodel.dart';
// ignore: library_prefixes
import 'package:bennu_app/models/notification.dart' as modelNotification;

class BellTabWidget extends ConsumerWidget {
  const BellTabWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(bellTabViewModelProvider);

    return FutureBuilder<int>(
      future: viewModel.unreadNotificationsCount,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
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
  showDialog(
    context: context,
    builder: (BuildContext context) {
      final theme = Theme.of(context);
      return AlertDialog(
        title: Text('Notifications', style: theme.textTheme.titleLarge),
        content: FutureBuilder<List<modelNotification.Notification>>(
          future: viewModel.getNotifications(), // 通知リストの取得
          builder: (BuildContext context, AsyncSnapshot<List<modelNotification.Notification>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(); // ローディングインジケータ
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}', style: theme.textTheme.titleMedium); // エラー表示
            } else if (snapshot.hasData) {
              // 通知リストの表示
              return ListView(
                children: snapshot.data!.map((notification) {
                  return ListTile(
                    title: Text(notification.title, style: theme.textTheme.titleMedium),
                    subtitle: Text(notification.body, style: theme.textTheme.bodyMedium),
                  );
                }).toList(),
              );
            } else {
              return const Text('No notifications'); // 通知がない場合
            }
          },
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Close', style: theme.textTheme.labelLarge),
            onPressed: () {
              Navigator.of(context).pop(); // ダイアログを閉じる
            },
          ),
        ],
      );
    },
  );
}
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bennu/viewmodels/settingviewmodels/contact_viewmodel.dart';

final contactViewModelProvider = ChangeNotifierProvider<ContactViewModel>((ref) => ContactViewModel());

class ContactPage extends ConsumerWidget {
  ContactPage({Key? key}) : super(key: key);

  final contactController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final viewModel = ref.watch(contactViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts', style: theme.textTheme.titleLarge),
        backgroundColor: theme.appBarTheme.backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Your FeedBack:', style: TextStyle(color: Colors.black, fontSize: 16)),
            const SizedBox(height: 8.0),
            Expanded(
              child: TextField(
                controller: contactController,
                maxLines: 10,
                decoration: const InputDecoration(
                  hintText: 'こちらにフィードバックを入力してください...',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 12.0),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  await viewModel.sendFeedback(contactController.text);
                  contactController.clear();
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                },
                child: const Text('送信', style: TextStyle(color: Colors.white)),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: viewModel.contactViaTwitter,
                child: const Text('Twitterで問い合わせる', style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        )
      ),
    );
  }
}

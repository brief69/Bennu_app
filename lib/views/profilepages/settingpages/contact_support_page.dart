

// contact_support_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../viewmodels/settingviewmodels/contact_viewmodel.dart';


class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  ContactPageState createState() => ContactPageState();
}

class ContactPageState extends State<ContactPage> {
  final contactController = TextEditingController();

  @override
  void dispose() {
    contactController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<ContactViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('CONTACT', style: TextStyle(color: Colors.white)),// TODO: #7 themeを使用して
        backgroundColor: const Color.fromARGB(255, 90, 0, 0),
      ),// TODO: #5 themeを使用するように変更して
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
                child: const Text('送信'),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: viewModel.contactViaTwitter,
                child: const Text('Twitterで問い合わせる'),
              ),
            )
          ],
        )
      ),
    );
  }
}

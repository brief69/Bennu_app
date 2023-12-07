import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditEmailPage extends StatefulWidget {
  const EditEmailPage({super.key});

  @override
  EditEmailPageState createState() => EditEmailPageState();
}

class EditEmailPageState extends State<EditEmailPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  Future<void> _updateEmail() async {
    try {
      // Re-authenticate the user
      final user = _auth.currentUser;
      final credential = EmailAuthProvider.credential(
        email: user!.email!,
        password: _passwordController.text,
      );
      await user.reauthenticateWithCredential(credential);

      // Update email
      await user.updateEmail(_emailController.text);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('メールアドレスを更新しました！')),
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('エラー: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('メールアドレス', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('新しいメールアドレス:', style: TextStyle(color: Colors.black)),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                hintText: 'example@example.com',
              ),
            ),
            const SizedBox(height: 8.0),
            const Text('現在のパスワードを入力:', style: TextStyle(color: Colors.black)),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: '******',
              ),
            ),
            const SizedBox(height: 12.0),
            ElevatedButton(
              onPressed: _updateEmail,
              child: const Text('更新'),
            ),
          ],
        ),
      ),
    );
  }
}

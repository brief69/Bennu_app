


// registration_view.dart
import 'package:bennu_app/viewmodels/registration_viewmodel.dart';
import 'package:flutter/material.dart';

class RegistrationView extends StatefulWidget {
  const RegistrationView({super.key});

  @override
  RegistrationViewState createState() => RegistrationViewState();
}

class RegistrationViewState extends State<RegistrationView> {
  final _emailController = TextEditingController();
  final _viewModel = RegistrationViewModel();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('新規登録', style: theme.textTheme.titleLarge),
        backgroundColor: theme.appBarTheme.backgroundColor,
      body: Column(
          children: [
          TextField(controller: _emailController),
          ElevatedButton(
            onPressed: () {
              _viewModel.registerAndCreateWallet(_emailController.text);
            },
            child: const Text('Register'),
          ),
        ],
      ),
    );
  }
}

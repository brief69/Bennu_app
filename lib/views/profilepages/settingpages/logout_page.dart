

// logout_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dms/viewmodels/logout_viewmodel.dart';
import 'package:dms/models/logout_model.dart';

class LogoutPage extends StatelessWidget {
  const LogoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LogoutViewModel(LogoutModel()),
      child: Scaffold(
        body: Center(
          child: Consumer<LogoutViewModel>(
            builder: (_, viewModel, __) {
              return ElevatedButton(
                onPressed: viewModel.logOut,
                child: const Text('Log Out'),
              );
            },
          ),
        ),
      ),
    );
  }
}


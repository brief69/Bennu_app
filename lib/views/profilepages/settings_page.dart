

// settings_page.dart
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/profile_viewmodel.dart';
import 'settingpages/contact_support_page.dart';
import 'settingpages/delete_account_page.dart';
import 'settingpages/edit_address_page.dart';
import 'settingpages/logout_page.dart';
import 'settingpages/rules_page.dart';


class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); 
    return ChangeNotifierProvider(
      create: (_) => ProfileViewModel(),
      child: Consumer<ProfileViewModel>(
        builder: (_, viewModel, __) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: theme.appBarTheme.backgroundColor,
              title: Text('SETTINGS', style: theme.appBarTheme.titleTextStyle),
            ),
            backgroundColor: theme.colorScheme.background,
            body: ListView(
              children: [
                ListTile(
                  title: Text('Bennu Rules', style: theme.textTheme.bodyLarge),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const RulesPage()));
                  }
                ),
                ListTile(
                  title: Text('Address', style: theme.textTheme.bodyLarge),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const AddressSetPage()));
                  },
                ),
                ListTile(
                  title: Text('Contacts', style: theme.textTheme.bodyLarge),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ContactPage()));
                  },
                ),
                ListTile(
                  title: Text('Development', style: theme.textTheme.bodyLarge),
                  onTap: () async {
                    const url = 'https://github.com/brief69/dms_front';
                    // ignore: deprecated_member_use
                    if (await canLaunch(url)) {
                      // ignore: deprecated_member_use
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                  ),
                  child: Text('Log Out', style: theme.textTheme.labelLarge),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const LogoutPage()));
                  }
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                  ),
                  child: Text('Delete Account', style: theme.textTheme.labelLarge),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const DeleteAccountPage()));
                  }
                ),
              ],
            ),
          );
        }
      )
    );
  }
}

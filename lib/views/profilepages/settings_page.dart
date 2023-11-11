

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
    return ChangeNotifierProvider(
      create: (_) => ProfileViewModel(),
      child: Consumer<ProfileViewModel>(
        builder: (_, viewModel, __) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(255, 0, 13, 3),
              title: const Text('SETTINGS', style: TextStyle(color: Colors.white)),
            ),
            backgroundColor: Colors.white,
            body: ListView(
              children: [
                ListTile(
                  title: const Text('Bennu Rules', style: TextStyle(color: Colors.black)),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const RulesPage()));
                  }
                ),
                ListTile(
                  title: const Text('Address', style: TextStyle(color: Colors.black)),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const AddressSetPage()));
                  },
                ),
                const ListTile(
                  title: Text('Othher',  style: TextStyle(color: Colors.black, fontFamily: 'Roboto'),
                  ),
                  tileColor: Colors.grey,
                ),
                ListTile(
                  title: const Text('Contacts'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ContactPage()));
                  },
                ),
                ListTile(
                  title: const Text('Development'),
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
                  child: const Text('Log Out', style: TextStyle(color: Colors.black)),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const LogoutPage()));
                  }
                ),
                ElevatedButton(
                  child: const Text('Delete Account', style: TextStyle(color: Colors.black)),
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



// followers_page.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FollowersPage extends StatelessWidget {
  final String uid;
  const FollowersPage({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Followers')),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('users').doc(uid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          final followersList = (snapshot.data?.data() as Map<String, dynamic>)['followers'] as List<dynamic>;

          return ListView.builder(
            itemCount: followersList.length,
            itemBuilder: (context, index) {
              return ListTile(title: Text(followersList[index]));
            },
          );
        },
      ),
    );
  }
}

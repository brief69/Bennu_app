

// following_page.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FollowingPage extends StatelessWidget {
  final String uid;
  const FollowingPage({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Following')),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('users').doc(uid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          final followingList = (snapshot.data?.data() as Map<String, dynamic>)['following'] as List<dynamic>;

          return ListView.builder(
            itemCount: followingList.length,
            itemBuilder: (context, index) {
              return ListTile(title: Text(followingList[index]));
            },
          );
        },
      ),
    );
  }
}

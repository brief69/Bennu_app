

// following_page.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FollowingPage extends StatelessWidget {
  final String uid;
  const FollowingPage({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); 
    return Scaffold(
      appBar: AppBar(
        title: Text('Following', style: theme.appBarTheme.titleTextStyle),
        backgroundColor: theme.appBarTheme.backgroundColor,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('users').doc(uid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: theme.primaryColor),
            );
          }
          final followingList = (snapshot.data?.data() as Map<String, dynamic>)['following'] as List<dynamic>;

          return ListView.builder(
            itemCount: followingList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  followingList[index],
                  style: theme.textTheme.bodyLarge,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

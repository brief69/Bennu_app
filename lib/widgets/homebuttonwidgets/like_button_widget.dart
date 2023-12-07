import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LikeButtonWidget extends StatefulWidget {
  final String postId;
  final String userId;

  const LikeButtonWidget({Key? key, required this.postId, required this.userId}) : super(key: key);

  @override
  LikeButtonWidgetState createState() => LikeButtonWidgetState();
}

class LikeButtonWidgetState extends State<LikeButtonWidget> {
  late bool _isLiked;

  @override
  void initState() {
    super.initState();
    _checkIfUserLikedPost();
  }

void _checkIfUserLikedPost() async {
  DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(widget.userId).get();
  Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
  List likedPosts = userData['likedPosts'] ?? [];
  setState(() {
    _isLiked = likedPosts.contains(widget.postId);
  });
}

void _toggleLike() async {
  final DocumentReference postRef = FirebaseFirestore.instance.collection('posts').doc(widget.postId);

  FirebaseFirestore.instance.runTransaction((transaction) async {
    DocumentSnapshot postSnapshot = await transaction.get(postRef);
    if (!postSnapshot.exists) {
      throw Exception("Post does not exist!");
    }

    Map<String, dynamic> postData = postSnapshot.data() as Map<String, dynamic>;
    int newLikeCount = postData['likeCount'] ?? 0;
    transaction.update(postRef, {
      'likeCount': _isLiked ? newLikeCount - 1 : newLikeCount + 1,
    });

    DocumentReference userRef = FirebaseFirestore.instance.collection('users').doc(widget.userId);
    DocumentSnapshot userSnapshot = await transaction.get(userRef);
    Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;
    List likedPosts = userData['likedPosts'] ?? []; 

    if (_isLiked) {
      likedPosts.remove(widget.postId);
    } else {
      likedPosts.add(widget.postId);
    }

    transaction.update(userRef, {
      'likedPosts': likedPosts,
    });
  });

  setState(() {
    _isLiked = !_isLiked;
  });
}

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection('posts').doc(widget.postId).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }
        int likeCount = snapshot.data?['likeCount'] ?? 0;
        return GestureDetector(
          onTap: _toggleLike,
          child: Column(
            children: [
              Icon(
                _isLiked ? Icons.favorite : Icons.favorite_border,
                color: _isLiked ? Colors.pink : Theme.of(context).iconTheme.color,
              ),
              Text('$likeCount'),
            ],
          ),
        );
      },
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/homewidgetmodels/media_model.dart';

class MediaViewModel {
  final MediaModel media;

  // FirestoreドキュメントからMediaViewModelを作成するためのファクトリメソッド
  MediaViewModel.fromDocument(DocumentSnapshot doc)
    : media = MediaModel(
        videoUrl: doc['videoUrl'],
        userIcon: doc['userIcon'],
        likes: doc['likes'],
        comments: doc['comments'],
        other: doc['other'],
        buy: doc['buy'],
        incart: doc['incart'],
        shares: doc['shares'],
        caption: doc['caption'],
        stock: doc['stock'],
        price: doc['price'],
        relay: doc['relay'],
        mediaItems: doc['mediaItems'], 
        postId: '', 
        userId: '',
        firestore: FirebaseFirestore.instance,
      );

    MediaViewModel(this.media);

    String get videoUrl => media.videoUrl;
    String get userIcon => media.userIcon;
    int get likes => media.likes;
    String get caption => media.caption;
    int get stock => media.stock;
    int get price => media.price;
    String get postId => media.postId;
    String get userId => media.userId;
    String get id => userId;
    // ignore: recursive_getters
    DateTime get purchaseDate => purchaseDate;
}
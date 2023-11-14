
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/currency.dart';
import '../models/post.dart';
// ignore: library_prefixes
import '../models/transaction.dart' as myTransaction;


final postViewModelProvider = StateNotifierProvider<PostViewModel, List<XFile?>>((ref) => PostViewModel());

class PostViewModel extends StateNotifier<List<XFile?>> {
  PostViewModel() : super([]);

  final ImagePicker _picker = ImagePicker();
  String _caption = "";
  Currency? selectedCurrency;
  int stock = 0;
  
  void setCaption(String value) {
    _caption = value;
  }

  void setSelectedCurrency(Currency value) {
    selectedCurrency = value;
  }

  void setStock(String value) {
    if (int.tryParse(value) != null && int.parse(value) <= 1000) {
      stock = int.parse(value);
    }
  }

  void increaseStock() {
    if (stock < 1000) {
      stock++;
    }
  }

  void decreaseStock() {
    if (stock > 0) {
      stock--;
    }
  }

  Future<void> pickMediaFromGallery() async {
    List<XFile?> medias = await _picker.pickMultiImage();
    if (medias.length <= 6) {
      state = medias;
    }
  }

  Future<void> captureMediaWithCamera() async {
    XFile? media = await _picker.pickVideo(source: ImageSource.camera, maxDuration: const Duration(minutes: 1));
    if (media != null) {
      state = [media];
    }
  }

  Future<String?> uploadMediaToFirebase(XFile media) async {
    XFile file = File(media.path) as XFile;
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child("uploads/${DateTime.now().millisecondsSinceEpoch}");
    UploadTask uploadTask = ref.putFile(file as File);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => {});
    String? downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> uploadMediaAndCaption() async {
    List<String> mediaUrls = [];
    for (XFile? media in state) {
      if (media != null) {
        String? mediaUrl = await uploadMediaToFirebase(media);
        if (mediaUrl != null) mediaUrls.add(mediaUrl);
      }
    }

    final post = Post(
      caption: _caption,
      mediaUrls: mediaUrls,
      postDate: DateTime.now(),
      userIcon: '',
      likesCount: 0,
      commentsCount: 0,
      buyCount: 0,
      inCart: 0,
      shareCount: 0,
      price: 0,
      stock: stock,
      relayCount: 0,
      originalSeller: '',
      currentSeller:  '', 
      transactionHistory: [],
    );

    FirebaseFirestore.instance.collection('posts').add(post.toMap());
  }

  Future<void> purchaseItem(String itemId, String buyerId) async {
    DocumentReference postRef = FirebaseFirestore.instance.collection('posts').doc(itemId);
    DocumentSnapshot postSnapshot = await postRef.get();
    if (!postSnapshot.exists) {
      throw Exception('Post not found');
    }
    Post post = Post.fromMap(postSnapshot.data() as Map<String, dynamic>);

    myTransaction.Transaction newTransaction = myTransaction.Transaction(
      seller: post.currentSeller,
      buyer: buyerId,
      timestamp: DateTime.now(),
    );

    post.currentSeller = buyerId;
    post.transactionHistory.add(newTransaction as Transaction);

    await postRef.update(post.toMap());
  }

  Future<void> reListPost(String postId, String sellerId) async {
    DocumentReference postRef = FirebaseFirestore.instance.collection('posts').doc(postId);
    DocumentSnapshot postSnapshot = await postRef.get();
    if (!postSnapshot.exists) {
      throw Exception('Post not found');
    }
    Post post = Post.fromMap(postSnapshot.data() as Map<String, dynamic>);

    post.currentSeller = sellerId;

    await postRef.update(post.toMap());
  }

}

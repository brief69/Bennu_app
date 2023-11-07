

// media_viewmodel.dart
import '../models/media_model.dart';

class MediaViewModel {
  final MediaModel media;

  MediaViewModel(this.media);
  String get videoUrl => media.videoUrl;
  String get userIcon => media.userIcon;
  int get likes => media.likes;
  int get comments => media.comments;
  String get other => media.other;
  int get buy => media.buy;
  int get incart => media.incart;
  int get shares => media.shares;
  String get caption => media.caption;
  int get stock => media.stock;
  int get price => media.price;
  int get relay => media.relay;

  

  List<dynamic> get mediaItems => media.mediaItems;

  get postId => null;

  get userId => null;
}



import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'media_viewmodel.dart';

class MediaViewModelNotifier extends StateNotifier<List<MediaViewModel>> {
  MediaViewModelNotifier() : super([]);

  Future<void> fetchRecommendedPosts() async {
    // おすすめ投稿を取得して状態を更新
  }

  Future<void> fetchFollowedPosts() async {
    // フォロー中の投稿を取得して状態を更新
  }
}

final mediaViewModelProvider = StateNotifierProvider<MediaViewModelNotifier, List<MediaViewModel>>(
  (ref) => MediaViewModelNotifier(),
);

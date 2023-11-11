

// main_page_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/main_page_viewmodel.dart';

final mainPageViewModelProvider = ChangeNotifierProvider<MainPageViewModel>((ref) {
  return MainPageViewModel();
});

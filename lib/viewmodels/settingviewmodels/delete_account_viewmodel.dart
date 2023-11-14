

// delete_account_viewmodel.dart
import '../../models/user.dart';

class DeleteAccountViewModel {
  final _userModel = 
    User(
      id: '',
      userIcon: '', 
      userName: '', 
      solanaAddress: '', 
      postHistory: [], 
      likesHistory: [], 
      buyHistory: [], 
      followingCount: 0, // ここに初期値を設定
      followerCount: 0,  // ここに初期値を設定
    );

  Future<bool> deleteAccount() async {
    return await _userModel.deleteCurrentUser();
  }
}

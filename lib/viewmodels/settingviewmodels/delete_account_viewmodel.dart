

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
      followingCount: ,
      followerCount: ,
    );

  Future<bool> deleteAccount() async {
    return await _userModel.deleteCurrentUser();
  }
}

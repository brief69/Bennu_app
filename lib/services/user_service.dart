import 'package:bennu/widgets/actionwidgets/berry_pay_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  // ユーザープロフィールをキャッシュに保存する関数
  Future<void> cacheUserProfile(UserProfile profile) async {
    // SharedPreferencesのインスタンスを取得
    final prefs = await SharedPreferences.getInstance();
    // ユーザー名を保存
    await prefs.setString('username', profile.username);
    // Solanaアドレスを保存
    await prefs.setString('solanaAddress', profile.solanaAddress);
    // 他のプロフィール情報も同様に保存します。
  }
}
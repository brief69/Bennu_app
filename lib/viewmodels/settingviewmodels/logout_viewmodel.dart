import 'package:flutter/foundation.dart';
import '/models/settingmodels/logout_model.dart';


class LogoutViewModel extends ChangeNotifier {
  final LogoutModel _logoutModel;

  LogoutViewModel(this._logoutModel);

  Future<void> logOut() async {
      await _logoutModel.performLogout();
      notifyListeners();
    }
}

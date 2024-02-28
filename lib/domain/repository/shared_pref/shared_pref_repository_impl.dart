import 'package:flap_app/domain/repository/shared_pref/shared_pref_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefRepositoryImpl extends SharedPrefRepository {
  late SharedPreferences _sharedPrefs;
  @override
  init() async {
    _sharedPrefs = await SharedPreferences.getInstance();
  }

  @override
  Future<bool> isFirstAppLaunch() async {
    return _sharedPrefs.getBool("isFirstAppLaunch") ?? true;
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FSS {
  static const FlutterSecureStorage fss = FlutterSecureStorage();

  static const String TOKEN_KEY = "key.token";

  static Future<String> getToken() async {
    return await fss.read(key: TOKEN_KEY);
  }

  static Future<void> write({
    @required String key,
    @required String value,
  }) async {
    await fss.write(key: key, value: value);
  }

  static Future<String> read({@required String key}) async {
    return await fss.read(key: key);
  }

  static Future<void> deleteAll() async {
    await fss.deleteAll();
  }
}

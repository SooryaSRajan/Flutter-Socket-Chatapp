import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'constants.dart';

const storage = FlutterSecureStorage();

clearAllData() {
  storage.deleteAll();
}

///JWT
Future<String?> get jwtTokenGet async {
  return await storage.read(key: storageJWTKey);
}

set jwtTokenSet(String jwt) {
  storage.write(key: storageJWTKey, value: jwt);
}

///Name
Future<String> get getProfileName async {
  var name = await storage.read(key: nameKey);
  if (name == null) return "";
  return name;
}

set setProfileName(String name) {
  storage.write(key: nameKey, value: name);
}


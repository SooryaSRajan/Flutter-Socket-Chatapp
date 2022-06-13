import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'constants.dart';

const storage = FlutterSecureStorage();

clearAllData() {
  storage.deleteAll();
}

///JWT
Future<String> get jwtTokenGet async {
  var jwt = await storage.read(key: storageJWTKey);
  if (jwt == null) return "";
  return jwt;
}

set jwtTokenSet(String jwt) {
  storage.write(key: storageJWTKey, value: jwt);
}

///Name
Future<String> get getName async {
  var name = await storage.read(key: nameKey);
  if (name == null) return "";
  return name;
}

set setName(String name) {
  storage.write(key: nameKey, value: name);
}

///User ID
Future<String> get getUserId async {
  var userId = await storage.read(key: userIdKey);
  if (userId == null) return "";
  return userId;
}

set setUserId(String userId) {
  storage.write(key: userIdKey, value: userId);
}


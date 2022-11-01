import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

class User {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  Future<String?> getDeviceId() async{
    if(Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.id;
    }else {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.identifierForVendor;
    }
  }
}
// Dart imports:
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:developer' as dev;
// Package imports:
import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
// Project imports:
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:stacked_services/stacked_services.dart';

import 'app.locator.dart';

///
///

NavigationService get navigationService => locator<NavigationService>();

DialogService get dialogService => locator<DialogService>();

BottomSheetService get sheetService => locator<BottomSheetService>();

String getDeviceType() {
  String deviceType = '';
  if (Platform.isAndroid) {
    deviceType = '1';
  } else if (Platform.isIOS) {
    deviceType = '2';
  }
  return deviceType;
}

class GetGlobalVariable {
  static PackageInfo? packageInfo;
  static bool forceUpdate = true;
}

void printLog(value, {mode = kDebugMode, name = ''}) {
  switch (mode) {
    case kDebugMode:
      dev.log("$value", name: name);
      break;
    case kReleaseMode:
      dev.log("$value");
      break;
    case kIsWeb:
      dev.log("$value");
      break;
    case kProfileMode:
      dev.log("$value");
      break;
    default:
      dev.log('PrintLog: no mode selected');
  }
}

/// To convert response body if unicodes present in it
String decodedBytes(Uint8List data) {
  const utf8Decoder = Utf8Decoder(allowMalformed: true);
  final decodedBytes = utf8Decoder.convert(data);
  return decodedBytes;
}

/// A function that return image url after appending it's [baseUrlImage] with end point

String appendImageDomain(String? url) {
  //check contains http in url if you want to
  String imageUrl = '';
  url?.contains('http') ?? false ? imageUrl = (url ?? '') : imageUrl;
  //= ApiHelper.baseUrlImage + (url ?? '');
  //printDebugLog('AppendImageDomain URL :: $imageUrl');
  return imageUrl;
}

/// A function that return Unique device ID in different app build modes
Future<String?> getUUID() async {
  if (Platform.isIOS) {
    var deviceInfo = DeviceInfoPlugin();
    var iosDeviceInfo = await deviceInfo.iosInfo;
    return iosDeviceInfo.identifierForVendor; // unique ID on iOS
  }
  if (Platform.isAndroid) {
    const androidIdPlugin = AndroidId();
    return await androidIdPlugin.getId(); // unique ID on Android
  }
  return null;
}

/// common setAutoValidateMode
void setAutoValidateMode(dynamic viewModel) {
  viewModel.autoValidateMode = AutovalidateMode.always;
  viewModel.notifyListeners();
}

/// AM PM format of time
String formatTimeOfDayToAmPm(TimeOfDay timeOfDay) {
  final hour = timeOfDay.hourOfPeriod;
  final minute = timeOfDay.minute;
  final period = timeOfDay.period == DayPeriod.am ? 'AM' : 'PM';

  final hourStr = hour.toString().padLeft(2, '0');
  final minuteStr = minute.toString().padLeft(2, '0');

  return '$hourStr:$minuteStr $period';
}

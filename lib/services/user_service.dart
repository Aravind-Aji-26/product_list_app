// Dart imports:
import 'dart:convert';

class UserService {
  ///    flutter_secure_storage    ////
  // By default Android backups data on Google Drive. It can cause exception java.security.InvalidKeyException:Failed to unwrap key. You need to
  // disable autobackup, details https://developer.android.com/guide/topics/data/autobackup#EnablingAutoBackup
  //<application
  //         ..
  //         android:allowBackup="false"
  //         android:fullBackupContent="false">
  // ----- or ---
  // exclude sharedprefs FlutterSecureStorage used by the plugin https://developer.android.com/guide/topics/data/autobackup#IncludingFiles
  // Create storage
  // final storage = const FlutterSecureStorage();
  //
  // IOSOptions _getIOSOptions() => const IOSOptions(
  //     //accountName: 'PrefName',
  //     );
  //
  // ///When using the encryptedSharedPreferences parameter on Android,
  // ///make sure to pass the option to the constructor instead of the function like so:
  // AndroidOptions _getAndroidOptions() => const AndroidOptions(
  //       encryptedSharedPreferences: true,
  //       // sharedPreferencesName: 'PrefName',
  //       // preferencesKeyPrefix: 'PrefNamePre'
  //     );
  //
  // AppUser? tempUser;
  // AppUser? user;
  // BasicDetailsModel? basicDetails;
  // MyProfileModel? profileDetails;
  //
  // void setTempUser(Map<String, dynamic>? data) {
  //   if (data != null) {
  //     tempUser = AppUser.fromJson(data);
  //   }
  // }
  //
  // ///    WRITE to preference    ////
  //
  // Future<void> saveUserDetails(Map<String, dynamic>? data) async {
  //   if (data == null) return;
  //
  //   user = AppUser.fromJson(data);
  //   await storage.write(
  //     key: Prefs.user,
  //     value: jsonEncode(user?.toJson()),
  //     iOptions: _getIOSOptions(),
  //     aOptions: _getAndroidOptions(),
  //   );
  //
  //   //load new data to local variable `user`
  //   loadUserDetails();
  //
  //   // final prefs = await SharedPreferences.getInstance();
  //   // prefs.setString(Prefs.user, jsonEncode(user!.toJson()));
  // }
  //
  // ///save basic details in pref
  // Future<void> saveBasicDetails(Map<String, dynamic>? data) async {
  //   if (data == null) return;
  //
  //   basicDetails = BasicDetailsModel.fromJson(data);
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setString(Prefs.basicDetails, jsonEncode(basicDetails!.toJson()));
  //
  //   //load new data to local variable `basicDetails`
  //   loadBasicDetails();
  // }
  //
  // ///save profile details in pref
  // Future<void> saveProfileDetails(Map<String, dynamic>? data) async {
  //   if (data == null) return;
  //
  //   profileDetails = MyProfileModel.fromJson(data);
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setString(Prefs.profileDetails, jsonEncode(profileDetails!.toJson()));
  //
  //   //load new data to local variable `myProfile`
  //   loadMyProfile();
  // }
  //
  // /*///save shop data in pref
  // Future<void> saveShop(Map<String, dynamic>? data) async {
  //   if (data == null) return;
  //
  //   shopDetailsModel = ShopDetailsModel.fromJson(data);
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setString(Prefs.shop, jsonEncode(shopDetailsModel!.toJson()));
  // }*/
  //
  // ///    READ from preference    ////
  //
  // Future<AppUser?> loadUserDetails() async {
  //   // final prefs = await SharedPreferences.getInstance();
  //   // String? value = prefs.getString(Prefs.user);
  //   final value = await storage.read(
  //       key: Prefs.user,
  //       iOptions: _getIOSOptions(),
  //       aOptions: _getAndroidOptions());
  //   if (value != null) {
  //     user = AppUser.fromJson(jsonDecode(value));
  //   } else {
  //     user = null;
  //   }
  //   return user;
  // }
  //
  // Future<BasicDetailsModel?> loadBasicDetails() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   String? value = prefs.getString(Prefs.basicDetails);
  //   if (value != null) {
  //     basicDetails = BasicDetailsModel.fromJson(jsonDecode(value));
  //   } else {
  //     basicDetails = null;
  //   }
  //   return basicDetails;
  // }
  //
  // /* Future<ShopDetailsModel?> loadShop() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   String? value = prefs.getString(Prefs.shop);
  //   if (value != null) {
  //     shopDetailsModel = ShopDetailsModel.fromJson(jsonDecode(value));
  //   } else {
  //     shopDetailsModel = null;
  //   }
  //   return shopDetailsModel;
  // }*/
  //
  // ///    DELETE from preference    ////
  //
  // Future<bool> deleteUserDetails() async {
  //   // final SharedPreferences sp = await SharedPreferences.getInstance();
  //   // await sp.clear();
  //
  //   await storage.delete(
  //       key: Prefs.user,
  //       iOptions: _getIOSOptions(),
  //       aOptions: _getAndroidOptions());
  //   bool result = !await storage.containsKey(key: Prefs.user);
  //   return result;
  // }
  //
  // /// Read all values
  // // Map<String, String> allValues = await storage.readAll();
  // //
  // /// // Delete all
  // // await storage.deleteAll();
  //
  // Future<void> logout() async {
  //   bool result = await deleteUserDetails();
  //   if (!result) {
  //     showToast(ErrorCodes.errorCode11);
  //   }
  //
  //   tempUser = user = null;
  //   final prefs = await SharedPreferences.getInstance();
  //   //prefs.clear();
  //   prefs.remove(Prefs.user);
  //   prefs.remove(Prefs.basicDetails);
  //   prefs.remove(Prefs.profileDetails);
  //
  //   locator<DashboardViewModel>().changeTab(0);
  //   navigationService.clearStackAndShow(Routes.splashView);
  // }
}

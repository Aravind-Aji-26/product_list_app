// Dart imports:
import 'dart:convert';

// Project imports:
import '../constants/app_constants.dart';

class BasicResponse {
  Map<String, dynamic>? data;
  List<Map<String, dynamic>>? listData;
  String? status;
  String? responseMessage;
  bool? isApiSucceeded;

  BasicResponse({
    this.data,
    this.listData,
    this.status,
    this.responseMessage,
    this.isApiSucceeded,
  });

  factory BasicResponse.fromJson(Map<String, dynamic> json) => BasicResponse(
        data: json['data'] is Map<String, dynamic>? ? json['data'] : {},
        listData: json['data'] is List
            ? json['data']?.cast<Map<String, dynamic>>()
            : [],
        status: json["status"],
        responseMessage: json["reponseMessage"] ?? json["responseMessage"],
        isApiSucceeded: json["isApiSucceeded"],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> mapData = <String, dynamic>{};
    mapData['Data'] = data ?? listData ?? {};
    mapData['status'] = status;
    mapData['reponseMessage'] = responseMessage;
    mapData['isApiSucceeded'] = isApiSucceeded;
    return mapData;
  }
}

class ToastModel {
  late String message;
  late ToastType type;

  ToastModel({
    required this.message,
    required this.type,
  });

  ToastModel.fromBasicResponse(BasicResponse response) {
    //TODO empower
    message = response.responseMessage ?? "";
    type = ToastType.fromValue(response.isApiSucceeded);
  }

  ToastModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'] ?? "";
    type = ToastType.fromValue(json['Type']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Message'] = message;
    data['Type'] = type.value;
    return data;
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }

  ToastModel.fromString(String data) {
    var toast = ToastModel.fromJson(jsonDecode(data));
    message = toast.message;
    type = toast.type;
  }
}

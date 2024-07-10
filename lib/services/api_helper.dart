// Dart imports:
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import '../app/utils.dart';
import '../constants/app_strings.dart';
import '../model/basic_model.dart';

// Project imports:

// Package imports:

class ApiHelper {
  static const environment = ApiEnvironment.dev;

  static String baseUrl = environment.baseUrl;
  static String baseUrlImage = "$baseUrl/storage/app/";

  var client = RetryClient(
    http.Client(),
    whenError: (onError, stackTrace) {
      if (onError.toString().contains(AppStrings.connectionClosedError)) {
        return true;
      }
      return false;
    },
  );
  Duration timeoutDuration = const Duration(minutes: 1);

/*  Future<Map<String, String>> getUserHeader() async {
    if (_userService.user?.getAccessToken?.isNotEmpty ?? false) {
      return {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${_userService.user!.accessToken ?? ''}',
        'Content-Type': 'application/json',
        'Build-No': GetGlobalVariable.packageInfo?.buildNumber ?? '',
        'Device-Type': getDeviceType(),
        'Device-Token': await NotificationService().getDeviceToken(),
        'Device-Id': await getUUID() ?? '',
      };
    }
    printLog('AccessToken is empty');
    return await getAuthHeader();
  }*/

  static Future<Map<String, String>> getAuthHeader() async {
    return {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Build-No': GetGlobalVariable.packageInfo?.buildNumber ?? '',
      'Device-Type': getDeviceType(),
      'Device-Id': await getUUID() ?? '',
      'X-Auth-Client': 'gkkknTUNKKxdkmEJklljf52356OKMBVVRUSHkfklsuun2397vbbb',
      'X-Auth-Token': 'eXGJbhmktEBYJM567fgjssjmdMLLHDdhsskrushnRTYNNhHANghEJ',
    };
  }

  /// A function that perform `HttpRequest` and return `HTTP response `
  ///
  /// * `path` is the `end point of api`  after http.../api/
  /// * `defaultHeader` is `false` by default and it will send `userHeader`, to send jsonHeader pass `true`
  /// ```dart
  /// _apiHelper.performRequest(path: 'login', method: HTTPMethod.post, body: param)
  /// ```
  Future<http.Response> performRequest({
    required String path,
    required HTTPMethod method,
    required Map<String, dynamic>? body,
    bool defaultHeader = false,
    bool reGenerateTokenCall = false,
  }) async {
    http.Response response;
    Map<String, dynamic>? updatedBody = body;
    switch (method) {
      case HTTPMethod.get:
        final String queryString = Uri(
          queryParameters: updatedBody?.map(
            (key, value) => MapEntry(key, value?.toString()),
          ),
        ).query;
        String url = '$baseUrl$path';
        if (body != null) {
          url = '$url?$queryString';
        }
        response = await client
            .get(
              Uri.parse(url),
              headers: await getAuthHeader(),
            )
            .catchError((onError) async {
              // _performRequest(body: body, method: method, path: path);
              return http.Response('', 1);
            })
            .timeout(timeoutDuration,
                onTimeout: () => http.Response("Request Timeout", 408))
            .catchError(
              (onError) => http.Response("$onError", 404),
            );
        break;
      case HTTPMethod.post:
        response = await client
            .post(
              Uri.parse("$baseUrl$path"),
              headers: await getAuthHeader(),
              body: updatedBody == null ? null : jsonEncode(updatedBody),
            )
            .catchError((onError) async {
              // _performRequest(body: body, method: method, path: path);
              return http.Response('Socket Error', 1);
            })
            .timeout(timeoutDuration,
                onTimeout: () => http.Response("Request Timeout", 408))
            .catchError(
              (onError) => http.Response("$onError", 404),
            );
        break;
    }

    _log(
        response: response,
        requestBody: body,
        responseBody: null,
        logType: ApiLogType.request);

    return response;
  }

  /// A function that perform `HttpRequest` and return `HTTP response `
  ///
  /// * `path` is the `end point of api`  after http.../api/
  /// * `defaultHeader` is `false` by default and it will send `userHeader`, to send jsonHeader pass `true`
  /// * make sure you are not sending any nullable value inside maps [body], [files]
  ///
  /// ```dart
  /// _apiHelper.performMultipartRequest(path: 'register', method: HTTPMethod.post, body: param, files: files);
  /// ```

  /// A function that convert response to [BasicResponse]
  ///
  /// ```dart
  /// _apiHelper.performResponse(response: response)
  /// ```

  Future<BasicResponse> performResponse(
      {required http.Response response,
      decodeBytes = false,
      printLog = false,
      required bool pass,
      reGenerateTokenCall = false}) async {
    if (response.statusCode == 200 || pass) {
      BasicResponse responseBody = decodeBytes
          ? _responseBodyFromDecodedBytes(response)
          : _responseBodyFromType(response.body);
      printLog
          ? _log(
              response: response,
              requestBody: null,
              responseBody: responseBody,
              logType: ApiLogType.data)
          : null;
      showApiToastMessage(responseBody);
      return responseBody;
    } else if (response.statusCode == 401 || response.statusCode == 403) {
      // if (reGenerateTokenCall == false) {
      //   await handleErrorStatusCode(response);
      // }

      // handle logout case if performResponse is from reGenerateTokenCall api
      // to prevent duplicate execution of handleErrorStatusCode
      if (reGenerateTokenCall == true && response.statusCode == 401) {
      } else if (response.statusCode == 403) {
      } else {
        // ignore: response.statusCode = 401 case
      }
    } else if (response.statusCode == 408) {
      return BasicResponse(
          isApiSucceeded: false, responseMessage: 'Request Timeout');
    } else {
      _log(
          response: response,
          responseBody: null,
          logType: ApiLogType.internalServer);
    }
    return BasicResponse();
  }

  _responseBodyFromType(body) {
    return BasicResponse.fromJson(
      jsonDecode(body),
    );
  }

  /// to convert unicode responses
  _responseBodyFromDecodedBytes(response) {
    return BasicResponse.fromJson(
      jsonDecode(decodedBytes(response.bodyBytes)),
    );
  }

  /// log api related contents
  Future<void> _log({
    http.Response? response,
    http.StreamedResponse?
        streamedResponse, //multipartRequest - ApiLogType.multipartRequest
    Map<String, dynamic>? requestBody,
    BasicResponse? responseBody,
    required ApiLogType logType,
  }) async {
    switch (logType) {
      case ApiLogType.request:
        printLog(
          '=========== Request =========== \n Url: ${response?.request?.url} \n StatusCode: ${response?.statusCode} \n requestBody: ${getPrettyJSONString(jsonEncode(requestBody))}   \n Headers:}  \n body: ${getPrettyJSONString("${response?.body}")}\n ============= End ============',
        );
        break;
      case ApiLogType.multipartRequest:
        printLog(
          '=========== MultiPartRequest =========== \n Url ${streamedResponse?.request?.url} \n StatusCode ${streamedResponse?.statusCode} \n requestBody $requestBody \n Headers  \n ============= End ============',
        );
        break;
      case ApiLogType.data:
        if (responseBody != null) {
          printLog(
              '=========== BasicRes Body =========== \nServer : Data ----->\n${getPrettyJSONString(responseBody?.data)} \n ============= End ============',
              name: response?.request?.url.path ?? "No Path");
        }
        break;

      case ApiLogType.responseError:
        if (responseBody != null) {
          printLog(
              '${response?.request?.url.path ?? "No Path"} Response : Error -> ${responseBody?.responseMessage}');
        }
        break;

      case ApiLogType.internalServer:
        if (responseBody != null) {
          printLog(
              '=========== InternalServer =========== \n${response?.request?.url.path ?? "No Path"} Server : Error -> ${responseBody?.responseMessage} \n ============= End ============');
        }
        break;
      default:
        break;
    }
  }

  void showApiToastMessage(BasicResponse response) {
    //TODO empower
    // if (response.toast == true && response.message.isNotNullOrBlank) {
    //   showToastFromModel(ToastModel.fromBasicResponse(response));
    // }
  }

  String getPrettyJSONString(data) {
    try {
      final object = data is Map ? data : json.decode(data);
      return const JsonEncoder.withIndent('     ').convert(object);
    } catch (e) {
      return e.toString();
    }
  }
}

enum HTTPMethod { get, post }

enum ApiLogType {
  request,
  multipartRequest,
  data,
  responseError,
  internalServer;
}

enum ApiEnvironment {
  dev("https://api.escuelajs.co/api/v1/"),
  prod("");

  const ApiEnvironment(this.baseUrl);

  final String baseUrl;
}

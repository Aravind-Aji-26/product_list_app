// Dart imports:

import 'package:product_list_app/app/utils.dart';

import '../model/product_model.dart';
import 'api_helper.dart';

class ApiService {
  final _apiHelper = ApiHelper();

  Future<List<ProductModel>> getProducts() async {
    List<ProductModel> listData = [];

    var response = await _apiHelper
        .performRequest(path: 'products', method: HTTPMethod.get, body: {});
    printLog(response.body.toString());
    listData = await parseProducts(response.body);
    printLog(listData);
    return listData;
  }
}

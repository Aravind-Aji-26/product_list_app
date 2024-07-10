import 'package:product_list_app/model/product_model.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../app/utils.dart';
import '../../../services/api_service.dart';

class HomeViewModel extends BaseViewModel {
  final _apiService = locator<ApiService>();

  List<ProductModel> products = [];

  /// call api pay as guest load details
  Future<void> getProducts() async {
    try {
      products = await runBusyFuture(_apiService.getProducts());
    } catch (e) {
      printLog(e.toString(), name: 'Get Products Error');
    }
  }
}

import 'package:product_list_app/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:product_list_app/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:product_list_app/ui/views/home/home_view.dart';
import 'package:product_list_app/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:product_list_app/ui/views/login/login_view.dart';
import 'package:product_list_app/ui/views/sign_up/sign_up_view.dart';
import 'package:product_list_app/ui/views/home/home_view.dart';
import 'package:product_list_app/ui/views/products/products_view.dart';
import 'package:product_list_app/ui/views/product_detail/product_detail_view.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: SignUpView),
    MaterialRoute(page: HomeView),
    MaterialRoute(page: ProductsView),
    MaterialRoute(page: ProductDetailView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    // @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}

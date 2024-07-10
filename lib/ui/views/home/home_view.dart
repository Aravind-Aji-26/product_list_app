import 'package:flutter/material.dart';
import 'package:product_list_app/constants/ui_helpers.dart';
import 'package:product_list_app/ui/common/custom_cached_image.dart';
import 'package:stacked/stacked.dart';

import '../../common/model_future_builder.dart';
import 'components/product_card.dart';
import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  void onViewModelReady(HomeViewModel viewModel) {
    // TODO: implement onViewModelReady
    viewModel.getProducts();
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bgImage.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          padding: const EdgeInsets.only(left: 25.0, right: 25.0),
          child: ModelFutureListBuilder(
              busy: viewModel.isBusy,
              data: viewModel.products,
              builder: (context, data, _) {
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => ProductCard(product: viewModel.products[index],),
                );
              })),
    );
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();
}



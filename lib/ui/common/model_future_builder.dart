import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/ui_helpers.dart';

typedef RefreshBuilder = Future<void> Function(bool fromButton);

class ModelFutureBuilder<T> extends StatelessWidget {
  const ModelFutureBuilder({
    super.key,
    required this.busy,
    required this.data,
    required this.builder,
    this.onError,
    this.loading,
    this.onRefresh,
    this.error,
    this.isFullScreen = false,
    this.hasRefreshButton = true,
    this.isSheet = false,
  });

  final bool busy;
  final T? data;
  final WidgetBuilder? onError;
  final RefreshBuilder? onRefresh;
  final bool isFullScreen;
  final bool isSheet;
  final dynamic error;
  final Widget? loading;
  final ValueWidgetBuilder<T> builder;
  final bool hasRefreshButton;

  @override
  Widget build(BuildContext context) {
    if (busy) {
      return loading ?? ModelBusyWidget(isFullScreen: isFullScreen || isSheet);
    } else {
      if (data == null) {
        return onError != null
            ? onError!(context)
            : ModelErrorWidget(
                hasRefreshButton: hasRefreshButton,
                onRefresh: onRefresh,
                error: error,
                isFullScreen: isFullScreen,
              );
      } else {
        return onRefresh != null
            ? RefreshIndicator(
                onRefresh: () => onRefresh!.call(false),
                child: builder(context, data as T, null),
              )
            : builder(context, data as T, null);
      }
    }
  }
}

class ModelFutureListBuilder<T> extends StatelessWidget {
  const ModelFutureListBuilder({
    super.key,
    required this.busy,
    required this.data,
    required this.builder,
    this.empty,
    this.loading,
    this.onRefresh,
    this.hasRefreshButton = true,
    this.emptyText,
    this.isFullScreen = false,
  });

  final bool busy;
  final List<T> data;
  final Widget? empty;
  final Widget? loading;
  final RefreshBuilder? onRefresh;
  final bool hasRefreshButton;
  final String? emptyText;
  final ValueWidgetBuilder<List<T>> builder;
  final bool isFullScreen;

  @override
  Widget build(BuildContext context) {
    if (busy) {
      return loading ?? ModelBusyWidget(isFullScreen: isFullScreen);
    } else {
      if (data.isEmpty) {
        return empty ??
            ModelErrorWidget(
              onRefresh: onRefresh,
              error: emptyText ?? 'No items found',
              isFullScreen: isFullScreen,
              hasRefreshButton: hasRefreshButton,
            );
      } else {
        return onRefresh != null
            ? RefreshIndicator(
                onRefresh: () => onRefresh!.call(false),
                child: builder(context, data, null),
              )
            : builder(context, data, null);
      }
    }
  }
}

class ModelBusyWidget extends StatelessWidget {
  const ModelBusyWidget({
    super.key,
    required this.isFullScreen,
  });

  final bool isFullScreen;

  @override
  Widget build(BuildContext context) {
    if (isFullScreen) {
      return Scaffold(
        body: SizedBox.expand(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/loading.png",
                  width: 100,
                  height: 100,
                ),
                height_20,
                const Text('Loading...',
                    style: TextStyle(
                      color: Palette.black,
                      fontSize: 16,
                    ))
              ],
            )
            // CircularProgressIndicator(
            //   color: Palette.primary,
            //   strokeWidth: 2.5,
            // )
            ,
          ),
        ),
      );
    }
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/loading.png",
            width: 100,
            height: 100,
          ),
          height_20,
          const Text('Loading...',
              style: TextStyle(
                color: Palette.black,
                fontSize: 16,
              ))
        ],
      )
      // CircularProgressIndicator(
      //   color: Palette.primary,
      //   strokeWidth: 2.5,
      // )
      ,
    );
  }
}

class ModelErrorWidget extends StatelessWidget {
  const ModelErrorWidget({
    Key? key,
    this.onRefresh,
    required this.error,
    required this.isFullScreen,
    required this.hasRefreshButton,
  }) : super(key: key);

  final RefreshBuilder? onRefresh;
  final dynamic error;
  final bool isFullScreen;
  final bool hasRefreshButton;

  @override
  Widget build(BuildContext context) {
    if (isFullScreen) {
      return Scaffold(
        appBar: AppBar(
          //leading: backButton(),
          elevation: 8,
          backgroundColor: Colors.transparent,
        ),
        extendBodyBehindAppBar: true,
        body: _getBody(),
      );
    }
    return _getBody();
  }

  Widget _getBody() {
    return SizedBox.expand(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: onRefresh != null ? 10 : 0),
            child: error is Widget
                ? error
                : Text(
                    error?.toString() ??
                        "Oops... Something went wrong\nPlease try again",
                    textAlign: TextAlign.center,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.black54,
                    ),
                  ),
          ),
          const SizedBox(height: 30),
          hasRefreshButton == true
              ? Visibility(
                  visible: onRefresh != null,
                  child: OutlinedButton(
                    onPressed: () => onRefresh?.call(true),
                    style: OutlinedButton.styleFrom(
                      ///primary: Palette.primary,
                      foregroundColor: Palette.primary,
                      visualDensity: VisualDensity.comfortable,
                      tapTargetSize: MaterialTapTargetSize.padded,
                      padding: const EdgeInsets.fromLTRB(15, 13, 15, 10),
                    ),
                    child: const Text(
                      'Refresh',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}

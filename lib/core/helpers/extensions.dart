import 'package:flutter/material.dart';
import 'package:meal_recommendations/core/widgets/loading_dialog.dart';

extension ShowLoadingDialog on BuildContext {
  Future<void> showLoadingDialog() async => await showDialog<void>(
        context: this,
        barrierDismissible: false,
        builder: (_) => const LoadingDialog(),
      );
}

extension AppNavigator on BuildContext {
  Future<dynamic> pushNamed(String routeName, {Object? arguments}) {
    return Navigator.pushNamed(this, routeName, arguments: arguments);
  }

  Future<dynamic> pushReplacementNamed(
    String newRoute, {
    Object? arguments,
  }) {
    return Navigator.pushReplacementNamed(this, newRoute, arguments: arguments);
  }

  Future<dynamic> pushNamedAndRemoveUntil(
    String newRoute, {
    Object? arguments,
  }) {
    return Navigator.pushNamedAndRemoveUntil(
      this,
      newRoute,
      (Route<dynamic> route) => false, // remove all previous routes
      arguments: arguments,
    );
  }

  void pop() => Navigator.pop(this);
}

extension MediaQueryExtension on BuildContext {
  double get screenHeight => MediaQuery.sizeOf(this).height;
  double get screenWidth => MediaQuery.sizeOf(this).width;
}

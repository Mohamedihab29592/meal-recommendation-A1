import 'package:flutter/material.dart';
import 'package:meal_recommendations/core/widgets/loading_dialog.dart';

extension ShowLoadingDialog on BuildContext {
  Future<void> showLoadingDialog() async => await showDialog<void>(
        context: this,
        barrierDismissible: false,
        builder: (_) => const LoadingDialog(),
      );
}

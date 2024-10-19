import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_recommendations/core/themes/app_colors.dart';
import 'package:meal_recommendations/core/themes/app_text_styles.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.onPressed,
    this.text,
    this.child,
    this.borderRadius,
    this.textStyle,
    this.backgroundColor,
    this.textColor,
    this.boxShadow,
    this.width,
    this.height,
    this.padding,
    this.border,
    this.isOutlined = false,
    this.fontSize,
    this.margin,
    this.borderColor = Colors.white,
    this.borderWidth = 1,
    this.shape,
  });

  final String? text;
  final Widget? child;
  final double? borderRadius;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final Color? textColor;
  final void Function()? onPressed;
  final List<BoxShadow>? boxShadow;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final BoxBorder? border;
  final bool isOutlined;
  final double? fontSize;
  final EdgeInsetsGeometry? margin;
  final Color borderColor;
  final double borderWidth;
  final ShapeBorder? shape;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width?.w ?? double.infinity,
      height: height?.h ?? 57.0.h,
      margin: margin,
      decoration: BoxDecoration(
        color: isOutlined
            ? Colors.transparent
            : backgroundColor ?? AppColors.scaffoldBackgroundLightColor,
        borderRadius: BorderRadiusDirectional.circular(
          borderRadius?.r ?? 45.0.r,
        ),
        boxShadow: boxShadow,
        border: isOutlined
            ? Border.all(
                color: borderColor,
                width: borderWidth.w,
              )
            : border,
      ),
      child: MaterialButton(
        padding: padding,
        onPressed: onPressed,
        shape: shape ??
            RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.circular(
                borderRadius?.r ?? 45.0.r,
              ),
            ),
        child: child ??
            Text(
              text!,
              style: textStyle ??
                  AppTextStyles.font21BoldDarkBlue.copyWith(
                    fontSize: fontSize?.sp ?? 21.sp,
                  ),
            ),
      ),
    );
  }
}

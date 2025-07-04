import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";

import "../../common/utils/extensions/context_extensions.dart";

class CustomButtonWidget extends StatelessWidget {
  const CustomButtonWidget({
    super.key,
    required this.inputText,
    required this.function,
    this.buttonColor,
    this.buttonWidth,
    this.buttonHeight,
    // this.textColor,
    // this.textSize,
    // this.textFontWeight
    this.textStyle,
    this.disabled,
  });

  final String inputText;
  final VoidCallback function;
  final Color? buttonColor;
  final double? buttonWidth;
  final double? buttonHeight;
  final TextStyle? textStyle;
  final bool? disabled;

  // final Color? textColor;
  // final double? textSize;
  // final FontWeight? textFontWeight;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
          minimumSize: Size(
            buttonWidth ?? double.infinity,
            buttonHeight ?? 60,
          ),
          backgroundColor: buttonColor ?? context.theme.colorScheme.primary,
        ),
        onPressed: disabled != null && disabled == true ? null : function,
        child: Text(inputText, style: textStyle));
  }
}

class CustomMaterialButtonWidget extends StatelessWidget {
  const CustomMaterialButtonWidget({
    super.key,
    required this.inputText,
    required this.function,
    this.buttonColor,
    this.buttonWidth,
    this.buttonHeight,
    this.textStyle,
    this.disabled,
    this.buttonBorderRadius,
  });

  final String inputText;
  final VoidCallback function;
  final Color? buttonColor;
  final double? buttonWidth;
  final double? buttonHeight;
  final TextStyle? textStyle;
  final bool? disabled;
  final double? buttonBorderRadius;

  // final Color? textColor;
  // final double? textSize;
  // final FontWeight? textFontWeight;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(buttonBorderRadius ?? 50.r)),
        minWidth: buttonWidth ?? double.infinity.w,
        height: buttonHeight ?? 50.h,
        color: buttonColor ?? context.theme.colorScheme.primary,
        onPressed: disabled != null && disabled == true ? null : function,
        child: Text(inputText, style: textStyle ?? Theme.of(context).textTheme.titleSmall));
  }
}

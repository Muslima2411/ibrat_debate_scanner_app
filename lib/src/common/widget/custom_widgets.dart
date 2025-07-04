// import "package:flutter/material.dart";
// import "../../feature/settings/model/language_type.dart";
// import "../styles/app_colors.dart";
// import "../utils/extensions/context_extensions.dart";
//
// Widget customTextWidget({
//   required String text,
//   required double fontSize,
//   required FontWeight fontWeight,
//   required Color color,
//   bool isCenter = false,
// }) {
//   return Text(
//     text,
//     style: TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color),
//     textAlign: isCenter ? TextAlign.center : null,
//   );
// }
//
//
// class CustomTextWidget extends StatelessWidget {
//   const CustomTextWidget(
//       {super.key,
//       required this.text,
//       this.fontSize = 16,
//       this.fontWeight = FontWeight.w400,
//       this.color,
//       this.textAlign = TextAlign.center});
//
//   final String text;
//   final double? fontSize;
//   final FontWeight? fontWeight;
//   final Color? color;
//   final TextAlign? textAlign;
//
//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       maxLines: 3,
//       text,
//       style: TextStyle(
//         overflow: TextOverflow.ellipsis,
//         fontSize: fontSize,
//         fontWeight: fontWeight,
//         color: color ?? context.theme.colorScheme.onSecondaryContainer,
//       ),
//       textAlign: textAlign,
//     );
//   }
// }
//
// class CustomButtonWidget extends StatelessWidget {
//   const CustomButtonWidget(
//       {super.key,
//       required this.inputText,
//       required this.function,
//       this.buttonColor,
//       this.buttonWidth,
//       this.buttonHeight,
//       this.textColor,
//       this.textSize,
//       this.textFontWeight,
//       });
//
//   final String inputText;
//   final VoidCallback function;
//   final Color? buttonColor;
//   final double? buttonWidth;
//   final double? buttonHeight;
//   final Color? textColor;
//   final double? textSize;
//   final FontWeight? textFontWeight;
//
//   @override
//   Widget build(BuildContext context) {
//     return TextButton(
//       style: TextButton.styleFrom(
//         minimumSize: Size(
//           buttonWidth ?? double.infinity,
//           buttonHeight ?? 60,
//         ),
//         backgroundColor: buttonColor ?? context.theme.colorScheme.primary,
//       ),
//       onPressed: function,
//       child: CustomTextWidget(
//         text: inputText,
//         fontSize: textSize,
//         fontWeight: textFontWeight,
//         color: textColor ?? AppColors.white,
//       ),
//     );
//   }
// }

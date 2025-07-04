import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";

/// {@template custom_svg_widget}
/// CustomSvgWidget widget.
/// {@endtemplate}
class CustomSvgWidget extends StatelessWidget {
  /// {@macro custom_svg_widget}
  const CustomSvgWidget(this.path, {required this.size, this.color, super.key});

  final String path;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) => SizedBox.square(
    dimension: size,
    child: SvgPicture.asset(
      path,
      fit: BoxFit.cover,
      colorFilter: color == null
          ? null
          : ColorFilter.mode(color!, BlendMode.srcATop),
    ),
  );
}

import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "common/widget/app_material_context.dart";

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      builder: (_ , Widget? child) => MaterialContext()
  );
}

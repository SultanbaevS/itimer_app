// import 'package:flutter/material.dart';
//
// class ScreenUtil extends StatelessWidget {
//   const ScreenUtil({
//     required this.child,
//     this.screenSize = const Size(420, 940),
//     super.key,
//   });
//
//   final Size screenSize;
//   final Widget child;
//
//   @override
//   Widget build(BuildContext context) {
//     final _size = MediaQuery.sizeOf(context);
//     final size = Size(
//       _size.width / screenSize.width,
//       _size.height / screenSize.height,
//     );
//
//     return child;
//   }
// }
//
// extension ForScreenUtil on num {
//   double get screenWidth => 420;
//   double get screenHeight => 940;
//
//   double w(Size size) => this * size.width;
//   double h(Size size) => this * size.height;
//
//   double sw(Size size) => this * (screenWidth * size.width);
//   double sh(Size size) => this * (screenHeight * size.height);
// }
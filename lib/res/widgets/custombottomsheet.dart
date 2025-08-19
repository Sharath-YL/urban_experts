import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';

class FlexibleBottomSheets extends StatelessWidget {
  final double initialHeight;
  final double minHeight;
  final double maxHeight;
  final double headerHeight; // Added headerHeight parameter
  final Widget Function(BuildContext, double) headerBuilder;
  final Widget Function(BuildContext, double) bodyBuilder;
  final bool showOnBuild;
  final String? buttonText;

  const FlexibleBottomSheets({
    super.key,
    this.initialHeight = 0.5,
    this.minHeight = 0.0,
    this.maxHeight = 0.9,
    this.headerHeight = 56.0, 
    required this.headerBuilder,
    required this.bodyBuilder,
    this.showOnBuild = false,
    this.buttonText,
  });

  static void show({
    required BuildContext context,
    double initialHeight = 0.5,
    double minHeight = 0.0,
    double maxHeight = 0.9,
    double headerHeight = 58.0, 
    required Widget Function(BuildContext, double) headerBuilder,
    required Widget Function(BuildContext, double) bodyBuilder,
  }) {
    showStickyFlexibleBottomSheet(
      context: context,
      minHeight: minHeight,
      initHeight: initialHeight,
      maxHeight: maxHeight,
      headerHeight: headerHeight, // Use configurable headerHeight
      headerBuilder: headerBuilder,
      bodyBuilder:
          (context, offset) => SliverChildBuilderDelegate(
            (context, i) => bodyBuilder(context, offset),
            childCount: 1,
          ),
      isSafeArea: true,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (showOnBuild) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        FlexibleBottomSheets.show(
          context: context,
          initialHeight: initialHeight,
          minHeight: minHeight,
          maxHeight: maxHeight,
          headerHeight: headerHeight, // Pass headerHeight
          headerBuilder: headerBuilder,
          bodyBuilder: bodyBuilder,
        );
      });
    }

    if (buttonText != null) {
      return ElevatedButton(
        onPressed:
            () => FlexibleBottomSheets.show(
              context: context,
              initialHeight: initialHeight,
              minHeight: minHeight,
              maxHeight: maxHeight,
              headerHeight: headerHeight, // Pass headerHeight
              headerBuilder: headerBuilder,
              bodyBuilder: bodyBuilder,
            ),
        child: Text(buttonText!),
      );
    }

    return Container();
  }
}
// class FlexibleBottomSheetExample extends StatelessWidget {
//   const FlexibleBottomSheetExample({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Flexible Bottom Sheet Example')),
//       body: Center(
//         child: FlexibleBottomSheet(
//           buttonText: 'Show Bottom Sheet',
//           initialHeight: 0.5,
//           minHeight: 0.0,
//           maxHeight: 0.9,
//           headerBuilder: (context, offset) => Container(
//             color: Colors.blue,
//             height: 50.0,
//             child: const Center(
//               child: Text(
//                 'Header',
//                 style: TextStyle(color: Colors.white, fontSize: 18),
//               ),
//             ),
//           ),
//           bodyBuilder: (context, offset) => Container(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const Text(
//                   'This is the body of the bottom sheet.',
//                   style: TextStyle(fontSize: 16),
//                 ),
//                 const SizedBox(height: 16),
//                 ElevatedButton(
//                   onPressed: () => Navigator.pop(context),
//                   child: const Text('Close'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

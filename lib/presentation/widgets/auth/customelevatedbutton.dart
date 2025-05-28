import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget? child;
  final double? width;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.child,
    required this.width,
    required this.backgroundColor,
    required this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width, // Make button stretch full width
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor, // Red button color
          foregroundColor: foregroundColor, // Text color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              8.0,
            ), // Slightly rounded corners
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          minimumSize: const Size(0, 40), // Ensure button height
        ),
        child: child,
      ),
    );
  }
}


// ElevatedButton(
//         onPressed: onPressed,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: backgroundColor, // Button background color
//           padding: EdgeInsets.symmetric(vertical: 16.0), // Button padding
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(8.0), // Rounded corners
//           ),
//           elevation: 3, // Slight shadow
//         ),
//         child: child,
//       ),
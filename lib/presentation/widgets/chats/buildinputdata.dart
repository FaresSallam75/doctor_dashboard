import 'package:flutter/material.dart';

Widget buildInputDataAres(
  final ThemeData theme,
  final TextEditingController textController,
  final void Function()? onPressedSend,
  //final Widget? suffixWidget,
  final void Function()? onPressed,
  BuildContext context,
) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
    color: theme.colorScheme.surface, // Match background
    child: SafeArea(
      // Avoid intrusions at the bottom (like home indicator)
      child: Row(
        children: [
          // Optional: Attach button
          IconButton(
            icon: Icon(
              Icons.add_circle_outline,
              color: theme.colorScheme.primary,
            ),
            onPressed: onPressed,
            tooltip: 'إرفاق ملف',
          ),
          // --- Text Input Field ---
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14.0,
              ), // Padding inside the field
              decoration: BoxDecoration(
                // ignore: deprecated_member_use
                color: theme.colorScheme.surfaceContainerHighest.withOpacity(
                  0.5,
                ), // Slightly different background
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: TextField(
                controller: textController,
                decoration: InputDecoration(
                  //suffix: suffixWidget,
                  hintText: 'Message ...',
                  border: InputBorder.none, // Remove default border
                  hintStyle: TextStyle(
                    // ignore: deprecated_member_use
                    color: theme.colorScheme.onSurfaceVariant.withOpacity(0.6),
                  ),
                ),
                textCapitalization: TextCapitalization.sentences,
                minLines: 1,
                maxLines: 5, // Allow multi-line input
                style: TextStyle(
                  color: theme.colorScheme.onSurface,
                ), // Input text color
              ),
            ),
          ),
          const SizedBox(width: 8.0), // Spacing
          // --- Send Button ---
          FloatingActionButton(
            mini: true, // Smaller button
            onPressed: onPressedSend,
            backgroundColor: theme.colorScheme.primary,
            foregroundColor: theme.colorScheme.onPrimary,
            elevation: 1.0,
            tooltip: 'إرسال',
            child: const Icon(Icons.send, size: 18),
          ),
          // Optional: Emoji Button
          // IconButton(
          //   icon: Icon(Icons.emoji_emotions_outlined, color: theme.colorScheme.secondary),
          //   onPressed: () { /* TODO: Implement emoji picker */ },
          // ),
        ],
      ),
    ),
  );
}

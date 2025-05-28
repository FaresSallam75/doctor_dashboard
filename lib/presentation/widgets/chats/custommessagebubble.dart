import 'package:user_appointment/link_api.dart';
import 'package:user_appointment/main.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:user_appointment/data/models/messagemodel.dart';

class MessageBubble extends StatelessWidget {
  final MessageModel messageModel;

  const MessageBubble({super.key, required this.messageModel});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // *** MODIFY THIS: Use the passed-in currentUserId for comparison ***
    // Ensure messageModel.userId is not null before comparing if it can be null
    final bool isMe =
        messageModel.doctorId != null &&
        messageModel.sender == myBox!.get("doctorId").toString();

    // Determine bubble alignment and colors based on sender
    final alignment = isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final bubbleColor =
        isMe
            ? theme.colorScheme.primaryContainer
            : theme.colorScheme.secondaryContainer;
    final textColor =
        isMe
            ? theme.colorScheme.onPrimaryContainer
            : theme.colorScheme.onSecondaryContainer;

    // Determine border radius based on sender
    final borderRadius = BorderRadius.only(
      topLeft: const Radius.circular(18.0),
      topRight: const Radius.circular(18.0),
      bottomLeft: Radius.circular(isMe ? 18.0 : 0), // Pointy corner if not me
      bottomRight: Radius.circular(isMe ? 0 : 18.0), // Pointy corner if me
    );

    // Use messageModel.imageUrl if that's the correct field name based on your previous request
    // If it's still messageModel.file, keep using that. I'll use imageUrl based on convention.
    // *** ADJUST FIELD NAME HERE if needed (imageUrl vs file) ***
    final String? imagePath = messageModel.file; // Or messageModel.imageUrl;
    final bool isImageMessage = imagePath != null && imagePath.isNotEmpty;

    final bool isTextMessage =
        messageModel.text != null && messageModel.text!.isNotEmpty;

    // Decide what content to show
    Widget messageContent;
    EdgeInsets contentPadding;

    if (isImageMessage) {
      // --- Image Content ---
      contentPadding = EdgeInsets.zero;
      messageContent = ClipRRect(
        borderRadius: borderRadius,
        child: Image.network(
          // *** Ensure AppLink.viewMessagesImages is correct ***
          "${AppLink.viewMessagesImages}/$imagePath",
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              padding: const EdgeInsets.all(20),
              // *** Consider making height/width constraints more dynamic or relative ***
              height:
                  MediaQuery.of(context).size.height * 0.25, // Example height
              width: MediaQuery.of(context).size.width * 0.65, // Example width
              child: Center(
                child: CircularProgressIndicator(
                  value:
                      loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                  strokeWidth: 2,
                ),
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            // Optional: Log error for debugging
            // print("Error loading image: $error");
            return Container(
              padding: const EdgeInsets.all(10),
              height:
                  MediaQuery.of(context).size.height *
                  0.25, // Match loading height
              width:
                  MediaQuery.of(context).size.width *
                  0.65, // Match loading width
              child: const Center(
                child: Icon(
                  Icons.broken_image_outlined,
                  color: Colors.grey,
                  size: 40,
                ),
              ),
            );
          },
          // *** Changed fit to cover, often looks better for chat images ***
          // Use BoxFit.contain if you absolutely need to see the whole image, even if it leaves empty space
          fit: BoxFit.contain,
          height: MediaQuery.of(context).size.height * 0.25, // Constrain height
          width: MediaQuery.of(context).size.width * 0.65, // Constrain width
        ),
      );
    } else if (isTextMessage) {
      // --- Text Content ---
      contentPadding = const EdgeInsets.symmetric(
        horizontal: 14.0,
        vertical: 10.0,
      );
      messageContent = Text(
        messageModel.text!,
        style: TextStyle(color: textColor, fontSize: 15.0),
        softWrap: true,
      );
    } else {
      // --- Fallback for empty message (optional) ---
      contentPadding = const EdgeInsets.symmetric(
        horizontal: 14.0,
        vertical: 10.0,
      );
      messageContent = Text(
        '[Empty Message]',
        style: TextStyle(
          // ignore: deprecated_member_use
          color: textColor.withOpacity(0.5),
          fontSize: 14.0,
          fontStyle: FontStyle.italic,
        ),
      );
    }

    // Don't render anything if there's absolutely no content (safer)
    if (!isImageMessage && !isTextMessage) {
      return const SizedBox.shrink(); // Return an empty widget
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Column(
        crossAxisAlignment: alignment, // Align bubble left or right
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth:
                  MediaQuery.of(context).size.width *
                  (isImageMessage ? 0.7 : 0.75),
            ),
            padding: contentPadding,
            decoration: BoxDecoration(
              // Use transparent color for image bubbles if you want the image background to show through,
              // otherwise keep the bubbleColor. Keeping bubbleColor is standard.
              color: bubbleColor, // Keep bubble color for consistency
              borderRadius: borderRadius,
              boxShadow: [
                BoxShadow(
                  // ignore: deprecated_member_use
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 3,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: messageContent, // Display the determined content
          ),
          // Timestamp
          Padding(
            padding: EdgeInsets.only(
              top: 4.0,
              left: isMe ? 0 : 12.0,
              right: isMe ? 12.0 : 0,
            ),
            child: Text(
              messageModel.date != null
                  ? Jiffy.parse(messageModel.date!).format(
                    pattern: "HH:mm",
                  ) // Use Jiffy format for clarity
                  : '--:--',
              style: theme.textTheme.bodySmall?.copyWith(
                // ignore: deprecated_member_use
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ${Jiffy.parse(messageModel.date!).hour}:${Jiffy.parse(messageModel.date!).minute.toString().padLeft(2, '0')}

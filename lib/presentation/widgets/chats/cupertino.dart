import 'package:flutter/cupertino.dart';

class ContextMenuExample extends StatelessWidget {
  final void Function() onPressed;
  final Widget child;
  const ContextMenuExample({
    super.key,
    required this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: CupertinoContextMenu(
        actions: <Widget>[
          CupertinoContextMenuAction(
            onPressed: () {
              Navigator.pop(context);
            },
            isDefaultAction: true,
            trailingIcon: CupertinoIcons.doc_on_clipboard_fill,
            child: const Text('Copy'),
          ),
          CupertinoContextMenuAction(
            onPressed: () {
              Navigator.pop(context);
            },
            trailingIcon: CupertinoIcons.share,
            child: const Text('Share'),
          ),
          CupertinoContextMenuAction(
            onPressed: () {
              Navigator.pop(context);
            },
            trailingIcon: CupertinoIcons.heart,
            child: const Text('Favorite'),
          ),
          CupertinoContextMenuAction(
            onPressed: onPressed,
            isDestructiveAction: true,
            trailingIcon: CupertinoIcons.delete,
            child: const Text('Delete'),
          ),
        ],
        child: child,
      ),
    );
  }
}

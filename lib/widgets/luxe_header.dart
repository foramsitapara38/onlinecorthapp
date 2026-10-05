import 'package:flutter/material.dart';

/// The LUXE wordmark with the close (X) button, shared by the shop pages.
class LuxeHeader extends StatelessWidget {
  const LuxeHeader({super.key, this.onClose, this.showClose = true});

  final VoidCallback? onClose;
  final bool showClose;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 8, 4),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              'LUXE',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.4,
              ),
            ),
          ),
          if (showClose && onClose != null)
            IconButton(
              onPressed: onClose,
              icon: const Icon(Icons.close, size: 26),
            ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

/// The LUXE wordmark with an optional back arrow (left) and close (X, right).
class LuxeHeader extends StatelessWidget {
  const LuxeHeader({
    super.key,
    this.onBack,
    this.onClose,
    this.showClose = true,
  });

  final VoidCallback? onBack;
  final VoidCallback? onClose;
  final bool showClose;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(onBack == null ? 20 : 8, 10, 8, 4),
      child: Row(
        children: [
          if (onBack != null)
            IconButton(
              onPressed: onBack,
              icon: const Icon(Icons.arrow_back),
            ),
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

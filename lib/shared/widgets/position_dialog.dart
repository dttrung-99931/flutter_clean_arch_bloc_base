import 'package:flutter/material.dart';
import 'package:maingames_flutter_test/core/utils/evm_colors.dart';
import 'package:maingames_flutter_test/config/app_router.dart';

class PositionDialog extends StatelessWidget {
  const PositionDialog({super.key, required this.child, required this.showingPosition});

  final Widget child;
  final Offset showingPosition;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      alignment: Alignment.center,
      backgroundColor: EVMColors.transparent,
      elevation: 0,
      child: Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                AppRouter.hideDialog(context);
              },
            ),
          ),
          Positioned(left: showingPosition.dx, top: showingPosition.dy, child: child),
        ],
      ),
    );
  }
}

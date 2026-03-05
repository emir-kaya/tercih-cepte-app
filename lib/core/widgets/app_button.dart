import 'package:flutter/material.dart';

enum AppButtonType { primary, outlined, text }

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final AppButtonType type;
  final bool isLoading;
  final Widget? icon;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.type = AppButtonType.primary,
    this.isLoading = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    if (type == AppButtonType.outlined) {
      if (icon != null) {
        return OutlinedButton.icon(
          onPressed: isLoading ? null : onPressed,
          icon: _buildIconOrLoading(),
          label: Text(text),
        );
      }
      return OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        child: _buildChild(),
      );
    } else if (type == AppButtonType.text) {
      if (icon != null) {
        return TextButton.icon(
          onPressed: isLoading ? null : onPressed,
          icon: _buildIconOrLoading(),
          label: Text(text),
        );
      }
      return TextButton(
        onPressed: isLoading ? null : onPressed,
        child: _buildChild(),
      );
    }

    if (icon != null) {
      return ElevatedButton.icon(
        onPressed: isLoading ? null : onPressed,
        icon: _buildIconOrLoading(),
        label: Text(text),
      );
    }
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      child: _buildChild(),
    );
  }

  Widget _buildChild() {
    if (isLoading) {
      return const SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
      );
    }
    return Text(text);
  }

  Widget _buildIconOrLoading() {
    if (isLoading) {
      return const SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
      );
    }
    return icon!;
  }
}

import 'package:flutter/material.dart';
import 'package:quickbytes_app/shared/widgets/cached_image.dart';

class ActionButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onTap;
  final String text;
  const ActionButton({
    Key? key,
    required this.isLoading,
    required this.onTap,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(top: 20, left: 50, right: 50),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white70, width: .5),
        ),
        width: double.infinity,
        alignment: Alignment.center,
        height: 45,
        child: isLoading
            ? const AdaptiveProgressIndicator()
            : Text(
                text,
                style: const TextStyle(
                  color: Colors.white70,
                ),
              ),
      ),
    );
  }
}

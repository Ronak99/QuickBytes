import 'package:flutter/material.dart';
import 'package:quickbytes_app/shared/utils/constants.dart';

class SettingsFooter extends StatelessWidget {
  const SettingsFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Text(
        "${AppConfig.name} ${AppConfig.version}${AppConfig.versionCode}${AppConfig.patch}",
        style: TextStyle(
          fontWeight: FontWeight.w700,
          color: Colors.white38,
        ),
      ),
    );
  }
}

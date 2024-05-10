import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quickbytes_app/core/navigation/routes.dart';
import 'package:quickbytes_app/features/settings/presentation/widgets/settings_footer.dart';

import 'package:quickbytes_app/shared/utils/constants.dart';
import 'package:quickbytes_app/shared/utils/utils.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Column(
          children: [
            const SizedBox(height: 16),
            SettingsBlock(
              title: 'Preferences',
              items: [
                SettingsListItem(
                  text: "Update News Preferences",
                  icon: AssetConstants.preference,
                  onTap: () => UserPreferencesPageRoute().go(context),
                  isLast: true,
                ),
              ],
            ),
            SettingsBlock(
              title: 'Support',
              items: [
                const SettingsListItem(
                  text: "Share App",
                  icon: AssetConstants.share,
                  onTap: Utils.shareApp,
                ),
                SettingsListItem(
                  text: "Rate App",
                  icon: AssetConstants.rating,
                  onTap: () {},
                ),
                const SettingsListItem(
                  text: "Feedback",
                  icon: AssetConstants.feedback,
                  onTap: Utils.userFeedback,
                  isLast: true,
                ),
              ],
            ),
            const Spacer(),
            const SettingsFooter(),
          ],
        ),
      ),
    );
  }
}

class SettingsBlock extends StatelessWidget {
  final String title;
  final List<SettingsListItem> items;
  const SettingsBlock({
    Key? key,
    required this.title,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: ColorConstants.primaryDarkestDark,
        borderRadius: BorderRadius.circular(12),
      ),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          const SizedBox(height: 12),
          ...items,
        ],
      ),
    );
  }
}

class SettingsListItem extends StatelessWidget {
  final String text;
  final String icon;
  final VoidCallback onTap;
  final bool isLast;
  const SettingsListItem({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTap,
    this.isLast = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: isLast
              ? null
              : Border(
                  bottom: BorderSide(
                    color: Colors.grey[800]!,
                    width: .5,
                  ),
                ),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 6),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  icon,
                  height: 25,
                  width: 25,
                  colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(.85), BlendMode.srcIn),
                ),
                const SizedBox(width: 8),
                Text(
                  text,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                )
              ],
            ),
            SvgPicture.asset(
              AssetConstants.next,
              height: 18,
              width: 18,
              colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(.85),
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

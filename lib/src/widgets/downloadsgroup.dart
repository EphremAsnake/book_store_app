import 'package:flutter/material.dart';
import 'package:resize/resize.dart';

import '../pages/navigations/settings/components/babstrap_settings_screen.dart';
import 'downloadeditem.dart';

/// This component group the Settings items (BabsComponentSettingsItem)
/// All one BabsComponentSettingsGroup have a title and the developper can improve the design.
class DownloadsGroup extends StatelessWidget {
  final String? settingsGroupTitle;
  final TextStyle? settingsGroupTitleStyle;
  final List<DownloadedItem> items;
  final EdgeInsets? margin;
  final Function onTap;
  // Icons size
  final double? iconItemSize;

  DownloadsGroup(
      {this.settingsGroupTitle,
      this.settingsGroupTitleStyle,
      required this.items,
      required this.onTap,
      this.margin,
      this.iconItemSize = 25});

  @override
  Widget build(BuildContext context) {
    if (iconItemSize != null) {
      SettingsScreenUtils.settingsGroupIconSize = iconItemSize;
    }

    return Container(
      margin: margin ?? const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // The title
          (settingsGroupTitle != null)
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    settingsGroupTitle!,
                    style: (settingsGroupTitleStyle == null)
                        ? const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold)
                        : settingsGroupTitleStyle,
                  ),
                )
              : Container(),
          // The SettingsGroup sections
          Material(
            type: MaterialType.transparency,
            child: InkWell(
              borderRadius: BorderRadius.circular(8.r),
              onTap: () => onTap(),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: Colors.grey)),
                  child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    itemCount: items.length,
                    itemBuilder: (BuildContext context, int index) {
                      return items[index];
                    },
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const ScrollPhysics(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

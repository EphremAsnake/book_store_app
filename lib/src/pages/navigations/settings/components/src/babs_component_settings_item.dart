import 'package:flutter/material.dart';

import '../babstrap_settings_screen.dart';

class SettingsItem extends StatelessWidget {
  final IconData icons;
  final IconStyle? iconStyle;
  final String title;
  final TextStyle? titleStyle;
  final String? subtitle;
  final TextStyle? subtitleStyle;
  final Widget? trailing;
  final Function onTap;
  final Color? backgroundColor;
  final int? titleMaxLine;
  int? subtitleMaxLine = 1;
  final TextOverflow? overflow;

  SettingsItem(
      {required this.icons,
      this.iconStyle,
      required this.title,
      this.titleStyle,
      this.subtitle,
      this.subtitleStyle,
      this.backgroundColor,
      this.trailing,
      required this.onTap,
      this.titleMaxLine,
      this.subtitleMaxLine,
      this.overflow = TextOverflow.ellipsis});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Material(
        child: InkWell(
          onTap: () => onTap(),
          child: ListTile(
            leading: (iconStyle != null && iconStyle!.withBackground!)
                ? Container(
                    decoration: BoxDecoration(
                      color: iconStyle!.backgroundColor,
                      borderRadius:
                          BorderRadius.circular(iconStyle!.borderRadius!),
                    ),
                    padding: EdgeInsets.all(5),
                    child: Icon(
                      icons,
                      size: SettingsScreenUtils.settingsGroupIconSize,
                      color: iconStyle!.iconsColor,
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.all(5),
                    child: Icon(
                      icons,
                      size: SettingsScreenUtils.settingsGroupIconSize,
                    ),
                  ),
            title: Text(
              title,
              style: titleStyle ?? TextStyle(fontWeight: FontWeight.bold),
              maxLines: titleMaxLine,
              overflow: titleMaxLine != null ? overflow : null,
            ),
            subtitle: (subtitle != null)
                ? Text(
                    subtitle!,
                    style:
                        subtitleStyle ?? Theme.of(context).textTheme.bodyMedium!,
                    maxLines: subtitleMaxLine ?? 1,
                    overflow:
                        subtitleMaxLine != null ? TextOverflow.ellipsis : null,
                  )
                : null,
            trailing: (trailing != null) ? trailing : Icon(Icons.navigate_next),
          ),
        ),
      ),
    );
  }
}

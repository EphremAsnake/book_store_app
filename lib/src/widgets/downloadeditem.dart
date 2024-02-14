import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:resize/resize.dart';

import '../pages/navigations/settings/components/src/icon_style.dart';
import '../pages/navigations/settings/components/src/settings_screen_utils.dart';

class DownloadedItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final TextStyle? titleStyle;
  final String? author;
  final TextStyle? subtitleStyle;
  final Widget? trailing;
  final Function onTap;
  final Color? backgroundColor;
  final int? titleMaxLine;
  int? subtitleMaxLine = 1;
  final TextOverflow? overflow;

  DownloadedItem(
      {super.key,
      required this.title,
      this.titleStyle,
      this.author,
      this.subtitleStyle,
      this.backgroundColor,
      this.trailing,
      required this.onTap,
      this.titleMaxLine,
      this.subtitleMaxLine,
      this.overflow = TextOverflow.ellipsis,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        onTap: () => onTap(),
        child: ListTile(
          visualDensity: const VisualDensity(vertical: 4, horizontal: 1),
          leading: CachedNetworkImage(
            imageUrl: imageUrl,
            width: 100.h,
            height: 150.h,
            fit: BoxFit.fill,
            placeholder: (context, url) => const CircularProgressIndicator(
              color: Colors.transparent,
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          title: Text(
            title,
            style: titleStyle ?? const TextStyle(fontWeight: FontWeight.bold),
            maxLines: titleMaxLine,
            overflow: titleMaxLine != null ? overflow : null,
          ),
          subtitle: (author != null)
              ? Text(
                  author!,
                  style:
                      subtitleStyle ?? Theme.of(context).textTheme.bodyMedium!,
                  maxLines: subtitleMaxLine ?? 1,
                  overflow:
                      subtitleMaxLine != null ? TextOverflow.ellipsis : null,
                )
              : null,
          trailing:
              (trailing != null) ? trailing : const Icon(Icons.navigate_next),
        ),
      ),
    );
  }
}

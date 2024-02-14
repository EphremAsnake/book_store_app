class AppSettings {
  final PlatformSettings androidSettings;
  final PlatformSettings iosSettings;

  AppSettings({required this.androidSettings, required this.iosSettings});

  factory AppSettings.fromJson(Map<String, dynamic> json) {
    return AppSettings(
      androidSettings: PlatformSettings.fromJson(json['android_settings'] ?? {}),
      iosSettings: PlatformSettings.fromJson(json['ios_settings'] ?? {}),
    );
  }
}


class PlatformSettings {
  final SubscriptionSettings subscriptionSettings;
  final AppRateShare appRateShare;
  final HouseAd houseAd;
  final String aboutApp;
  final String fallbackServerUrl;

  PlatformSettings({
    required this.subscriptionSettings,
    required this.appRateShare,
    required this.houseAd,
    required this.aboutApp,
    required this.fallbackServerUrl,
  });

  factory PlatformSettings.fromJson(Map<String, dynamic> json) {
    return PlatformSettings(
      subscriptionSettings: SubscriptionSettings.fromJson(json['subscription_settings']??""),
      appRateShare: AppRateShare.fromJson(json['app_rate_share']??""),
      houseAd: HouseAd.fromJson(json['house_ad']??""),
      aboutApp: json['about_app']??"",
      fallbackServerUrl: json['fallback_server_url']??"",
    );
  }
}

class SubscriptionSettings {
  final String generalSubscriptionText;
  final String monthSubscriptionText;
  final String yearSubscriptionText;
  final String monthSubscriptionId;
  final String yearSubscriptionId;
  final String termOfUseUrl;
  final String privacyPolicyUrl;

  SubscriptionSettings({
    required this.generalSubscriptionText,
    required this.monthSubscriptionText,
    required this.yearSubscriptionText,
    required this.monthSubscriptionId,
    required this.yearSubscriptionId,
    required this.termOfUseUrl,
    required this.privacyPolicyUrl,
  });

  factory SubscriptionSettings.fromJson(Map<String, dynamic> json) {
    return SubscriptionSettings(
      generalSubscriptionText: json['general_subscription_text']??"",
      monthSubscriptionText: json['month_subscription_text']??"",
      yearSubscriptionText: json['year_subscription_text']??"",
      monthSubscriptionId: json['month_subscription_id']??"",
      yearSubscriptionId: json['year_subscription_id']??"",
      termOfUseUrl: json['term_of_use_url']??"",
      privacyPolicyUrl: json['privacy_policy_url']??"",
    );
  }
}

class AppRateShare {
  final String urlId;
  final String share;

  AppRateShare({required this.urlId, required this.share});

  factory AppRateShare.fromJson(Map<String, dynamic> json) {
    return AppRateShare(
      urlId: json['url_id']??"",
      share: json['share']??"",
    );
  }
}

class HouseAd {
  final String buttonText;
  final String buttonTextColor;
  final String buttonBackgroundColor;
  final bool show;
  final String urlId;

  HouseAd({
    required this.buttonText,
    required this.buttonTextColor,
    required this.buttonBackgroundColor,
    required this.show,
    required this.urlId,
  });

  factory HouseAd.fromJson(Map<String, dynamic> json) {
    return HouseAd(
      buttonText: json['button_text']??"",
      buttonTextColor: json['button_text_color']??"",
      buttonBackgroundColor: json['button_bacground_color']??"",
      show: json['show']??"",
      urlId: json['url_id']??"",
    );
  }
}

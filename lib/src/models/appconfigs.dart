class AppSettings {
  final PlatformSettings androidSettings;
  final PlatformSettings iosSettings;

  AppSettings({required this.androidSettings, required this.iosSettings});

  factory AppSettings.fromJson(Map<String, dynamic> json) {
    return AppSettings(
      androidSettings:
          PlatformSettings.fromJson(json['android_settings'] ?? {}),
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
  final List<Category> categories;
  final List<PriceRange> priceRange;

  PlatformSettings({
    required this.subscriptionSettings,
    required this.appRateShare,
    required this.houseAd,
    required this.aboutApp,
    required this.fallbackServerUrl,
    required this.categories,
    required this.priceRange,
  });

  factory PlatformSettings.fromJson(Map<String, dynamic> json) {
    return PlatformSettings(
      subscriptionSettings:
          SubscriptionSettings.fromJson(json['subscription_settings'] ?? {}),
      appRateShare: AppRateShare.fromJson(json['app_rate_share'] ?? {}),
      houseAd: HouseAd.fromJson(json['house_ad'] ?? {}),
      aboutApp: json['about_app'] ?? "",
      fallbackServerUrl: json['fallback_server_url'] ?? "",
      categories: (json['Categories'] as List<dynamic>?)
              ?.map((e) => Category.fromJson(e))
              .toList() ??
          [],
      priceRange: (json['priceRange'] as List<dynamic>?)
              ?.map((e) => PriceRange.fromJson(e))
              .toList() ??
          [],
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
      generalSubscriptionText: json['general_subscription_text'] ?? "",
      monthSubscriptionText: json['month_subscription_text'] ?? "",
      yearSubscriptionText: json['year_subscription_text'] ?? "",
      monthSubscriptionId: json['month_subscription_id'] ?? "",
      yearSubscriptionId: json['year_subscription_id'] ?? "",
      termOfUseUrl: json['term_of_use_url'] ?? "",
      privacyPolicyUrl: json['privacy_policy_url'] ?? "",
    );
  }
}

class AppRateShare {
  final String urlId;
  final String share;

  AppRateShare({required this.urlId, required this.share});

  factory AppRateShare.fromJson(Map<String, dynamic> json) {
    return AppRateShare(
      urlId: json['url_id'] ?? "",
      share: json['share'] ?? "",
    );
  }
}

class HouseAd {
  final String buttonText;
  final bool show;
  final String textMessage;
  final String urlId;

  HouseAd({
    required this.buttonText,
    required this.textMessage,
    required this.show,
    required this.urlId,
  });

  factory HouseAd.fromJson(Map<String, dynamic> json) {
    return HouseAd(
      buttonText: json['button_text'] ?? "",
      textMessage: json['text_message'] ?? "Update Your Application",
      show: json['show'] ?? false,
      urlId: json['url_id'] ?? "",
    );
  }
}

class Category {
  final String name;
  final int id;
  final String path;

  Category({required this.name, required this.id, required this.path});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['name'] ?? "",
      id: json['id'] ?? 0,
      path: json['path'] ?? "",
    );
  }
}

class PriceRange {
  final String name;
  final double price;
  final String productid;

  PriceRange(
      {required this.name, required this.price, required this.productid});

  factory PriceRange.fromJson(Map<String, dynamic> json) {
    return PriceRange(
        name: json['name'] ?? "",
        price: json['price'] ?? 1.99,
        productid: json['productID'] ?? "");
  }
}

// class PriceCategory {
//   String name;
//   double price;

//   PriceCategory({required this.name, required this.price});

//   factory PriceCategory.fromJson(Map<String, dynamic> json) {
//     return PriceCategory(
//       name: json['name'] ?? '',
//       price: json['price'] != null ? double.parse(json['price'].toString()) : 1.99,
//     );
//   }
// }


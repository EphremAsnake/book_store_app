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

// // class BookPrices {
// //   List<PriceCategory> categories;

// //   BookPrices({required this.categories});

// //   factory BookPrices.fromJson(List<dynamic> json) {
// //     List<PriceCategory> categories = json.map((category) => PriceCategory.fromJson(category)).toList();
// //     return BookPrices(categories: categories);
// //   }
// // }

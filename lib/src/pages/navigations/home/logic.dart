import 'package:book_store/src/models/book.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/appconfigs.dart';
import '../../../models/bookprices.dart';

class HomeLogic extends GetxController {
  //var categories = [].obs;
  TabController? tabController;

  TickerProvider? reference;

  RxList<Tab> allCategoriesList = <Tab>[].obs;

  RxBool allcategoriesLoader = true.obs;

  List<BookModel> allBooks = [];

  RxList<PriceRange> priceRange = RxList<PriceRange>();

  void setPriceCategories(List<PriceRange> categories) {
    priceRange.assignAll(categories);
  }

  double getPriceByName(String categoryName) {
    PriceRange? category = priceRange.firstWhere(
        (category) => category.name == categoryName,
        orElse: () => PriceRange(name: '', price: 1.99));
    return category.price;
  }

  RxList<BookModel> filteredBooks = <BookModel>[].obs;

  // Method to filter books based on selected category
  void filterBooksByCategory(String category) {
    if (category == 'All') {
      filteredBooks.value = allBooks;
    } else {
      filteredBooks.value =
          allBooks.where((book) => book.categories.contains(category)).toList();
    }
  }

  int? selectedCategoryId;

  // updateAllConsultantLoaders(bool? newValue) {
  //   allcategoriesLoader = newValue;
  //   update();
  // }

  @override
  void onInit() async {
    super.onInit();
    // await fetchCategories();
  }

  // Future<void> fetchCategories() async {
  //   try {
  //     final response = await http.get(Uri.parse('your_api_endpoint')); // Replace with your actual API endpoint

  //     if (response.statusCode == 200) {
  //       final parsedCategories = (response.body as List)
  //           .map((item) => Category.fromJson(item))
  //           .toList();
  //       categories.value = parsedCategories.map((e) => e.name!).toList(); // Extract names from parsed categories
  //     } else {
  //       print('API error: ${response.statusCode}');
  //       // Handle error appropriately, e.g., show an error message to the user
  //     }
  //   } catch (error) {
  //     print('Error fetching categories: $error');
  //     // Handle network errors or other exceptions
  //   }
  // }
}

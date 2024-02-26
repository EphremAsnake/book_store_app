import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PurchasedBooksController extends GetxController {
  final _purchasedBooks = <int>[].obs;

  List<int> get purchasedBooks => _purchasedBooks.toList();

  void addPurchasedBook(int bookId) {
    _purchasedBooks.add(bookId);
    // Save to local storage
    GetStorage().write('purchased_books', _purchasedBooks.toList());
  }

  bool isBookPurchased(int bookId) {
    return _purchasedBooks.contains(bookId);
  }

  @override
  void onInit() {
    super.onInit();
    // Read purchased books from local storage on initialization
    _purchasedBooks.value = (GetStorage().read<List>('purchased_books') ?? []).cast<int>();
  }
}

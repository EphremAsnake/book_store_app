import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DownloadedBook {
  final String id;
  final String path;

  DownloadedBook({required this.id, required this.path});
}

class DownloadedBooksController extends GetxController {
  var downloadedBooks = <DownloadedBook>[].obs;
  final _storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    loadDownloadedBooks();
  }

  Future<void> loadDownloadedBooks() async {
    final List<dynamic>? savedBooks = _storage.read('downloadedBooks');
    if (savedBooks != null) {
      downloadedBooks.value = savedBooks
          .whereType<Map<String, dynamic>>()
          .map((book) => DownloadedBook(
                id: book['id'],
                path: book['path'],
              ))
          .toList();
      debugPrint('saved books length ${downloadedBooks.length}');
    } else {
      debugPrint('no saved books');
    }
  }

  void _saveDownloadedBooks() {
    _storage.write(
        'downloadedBooks',
        downloadedBooks
            .map((book) => {'id': book.id, 'path': book.path})
            .toList());
  }

  String getBookPath(String id) {
    final book = downloadedBooks.firstWhereOrNull((book) => book.id == id);
    if (book != null) {
      debugPrint(book.path);
      return book.path;
    } else {
      throw Exception('Book with ID $id not found in downloaded books.');
    }
  }

  void addDownloadedBook(String id, String path) {
    if (!isBookDownloaded(id)) {
      downloadedBooks.add(DownloadedBook(id: id, path: path));
      _saveDownloadedBooks();
    } else {
      debugPrint('Book with ID $id is already downloaded.');
    }
  }

  bool isBookDownloaded(String id) {
    return downloadedBooks.any((book) => book.id == id);
  }

  void removeDownloadedBook(String id) {
    downloadedBooks.removeWhere((book) => book.id == id);
    _saveDownloadedBooks();
  }
}

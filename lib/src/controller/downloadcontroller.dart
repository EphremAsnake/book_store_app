import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DownloadedBook {
  final String id;
  final String path;
  final String name;
  final String thumbnailUrl;
  final String author;

  DownloadedBook(
      {required this.id,
      required this.path,
      required this.name,
      required this.thumbnailUrl,
      required this.author});
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
              name: book['name'],
              thumbnailUrl: book['thumbnailUrl'],
              author: book['author']))
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
            .map((book) => {
                  'id': book.id,
                  'path': book.path,
                  'name': book.name,
                  'thumbnailUrl': book.thumbnailUrl,
                  'author': book.author
                })
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

  // DownloadedBook getdownloadedBookData(String id) {
  //   final book = downloadedBooks.firstWhereOrNull((book) => book.id == id);
  //   if (book != null) {
  //     debugPrint(book.path);
  //     return DownloadedBook(
  //         author: book.author,
  //         id: book.id,
  //         thumbnailUrl: book.thumbnailUrl,
  //         path: book.path,
  //         name: book.name);
  //   } else {
  //     throw Exception('Book with ID $id not found in downloaded books.');
  //   }
  // }
  List<DownloadedBook> getAllDownloadedBooks() {
    return downloadedBooks.toList();
  }

  void addDownloadedBook(
      String id, String path, String name, String thumbnailUrl, String author) {
    if (!isBookDownloaded(id)) {
      downloadedBooks.add(DownloadedBook(
          id: id,
          path: path,
          name: name,
          thumbnailUrl: thumbnailUrl,
          author: author));
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

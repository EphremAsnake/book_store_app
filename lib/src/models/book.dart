class BookModel {
  final int id;
  final String name;
  final String thumbnailUrl;
  final String pdfUrl;
  final String author;
  final String description;
  final String publisher;
  final DateTime publishedDate;
  final String language;
  final List<String> categories;
  final String pricecategories;
  final int pageCount;
  final bool locked;

  BookModel({
    required this.id,
    required this.name,
    required this.thumbnailUrl,
    required this.pdfUrl,
    required this.author,
    required this.description,
    required this.publisher,
    required this.publishedDate,
    required this.language,
    required this.categories,
    required this.pricecategories,
    required this.pageCount,
    required this.locked,
  });

  factory BookModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      //! Handling null JSON gracefully
      return BookModel(
        id: 0,
        name: '',
        thumbnailUrl: '',
        pdfUrl: '',
        author: '',
        description: '',
        publisher: '',
        publishedDate: DateTime.now(),
        language: '',
        categories: [],
        pricecategories: '',
        pageCount: 0,
        locked: false,
      );
    }
    return BookModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      thumbnailUrl: json['thumbnailUrl'] ?? '',
      pdfUrl: json['pdfUrl'] ?? '',
      author: json['author'] ?? '',
      description: json['description'] ?? '',
      publisher: json['publisher'] ?? '',
      publishedDate: json['publishedDate'] != null
          ? DateTime.parse(json['publishedDate'])
          : DateTime.now(),
      language: json['language'] ?? '',
      categories: (json['categories'] as List<dynamic>?)
              ?.map((category) => category.toString())
              .toList() ??
          [],
      pricecategories: json['pricecategories'] ?? '',
      pageCount: json['pageCount'] ?? 0,
      locked: json['locked'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'thumbnailUrl': thumbnailUrl,
      'pdfUrl': pdfUrl,
      'author': author,
      'description': description,
      'publisher': publisher,
      'publishedDate': publishedDate.toIso8601String(),
      'language': language,
      'categories': categories,
      'pricecategories': pricecategories,
      'pageCount': pageCount,
      'locked': locked,
    };
  }
}


class Book {
    final String title;
    final List<String> authors;
    final String publisher;
    final String publishedDate;
    final String description;
    final Map<String, dynamic>  isbn;
    final int? pageCount;
    final List<dynamic> categories;
    final Map<String, dynamic> imageLinks;
    final String language;
    final String? subtitle;

    Book({
      required this.title,
      required this.authors,
      required this.publisher,
      required this.publishedDate,
      required this.description,
      required this.isbn,
      this.pageCount,
      required this.categories,
      required this.imageLinks,
      required this.language,
      this.subtitle,
    });

  toList() {}
}

class Book {
    final String title;
    final List<String> authors;
    final String publisher;
    final String publishedDate;
    final String description;
    final Map<String, String>  isbn;
    final int? pageCount;
    final List<String> categories;
    final Map<String, String> imageLinks;
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
}
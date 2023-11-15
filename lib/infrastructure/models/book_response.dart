
import 'package:biblio_tech_hub/infrastructure/models/book_google.dart';

class BookResponse {
    final String kind;
    final int totalItems;
    final List<Book> books;

    BookResponse({
        required this.kind,
        required this.totalItems,
        required this.books,
    });

    factory BookResponse.fromJson(Map<String, dynamic> json) => BookResponse(
        kind: json["kind"],
        totalItems: json["totalItems"],
        books: List<Book>.from(json["items"].map((x) => Book.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "kind": kind,
        "totalItems": totalItems,
        "items": List<dynamic>.from(books.map((x) => x.toJson())),
    };
}


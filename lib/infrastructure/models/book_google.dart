
class BookGoogle {
    final String id;
    final BookDetails booksDetails;

    BookGoogle({
        required this.id,
        required this.booksDetails,
    });

    factory BookGoogle.fromJson(Map<String, dynamic> json) => BookGoogle(
        id: json["id"],
        booksDetails: BookDetails.fromJson(json["volumeInfo"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "volumeInfo": booksDetails.toJson(),
    };
}

class BookDetails {
    final String title;
    final List<String> authors;
    final String publisher;
    final String publishedDate;
    final String description;
    final List<dynamic> industryIdentifiers;
    final int? pageCount;
    final List<dynamic> categories;
    final Map<String, dynamic> imageLinks;
    final String language;
    final String? subtitle;

    BookDetails({
        required this.title,
        required this.authors,
        required this.publisher,
        required this.publishedDate,
        required this.description,
        required this.industryIdentifiers,
        this.pageCount,
        required this.categories,
        required this.imageLinks,
        required this.language,
        this.subtitle,
    });

    factory BookDetails.fromJson(Map<String, dynamic> json) => BookDetails(
        title: json["title"],
        authors: List<String>.from(json["authors"].map((x) => x)),
        publisher: json["publisher"],
        publishedDate: json["publishedDate"],
        description: json["description"],
        industryIdentifiers: json['industryIdentifiers'],
        pageCount: json["pageCount"],
        categories: json['categories'],
        imageLinks: json['imageLinks'],
        language: json["language"],
        subtitle: json["subtitle"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "authors": List<dynamic>.from(authors.map((x) => x)),
        "publisher": publisher,
        "publishedDate": publishedDate,
        "description": description,
        "industryIdentifiers": industryIdentifiers,
        "pageCount": pageCount,
        "categories": categories,
        "imageLinks": imageLinks,
        "language": language,
        "subtitle": subtitle,
    };
}
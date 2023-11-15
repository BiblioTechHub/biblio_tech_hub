
class Book {
    final String id;
    final BookDetails booksDetails;

    Book({
        required this.id,
        required this.booksDetails,
    });

    factory Book.fromJson(Map<String, dynamic> json) => Book(
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
    final List<IndustryIdentifier> industryIdentifiers;
    final int? pageCount;
    final List<String> categories;
    final ImageLinks imageLinks;
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
        industryIdentifiers: List<IndustryIdentifier>.from(json["industryIdentifiers"].map((x) => IndustryIdentifier.fromJson(x))),
        pageCount: json["pageCount"],
        categories: json['categories'],
        imageLinks: ImageLinks.fromJson(json["imageLinks"]),
        language: json["language"],
        subtitle: json["subtitle"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "authors": List<dynamic>.from(authors.map((x) => x)),
        "publisher": publisher,
        "publishedDate": publishedDate,
        "description": description,
        "industryIdentifiers": List<dynamic>.from(industryIdentifiers.map((x) => x.toJson())),
        "pageCount": pageCount,
        "categories": categories,
        "imageLinks": imageLinks.toJson(),
        "language": language,
        "subtitle": subtitle,
    };
}

class ImageLinks {
    final String smallThumbnail;
    final String thumbnail;

    ImageLinks({
        required this.smallThumbnail,
        required this.thumbnail,
    });

    factory ImageLinks.fromJson(Map<String, dynamic> json) => ImageLinks(
        smallThumbnail: json["smallThumbnail"],
        thumbnail: json["thumbnail"],
    );

    Map<String, dynamic> toJson() => {
        "smallThumbnail": smallThumbnail,
        "thumbnail": thumbnail,
    };
}

class IndustryIdentifier {
    final String type;
    final String identifier;

    IndustryIdentifier({
        required this.type,
        required this.identifier,
    });

    factory IndustryIdentifier.fromJson(Map<String, dynamic> json) => IndustryIdentifier(
        type: json["type"],
        identifier: json["identifier"],
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "identifier": identifier,
    };
}

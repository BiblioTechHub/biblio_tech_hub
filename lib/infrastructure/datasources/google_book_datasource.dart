
import 'package:biblio_tech_hub/domain/datasources/book_datasource.dart';
import 'package:biblio_tech_hub/domain/entities/book.dart';
import 'package:biblio_tech_hub/infrastructure/mappers/book_mapper.dart';
import 'package:biblio_tech_hub/infrastructure/models/book_response.dart';
import 'package:dio/dio.dart';

class GoogleBookDatasource extends BookDatasource{

  final dio = Dio(BaseOptions(
    baseUrl: 'https://www.googleapis.com/',
  ));

  List<Book> _jsonToBooks(Map<String, dynamic> json){
    final bookDBResponse = BookResponse.fromJson(json);

    final List<Book> books = bookDBResponse.books.map(
      (book) => BookMapper.bookBDToEntity(book)
    ).toList();

    return books;
  }
  
  @override
  Future<Book> getBookByISBN(String isbn) async {
    final response = await dio.get('books/v1/volumes',
      queryParameters: {
        'q' : 'isbn:$isbn'
      }
    );

    return _jsonToBooks(response.data).first;
  }
  
  @override
  Future<List<Book>> getBookDrama() async {
    final response = await dio.get('books/v1/volumes',
      queryParameters: {
        'q' : 'subject:drama'
      }
    );

    return _jsonToBooks(response.data);
  }

  @override
  Future<Book> getBookByTitle(String title) async {
    final response = await dio.get('books/v1/volumes',
      queryParameters: {
        'q' : 'intitle:$title'
      }
    );

    return _jsonToBooks(response.data).first;
  }

}
import 'package:biblio_tech_hub/infrastructure/datasources/google_book_datasource.dart';
import 'package:biblio_tech_hub/infrastructure/repositories/book_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final googleRepositoryProvider = Provider((ref) {
  return BookRepositoryImpl(GoogleBookDatasource());
});
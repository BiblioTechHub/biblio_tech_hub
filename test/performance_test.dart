

import 'package:biblio_tech_hub/infrastructure/datasources/google_book_datasource.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Time it takes for a book by ISBN', () async {
    final Stopwatch stopwatch = Stopwatch()..start();

    await GoogleBookDatasource().getBookByISBN('9780596001087');

    stopwatch.stop();

    print('Time it takes for a book by ISBN -> ${stopwatch.elapsed.inMilliseconds} ms');
    expect(stopwatch.elapsed.inMilliseconds, lessThan(1500));
  });

  test('Time it takes to obtain the drama books', () async {
    final Stopwatch stopwatch = Stopwatch()..start();

    await GoogleBookDatasource().getBookbyCategory('Drama');

    stopwatch.stop();

    print('Time it takes to obtain the drama books -> ${stopwatch.elapsed.inMilliseconds} ms');
    expect(stopwatch.elapsed.inMilliseconds, lessThan(1500));
  });

  test('Time  it takes to obtain the books by title', () async {
    final Stopwatch stopwatch = Stopwatch()..start();

    await GoogleBookDatasource().getBookByTitle('Clean code');

    stopwatch.stop();

    print('Time  it takes to obtain the books by title -> ${stopwatch.elapsed.inMilliseconds} ms');
    expect(stopwatch.elapsed.inMilliseconds, lessThan(1500));
  });
}


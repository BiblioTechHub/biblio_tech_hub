import 'package:biblio_tech_hub/domain/entities/book.dart';
import 'package:biblio_tech_hub/presentation/riverpod/book_category_provider.dart';
import 'package:biblio_tech_hub/presentation/riverpod/book_details_view_provider.dart';
import 'package:biblio_tech_hub/presentation/riverpod/book_stock_provider.dart';
import 'package:biblio_tech_hub/presentation/widgets/logo_and_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: size.height * 0.05),
            const LogoAndTitle(),
            SizedBox(height: size.height * 0.02),
            HorizontalListView(size: size, title: 'Novedades >', books: ref.watch(bookStockProvider),),
            SizedBox(height: size.height * 0.03),
            HorizontalListView(size: size, title: 'Lo más leido >', books: ref.watch(bookStockProvider),),
            SizedBox(height: size.height * 0.03),
            HorizontalListView(size: size, title: 'Drama', books: ref.watch(bookCategoryProvider)),
          ]
        ),
      ),
    );
  }
}



class HorizontalListView extends ConsumerWidget {
  const HorizontalListView({super.key, 
    required this.size,
    required this.title,
    required this.books
  });

  final Size size;
  final String title;
  final List<BookState> books;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final booksState = books;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: size.height * 0.02),
      decoration: const BoxDecoration(
        border: Border.symmetric(horizontal: BorderSide(width: 1)), 
        color: Colors.white
      ),
      alignment: Alignment.centerLeft,
      width: size.width,
      height: size.height * 0.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontFamily: 'Bangers', fontSize: size.height * 0.04)),
          Expanded(child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: booksState.length,
            itemBuilder: (context, index) {
              return _Slide(book: booksState[index].book, size: size,);
            },
          ))
        ],
      ),
    );
  }
}

class _Slide extends ConsumerWidget {
  const _Slide({required this.book, required this.size});

  final Book book;
  final Size size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.all(size.width * 0.03),
        child: Column(
          children: [
            SizedBox(
              width: size.width * 0.4,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: FadeInImage(
                  height: size.height * 0.26,
                  fit: BoxFit.fill,
                  placeholder: const AssetImage('assets/loaders/bottle-loader.gif'),
                  image: NetworkImage(book.imageLinks)
                ),
              ),
            ),
            SizedBox(
              width: size.width * 0.4,
              child: Text(book.title, style: const TextStyle(fontWeight: FontWeight.bold), maxLines: 2)),
            // SizedBox(width: size.width * 0.3)
          ],
        ),
      ),
      onTap: () async {
        ref.read(bookDetailsViewProvider.notifier).setBook(book);
        context.push('/home/0/book/${0}');
      },
    );
  }
}


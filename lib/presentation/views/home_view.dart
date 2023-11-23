import 'package:biblio_tech_hub/domain/entities/book.dart';
import 'package:biblio_tech_hub/presentation/riverpod/book_details_view_provider.dart';
import 'package:biblio_tech_hub/presentation/riverpod/book_stock_provider.dart';
import 'package:biblio_tech_hub/presentation/widgets/logo_and_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: size.height * 0.08),
            const LogoAndTitle(),
            SizedBox(height: size.height * 0.05),

            HorizontalListView(size: size),
          ]
        ),
      ),
    );
  }
}



class HorizontalListView extends ConsumerWidget {
  const HorizontalListView({super.key, 
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final books = ref.watch(bookStockProvider);
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
          Text('LO MAS NUEVO >', style: TextStyle(fontFamily: 'Bangers', fontSize: size.height * 0.04)),
          Expanded(child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: books.length,
            itemBuilder: (context, index) {
              return _Slide(book: books[index], size: size,);
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
                  height: size.height * 0.3,
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
        context.push('/home/0/book/${book.isbn}');
      },
    );
  }
}


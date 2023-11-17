import 'package:biblio_tech_hub/presentation/riverpod/book_stock_provider.dart';
import 'package:biblio_tech_hub/presentation/widgets/logo_and_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

            _HorizontalListView(size: size),
          ]
        ),
      ),
    );
  }
}

class _HorizontalListView extends ConsumerWidget{
  const _HorizontalListView({
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(bookStockProvider.notifier).getBook();
    final books = ref.watch(bookStockProvider);
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: size.height * 0.02),
        decoration: const BoxDecoration(
          border: Border.symmetric(horizontal: BorderSide(width: 1)), 
          color: Colors.white
        ),
        alignment: Alignment.centerLeft,
        width: size.width,
        child: Column(
          children: [
            Text('LO MAS NUEVO >', style: TextStyle(fontFamily: 'Bangers', fontSize: size.height * 0.04)),
            Expanded(
              child: ListView.builder(
                itemCount: books.length,
                itemBuilder: (context, index) {
                  return Text(books[index].title);
                }
              ),
            )
          ],
        ),
      ),
    );
  }
}


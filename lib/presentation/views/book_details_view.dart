
import 'package:biblio_tech_hub/domain/entities/book.dart';
import 'package:biblio_tech_hub/presentation/riverpod/book_details_view_provider.dart';
import 'package:biblio_tech_hub/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';




class BookDetailsView extends ConsumerWidget {

  const BookDetailsView({super.key, required this.pageIndex});

  final int pageIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final book = ref.watch(bookDetailsViewProvider);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          const BookBackground(),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: size.height * 0.067),
                AppLogo(),
                SizedBox(height: size.height * 0.03),
            
                //* Card
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      //* Header
                      _Header(size: size, book: book),
            
                      _Body(size: size, book: book)
                    ],
                  ),
                ),

                //TODO: Controlar la visualizacion de los botones
                //* Button 'RequestBorrow'
                ElevatedButton(
                  style: _buttonStyle(size, const Color(0xFF8C42F7)),
                  onPressed: () {
                  
                  },
                  child: const Text('Solicitar préstamo', style: TextStyle(color: Colors.black),), 
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //* Button 'ExtendBook'
                    ElevatedButton(
                      style: _buttonStyle(size, const Color(0xFFD5E191)),
                      onPressed: () {
                      
                      },
                      child: const Text('Ampliar préstamo', style: TextStyle(color: Colors.black),), 
                    ),
                    ElevatedButton(
                      style: _buttonStyle(size, const Color(0xFFFF9B4E)),
                      onPressed: () {
                      
                      },
                      child: const Text('Devolver préstamo', style: TextStyle(color: Colors.black),), 
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: CustomBottomNavigation(currentIndex: pageIndex),
    );
  }

  ButtonStyle _buttonStyle(Size size, Color color) {
    return ElevatedButton.styleFrom(
      backgroundColor: color,
      shape: RoundedRectangleBorder(
        side: BorderSide.none,
        borderRadius: BorderRadius.circular(10)
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    required this.size,
    required this.book,
  });

  final Size size;
  final Book book;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.005, vertical: size.width * 0.03),
      padding: EdgeInsets.all(size.width * 0.03),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(border: Border.all(width: size.width * 0.002, color: Colors.black45)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Acerca del libro', style: TextStyle(fontSize: size.height * 0.025 , fontWeight: FontWeight.bold)),
          SizedBox(height: size.height * 0.015),
          //tiene que estar el texto en cursiva
          Text('ISBN: ${book.isbn}', style: TextStyle(fontSize: size.height * 0.02, fontStyle: FontStyle.italic)),
          SizedBox(height: size.height * 0.015),
          Text('Número de páginas: ${book.pageCount}', style: TextStyle(fontSize: size.height * 0.02)),
          SizedBox(height: size.height * 0.015),
          Text('Editorial: ${book.publisher}', style: TextStyle(fontSize: size.height * 0.02, fontStyle: FontStyle.italic)),
          SizedBox(height: size.height * 0.015),
          Text('Sinopsis: ${book.description}', style: TextStyle(fontSize: size.height * 0.02, fontStyle: FontStyle.italic), maxLines: 6),
        ],
      ), 
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.size, 
    required this.book,
  });

  final Size size;
  final Book book;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.network(
          book.imageLinks,
          height: size.height * 0.25,
        ),
        SizedBox(width: size.width * 0.05),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(book.title, style: Theme.of(context).textTheme.titleLarge),
              SizedBox(height: size.height * 0.005),
              Text(book.authors[0], style: Theme.of(context).textTheme.titleMedium),
              SizedBox(height: size.height * 0.02),
              Text('Fecha de Publicación: ${book.publishedDate}', style: Theme.of(context).textTheme.titleSmall),
              
              // TODO: Comprobar si el libro esta prestado
              SizedBox(height: size.height * 0.02),
              Container(
                color: const Color.fromARGB(137, 117, 117, 117),
                width: double.maxFinite,
                padding: EdgeInsets.all(size.width * 0.01),
                child: const Text('Fecha de devolución: \nXXXX', textAlign: TextAlign.center)
              ),
            ],
          ),
        )
      ],
    );
  }
}

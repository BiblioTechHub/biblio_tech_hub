
import 'package:biblio_tech_hub/domain/entities/book.dart';
import 'package:biblio_tech_hub/presentation/riverpod/book_isbn_details_provider.dart';
import 'package:biblio_tech_hub/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class BookInfoView extends ConsumerStatefulWidget {
  BookInfoView({super.key, required this.isbn});

  int isbn;

  @override
  ConsumerState<BookInfoView> createState() => _BookInfoViewState();
}

class _BookInfoViewState extends ConsumerState<BookInfoView> {

  @override
  void initState() {
    super.initState();
    ref.read(bookIsbnDetailsProvider.notifier).getBook(widget.isbn.toString());
  }


  @override
  Widget build(BuildContext context) {
    final book = ref.watch(bookIsbnDetailsProvider);
    final size = MediaQuery.of(context).size;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: size.height * 0.067),
          const AppLogo(),
          SizedBox(height: size.height * 0.03),
      
          //* Card
          Expanded(
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  //*Header
                  _Header(size: size, book: book),
      
                  //* Details
                  _BookDetails(size: size, book: book),
      
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
                  )
                  
                ],
              )
            )
          )
        ],
      ),
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

class _BookDetails extends StatelessWidget {
  const _BookDetails({
    required this.size,
    required this.book,
  });

  final Size size;
  final Book book;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(size.width * 0.03),
      padding: EdgeInsets.all(size.width * 0.025),
      width: double.infinity,
      decoration: BoxDecoration(border: Border.all(width: size.width * 0.002, color: Colors.black45)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Acerca del libro', style: TextStyle(fontSize: size.height * 0.02 , fontWeight: FontWeight.bold)),
          SizedBox(height: size.height * 0.015),
          Text('ISBN: ${book.isbn}', style: TextStyle(fontSize: size.height * 0.015)),
          SizedBox(height: size.height * 0.015),
          Text('Número de páginas: ${book.pageCount}', style: TextStyle(fontSize: size.height * 0.015)),
          SizedBox(height: size.height * 0.015),
          Text('Editorial: ${book.publisher}', style: TextStyle(fontSize: size.height * 0.015)),
          SizedBox(height: size.height * 0.015),
          Text('Sinopsis: ${book.description}', style: TextStyle(fontSize: size.height * 0.015), maxLines: 6),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.size, required this.book,
  });

  final Size size;
  final Book book;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(size.width * 0.05),
      child: Row(
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
                Text('Titulo del Libro', style: Theme.of(context).textTheme.titleLarge),
                SizedBox(height: size.height * 0.005),
                Text('Autor del libro', style: Theme.of(context).textTheme.titleMedium),
                SizedBox(height: size.height * 0.02),
                Text('Fecha de Publicación: XXXX', style: Theme.of(context).textTheme.titleSmall),
    
                // TODO: Compribar si el libro esta prestado
                SizedBox(height: size.height * 0.02),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(size.width * 0.01),
                  color: Colors.black45,
                  child: const Text('Fecha de devolución: \nXXXX', textAlign: TextAlign.center),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
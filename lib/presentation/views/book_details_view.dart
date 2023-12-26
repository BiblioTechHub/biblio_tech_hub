
import 'package:biblio_tech_hub/domain/entities/book.dart';
import 'package:biblio_tech_hub/presentation/riverpod/book_details_view_provider.dart';
import 'package:biblio_tech_hub/presentation/riverpod/book_stock_provider.dart';
import 'package:biblio_tech_hub/presentation/riverpod/loans_user_provider.dart';
import 'package:biblio_tech_hub/presentation/riverpod/user_provider.dart';
import 'package:biblio_tech_hub/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nfc_manager/nfc_manager.dart';



class BookDetailsView extends ConsumerStatefulWidget {

  const BookDetailsView({super.key, required this.pageIndex});

  final int pageIndex;

  @override
  ConsumerState<BookDetailsView> createState() => _BookDetailsViewState();
}

class _BookDetailsViewState extends ConsumerState<BookDetailsView> {
  
  @override
  Widget build(BuildContext context) {

    final book = ref.watch(bookDetailsViewProvider);
    final List<BookState> bookStock = ref.watch(bookStockProvider);
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
                const AppLogo(),
                SizedBox(height: size.height * 0.03),
            
                //* Card
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      //* Header
                      _Header(size: size, book: book),
                      _Body(size: size, book: book)
                    ],
                  ),
                ),
                
                _RequestLoanButton(bookStock: bookStock, isbn: book.isbn, size: size),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: nfcButton(book: book),
      
      //floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
      //floatingActionButton: Padding(
      //  padding: EdgeInsets.only(top: size.height * 0.015),
      //  child: FloatingActionButton(
      //    child: const Icon(Icons.arrow_back),
      //    onPressed: () => context.pop(),
      //  ),
      //),
      bottomNavigationBar: CustomBottomNavigation(currentIndex: widget.pageIndex),
    );
  }
  Widget nfcButton({required Book book}) {
  return FloatingActionButton(
    onPressed: () => _ndefWrite(book.isbn),
    tooltip: 'Tag Write',
    child: Image.asset(
      'assets/logo_nfc.png',
      width: 36.0,
      height: 36.0,
    ),
  );
}

void _ndefWrite(String isbn) {
  NfcManager.instance.startSession(onDiscovered: (NfcTag? tag) async {
    if (tag != null) {
      var ndef = Ndef.from(tag);

      NdefMessage message = NdefMessage([
        NdefRecord.createText(isbn),
      ]);

      if (ndef != null) {
        await ndef.write(message);
        NfcManager.instance.stopSession();
      }
    }
  });
}
}

class _RequestLoanButton extends ConsumerWidget {
  const _RequestLoanButton({required this.bookStock, required this.isbn, required this.size});

  final List<BookState> bookStock;
  final String isbn;
  final Size size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final loanISBNBook = List<String>.from(ref.watch(loansUserProvider).map((e) => e.book.isbn));

    for(var bookState_ in bookStock){
      if(bookState_.book.isbn == isbn && bookState_.isAvailable && !bookState_.isBorrowed
          && ref.watch(userProvider).user != null) {
        return ElevatedButton(
          style: _buttonStyle(size, const Color(0xFF8C42F7)),
          onPressed: () {
            ref.read(loansUserProvider.notifier).makeLoan(bookState_);
          },
          child: const Text('Solicitar préstamo', style: TextStyle(color: Colors.black),), 
        );
      }else if(bookState_.book.isbn == isbn && bookState_.isAvailable 
                && bookState_.isBorrowed && loanISBNBook.contains(isbn)) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              style: _buttonStyle(size, const Color(0xFFD5E191)),
              onPressed: () {
                ref.read(loansUserProvider.notifier).extendLoan(bookState_);
              },
              child: const Text('Ampliar préstamo', style: TextStyle(color: Colors.black),), 
            ),
            ElevatedButton(
              style: _buttonStyle(size, const Color(0xFFFF9B4E)),
              onPressed: () {
                ref.read(loansUserProvider.notifier).giveBackLoan(bookState_);
              },
              child: const Text('Devolver préstamo', style: TextStyle(color: Colors.black),), 
            )
          ],
        );
      }
    }

    return const SizedBox();
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
          Text('Sinopsis: ${book.description}', style: TextStyle(fontSize: size.height * 0.02, fontStyle: FontStyle.italic), maxLines: 10),
        ],
      ), 
    );
  }
}

class _Header extends ConsumerWidget {
  const _Header({
    required this.size, 
    required this.book,
  });

  final Size size;
  final Book book;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        book.imageLinks == ''
        ? Image.asset(
            'assets/default_imagen_book.png',
            height: size.height * 0.25,
          )
        : Image.network(
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
              
              SizedBox(height: size.height * 0.02),
              Container(
                color: const Color.fromARGB(137, 117, 117, 117),
                width: double.maxFinite,
                padding: EdgeInsets.all(size.width * 0.01),
                child: ref.watch(loansUserProvider.notifier).getExpirationDate(book.isbn) != null
                  ? Text('Fecha de devolución: \n ${ref.watch(loansUserProvider.notifier).getExpirationDate(book.isbn)}', textAlign: TextAlign.center)
                  : Text('Fecha de devolución: \n XX/XX/XXXX', textAlign: TextAlign.center)
              ),
            ],
          ),
        )
      ],
    );
  }
}

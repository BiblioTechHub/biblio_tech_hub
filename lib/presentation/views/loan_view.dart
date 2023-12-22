
import 'package:biblio_tech_hub/presentation/riverpod/book_details_view_provider.dart';
import 'package:biblio_tech_hub/presentation/riverpod/loans_user_provider.dart';
import 'package:biblio_tech_hub/presentation/widgets/app_logo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoanView extends ConsumerWidget {
  const LoanView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final size = MediaQuery.of(context).size;
    final loan = ref.watch(loansUserProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(height: size.height * 0.067),
                const AppLogo(),
                SizedBox(height: size.height * 0.03),
                Container(
                  alignment: Alignment.topLeft,
                  color: Colors.white,
                  child: _Header(size: size),
                ),
              ],
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: true,
            child: Container(
              color: Colors.white,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: size.height * 0.01),
                itemCount: loan.length,
                itemBuilder: (context, index) {
                  return _Cardloan(loan: ref.watch(loansUserProvider)[index], size: size);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Cardloan extends ConsumerWidget {
  const _Cardloan({required this.loan, required this.size});

  final LoanState loan;
  final Size size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  loan.book.imageLinks == ''
                  ? Image.asset(
                      'assets/default_imagen_book.png',
                      height: size.height * 0.13,
                    )
                  : Image.network(
                      loan.book.imageLinks,
                      height: size.height * 0.13,
                    ),
                  SizedBox(width: size.width * 0.04),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          loan.book.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '${loan.book.authors} - ${loan.book.publishedDate}',
                          style: const TextStyle(
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          loan.book.description, 
                          overflow: TextOverflow.ellipsis, 
                          maxLines: 3,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 10),
              Text(
                'Fecha de Devolución: ${formatDate(loan.expirationDate)}',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 18
                ),
              )
            ],
          ),
        )
      ),
      onTap: () async {
        ref.read(bookDetailsViewProvider.notifier).setBook(loan.book);
        context.push('/home/0/book/${2}');
      },
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.size});

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20,25,0,15),
      child: Row(
        children: [
          Text("Préstamos Activos",
              style: TextStyle(
                  fontSize: size.height * 0.03,
                  fontFamily: 'Bangers')),
          Icon(Icons.arrow_forward_ios_outlined, color: Colors.black, size: size.height * 0.03),
        ],
      ),
    );
  }
}

String formatDate(Timestamp timestamp) {
    // Convertir el Timestamp a DateTime
    DateTime dateTime = timestamp.toDate();

    // Formatear la fecha como dd/mm/aaaa
    String formattedDate = '${dateTime.day}/${dateTime.month}/${dateTime.year}';

    return formattedDate;
  }

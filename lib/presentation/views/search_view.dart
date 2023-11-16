import 'package:biblio_tech_hub/presentation/widgets/app_logo.dart';
import 'package:flutter/material.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: size.height * 0.067),
            const AppLogo(),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            // Lógica de búsqueda aquí
                            print('Botón de búsqueda presionado');
                          },
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: TextField(
                            maxLines: 1,
                            expands: false,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Buscar libros...',
                            ),
                            onChanged: (query) {
                              // Manejar la lógica de búsqueda aquí
                              print('Consulta de búsqueda: $query');
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: size.height * 0.688, // Ajusta la altura según tus necesidades
              color: Colors.white, // Fondo blanco para el contenedor de libros
              child: ListView.builder(
                itemCount: 10, // Reemplaza con la longitud real de la lista de libros
                itemBuilder: (context, index) {
                  // Aquí puedes construir la vista del libro para cada elemento en la lista
                  return buildLibroCard();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLibroCard() {
  // Ejemplo de datos de libro
  String title = 'Título del Libro';
  String author = 'Autor del Libro';
  String year = '2023';
  String description = 'Descripción del libro...';

  return Card(
    child: ListTile(
      contentPadding: const EdgeInsets.all(16),
      leading: Image.network(
        'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcQ2n0C4rLOzlxj2JXNN2plb8ORuQ82BFLWfrjuR1UzHsJfKlIiqSj7Mu3RA0DHMvPgL22tPBZI6YxbyH08Emi_p9bYfcc4kZqB4vCXQh2Wx&usqp=CAc',
        width: 100,
        height: 140,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 18, // Tamaño de letra para el título
          fontWeight: FontWeight.bold, // Negrita
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$author - $year',
            style: const TextStyle(
              fontStyle: FontStyle.italic, // Cursiva
            ),
          ),
          const SizedBox(height: 8), // Espacio entre el autor y la descripción
          Text(
            description,
            style: const TextStyle(
              fontSize: 14, // Tamaño de letra para la descripción
            ),
          ),
        ],
      ),
    ),
  );
}
}
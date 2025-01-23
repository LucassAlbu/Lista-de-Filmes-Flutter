import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'movie_controller.dart';
import 'cart_screen.dart';

class HomeScreen extends StatelessWidget {
  final MovieController movieController = Get.put(MovieController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange, // Cor de laranja para a AppBar
        title: Text(
          'Movie Catalog',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          Obx(() => Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart, color: Colors.white),
                onPressed: () {
                  Get.to(CartScreen());
                },
              ),
              if (movieController.cart.isNotEmpty)
                Positioned(
                  right: 4,
                  top: 4,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '${movieController.cart.length}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          )),
        ],
      ),
      body: SafeArea(
        child: Obx(() {
          if (movieController.isLoading.value) {
            return Center(child: CircularProgressIndicator(color: Colors.orange));
          } else if (movieController.error.value.isNotEmpty) {
            return Center(child: Text(movieController.error.value, style: TextStyle(color: Colors.white)));
          } else {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              padding: EdgeInsets.all(10),
              itemCount: movieController.movies.length,
              itemBuilder: (context, index) {
                final movie = movieController.movies[index];
                final isInCart = movieController.cart.contains(movie);
                return Card(
                  color: Colors.grey[900],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
                          child: Image.network(
                            'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          movie.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: Icon(
                                isInCart ? Icons.check : Icons.shopping_cart,
                                color: isInCart ? Colors.yellow : Colors.white,
                              ),
                              onPressed: () {
                                if (!isInCart) {
                                  movieController.addToCart(movie);
                                }
                              },
                            ),
                            Text(
                              'R\$${movie.price.toStringAsFixed(2)}',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        }),
      ),
      backgroundColor: Colors.black,
    );
  }
}

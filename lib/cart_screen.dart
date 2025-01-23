import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'movie_controller.dart';

class CartScreen extends StatelessWidget {
  final MovieController movieController = Get.find<MovieController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange, // Cor de laranja para a AppBar
        title: Text(
          'Cart',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Obx(() {
          if (movieController.cart.isEmpty) {
            return Center(child: Text('No items in the cart', style: TextStyle(color: Colors.white)));
          } else {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(8.0),
                    itemCount: movieController.cart.length,
                    itemBuilder: (context, index) {
                      final movie = movieController.cart[index];
                      return ListTile(
                        leading: Image.network('https://image.tmdb.org/t/p/w500${movie.posterPath}'),
                        title: Text(movie.title, style: TextStyle(color: Colors.white)),
                        subtitle: Text('R\$${movie.price.toStringAsFixed(2)}', style: TextStyle(color: Colors.white70)),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Limpa o carrinho e mostra a mensagem de compra realizada
                      movieController.clearCart();
                      Get.snackbar(
                        'Purchase Completed',
                        'Compra realizada com sucesso!',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.orange, // Cor de laranja para a mensagem
                        colorText: Colors.white,
                        margin: EdgeInsets.all(10),
                        borderRadius: 8,
                      );
                    },
                    child: Text('Finalizar Compra'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black, backgroundColor: Colors.yellow, // Texto do botão em preto
                      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                      textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 5,
                    ),
                  ),
                ),
              ],
            );
          }
        }),
      ),
      backgroundColor: Colors.black,
    );
  }
}

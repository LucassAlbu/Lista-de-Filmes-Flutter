import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'movie.dart';

class MovieController extends GetxController {
  // Lista observável de filmes
  var movies = <Movie>[].obs;
  var isLoading = true.obs;
  var error = ''.obs;
  // Chave da API do TMDB
  final String apiKey = 'af3a0aafaafed7cea116d1afa912d7b3';

  @override
  void onInit() {
    fetchMovies(); // Busca os filmes ao inicializar o controller
    super.onInit();
  }

  // Método para buscar filmes populares na API do TMDB
  void fetchMovies() async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse('https://api.themoviedb.org/3/movie/popular?api_key=$apiKey'));
      if (response.statusCode == 200) {
        var movieList = json.decode(response.body)['results'] as List;
        movies.value = movieList.map((json) => Movie.fromJson(json)).toList();
      } else {
        error('Failed to load movies');
      }
    } catch (e) {
      error('Failed to load movies');
    } finally {
      isLoading(false);
    }
  }

  var cart = <Movie>[].obs;

  // Método para adicionar filmes ao carrinho
  void addToCart(Movie movie) {
    cart.add(movie);
  }

  // Método para limpar o carrinho
  void clearCart() {
    cart.clear();
  }
}

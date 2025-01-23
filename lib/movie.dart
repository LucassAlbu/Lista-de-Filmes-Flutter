class Movie {
  final String title;
  final double price;
  final String posterPath;

  Movie({required this.title, required this.price, required this.posterPath});

  // Cria uma instância de Movie a partir de um JSON
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['title'],
      price: json['vote_average'].toDouble(), // Usar média de votos como preço fictício
      posterPath: json['poster_path'],
    );
  }
}
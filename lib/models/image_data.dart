class ImageData {
  final String id;
  final String author;
  final String imageUrl;

  ImageData({required this.id, required this.author, required this.imageUrl});

  factory ImageData.fromJson(Map<String, dynamic> json) {
    return ImageData(
      id: json['id'],
      author: json['author'],
      imageUrl: json['download_url'],
    );
  }
}

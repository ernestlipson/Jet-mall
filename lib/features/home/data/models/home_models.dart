class Category {
  final String name;
  final String imageUrl;

  const Category({required this.name, required this.imageUrl});
}

class Product {
  final String name;
  final double price;
  final List<String> imageUrls;
  final String color;
  final bool isFavorite;

  const Product({
    required this.name,
    required this.price,
    required this.imageUrls,
    required this.color,
    this.isFavorite = false,
  });
}

class PromoBanner {
  final String title;
  final String description;
  final String imageUrl;
  final String buttonText;

  const PromoBanner({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.buttonText,
  });
}

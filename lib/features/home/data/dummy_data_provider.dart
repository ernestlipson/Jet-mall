import 'package:cdc_mall/features/home/data/models/home_models.dart';

/// Class providing dummy data for the home page UI
class DummyDataProvider {
  static List<Category> getCategories() {
    return const [
      Category(
          name: 'Women',
          imageUrl: 'https://via.placeholder.com/100/FFCDD2/000000?text=Women'),
      Category(
          name: 'Men',
          imageUrl: 'https://via.placeholder.com/100/BBDEFB/000000?text=Men'),
      Category(
          name: 'Kids',
          imageUrl: 'https://via.placeholder.com/100/C8E6C9/000000?text=Kids'),
      Category(
          name: 'Teens',
          imageUrl: 'https://via.placeholder.com/100/FFE0B2/000000?text=Teens'),
      Category(
          name: 'Accessories',
          imageUrl:
              'https://via.placeholder.com/100/D1C4E9/000000?text=Accessories'),
    ];
  }

  /// Get promotional banners for the "Popular Item" carousel
  static List<PromoBanner> getPromoBanners() {
    return const [
      PromoBanner(
        title: 'Get your special',
        description: 'sale up to 50% off',
        imageUrl:
            'https://via.placeholder.com/400x200/FFF2EA/000000?text=Special+Sale',
        buttonText: 'Shop now',
      ),
      PromoBanner(
        title: 'New Season',
        description: 'Spring collection',
        imageUrl:
            'https://via.placeholder.com/400x200/E8F5E9/000000?text=Spring+Collection',
        buttonText: 'Explore',
      ),
      PromoBanner(
        title: 'Limited Edition',
        description: 'Exclusive items',
        imageUrl:
            'https://via.placeholder.com/400x200/E3F2FD/000000?text=Limited+Edition',
        buttonText: 'View now',
      ),
    ];
  }

  /// Get new products for the "New In" section
  static List<Product> getNewProducts() {
    return const [
      Product(
        name: 'Hoodie Black',
        price: 160.00,
        color: 'Black',
        imageUrls: [
          'https://via.placeholder.com/150/212121/FFFFFF?text=Black+Hoodie'
        ],
        isFavorite: false,
      ),
      Product(
        name: 'Hoodie Blue',
        price: 150.00,
        color: 'Blue',
        imageUrls: [
          'https://via.placeholder.com/150/1E88E5/FFFFFF?text=Blue+Hoodie'
        ],
        isFavorite: true,
      ),
      Product(
        name: 'T-shirt White',
        price: 89.99,
        color: 'White',
        imageUrls: [
          'https://via.placeholder.com/150/F5F5F5/000000?text=White+Tshirt'
        ],
        isFavorite: false,
      ),
      Product(
        name: 'Jeans Dark Blue',
        price: 120.50,
        color: 'Dark Blue',
        imageUrls: [
          'https://via.placeholder.com/150/0D47A1/FFFFFF?text=Dark+Blue+Jeans'
        ],
        isFavorite: true,
      ),
    ];
  }
}

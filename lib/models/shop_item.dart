
class ShopItem {
  final String id;
  final String title;
  final String subtitle;
  final String imageUrl;
  final double price;

  ShopItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.price,
  });

  // Named constructors provide a way to create objects with specific configurations or initializations.
  // Unlike the default constructor,
  // which has the same name as the class, named constructors have different names.
  // With User.fromJson() constructor, we are constructing a new User instance from a map structure.
  ShopItem.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        title = json['title'] as String,
        subtitle = json['subtitle'] as String,
        imageUrl = json['imageUrl'] as String,
        price = json['price'] as double;

  // Helper method toJson to convert to JsonMap
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'subtitle': subtitle,
        'imageUrl': imageUrl,
        'price': price,
      };

}

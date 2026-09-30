/// A single item on the Dunkin' Philippines menu.
class MenuItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final String categoryId;
  final String image;
  final List<String> tags;
  final bool isPopular;

  const MenuItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.categoryId,
    required this.image,
    this.tags = const [],
    this.isPopular = false,
  });
}

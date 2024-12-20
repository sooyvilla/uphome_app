class Project {
  final int id;
  final int agencyId;
  final String name;
  final String location;
  final int price;
  final String? imageUrl;

  Project({
    required this.id,
    required this.agencyId,
    required this.name,
    required this.location,
    required this.price,
    this.imageUrl,
  });
}

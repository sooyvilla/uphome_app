import '../entities/project.dart';

class ProjectMapper {
  static Project fromMap(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      agencyId: json['agency_id'],
      name: json['name'],
      location: json['location'],
      price: json['price'],
      imageUrl: json['image_url'],
      // description: json['description'],
    );
  }

  static Map<String, dynamic> toMap(Project project) {
    return {
      'agency_id': project.agencyId,
      'name': project.name,
      'location': project.location,
      'price': project.price,
      'image_url': project.imageUrl,
      // 'description': project.description,
    };
  }
}

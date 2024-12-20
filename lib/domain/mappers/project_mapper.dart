import 'package:uphome_app/domain/entities/project.dart';

class ProjectMapper {
  static Project fromMap(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      agencyId: json['agency_id'],
      name: json['name'],
      location: json['location'],
      price: json['price'],
      imageUrl: json['image_url'],
    );
  }

  static Map<String, dynamic> toMap(Project project) {
    return {
      'id': project.id,
      'agency_id': project.agencyId,
      'name': project.name,
      'location': project.location,
      'price': project.price,
      'image_url': project.imageUrl,
    };
  }
}

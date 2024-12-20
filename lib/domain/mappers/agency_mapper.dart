import 'package:uphome_app/domain/entities/agency.dart';

class AgencyMapper {
  static Agency fromMap(Map<String, dynamic> json) {
    return Agency(
      id: json['id'],
      name: json['name'],
      themeColor: json['theme_color'],
      logo: json['logo'],
    );
  }

  static Map<String, dynamic> toMap(Agency agency) {
    return {
      'id': agency.id,
      'name': agency.name,
      'theme_color': agency.themeColor,
      'logo': agency.logo,
    };
  }
}

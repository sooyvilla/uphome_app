import 'package:uphome_app/domain/entities/agency.dart';

abstract class AgencyRespository {
  Future<List<Agency>> getAgencies();
  Future<Agency> getAgencyById(int id);
}

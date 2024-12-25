import '../entities/agency.dart';

abstract class AgencyDatasource {
  Future<List<Agency>> getAgencies();
  Future<Agency> getAgencyById(int id);
}

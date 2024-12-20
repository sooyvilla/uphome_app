import 'package:uphome_app/domain/datasource/agency_datasource.dart';
import 'package:uphome_app/domain/entities/agency.dart';
import 'package:uphome_app/domain/repositories/agency_respository.dart';

class AgencyRepositoryImpl implements AgencyRespository {
  final AgencyDatasource datasource;

  AgencyRepositoryImpl(this.datasource);

  @override
  Future<List<Agency>> getAgencies() {
    return datasource.getAgencies();
  }

  @override
  Future<Agency> getAgencyById(int id) {
    return datasource.getAgencyById(id);
  }
}

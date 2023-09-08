import 'package:cakeshopapp/domain/entities/client.dart';
import 'package:cakeshopapp/infraestructure/models/clientdb/clientdb_search_response.dart';

class ClientMapper {
  static Client clientDbEntity(Datum client) => Client(
      name: client.name,
      fatherSurname: client.fatherSurname,
      motherSurname: client.motherSurname ?? "",
      userId: client.userId,
      createdAt: client.createdAt,
      uid: client.uid);
}

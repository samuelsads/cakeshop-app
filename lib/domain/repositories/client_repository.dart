import 'package:cakeshopapp/domain/entities/client.dart';
import 'package:cakeshopapp/domain/entities/cliente_details.dart';
import 'package:cakeshopapp/domain/entities/save.dart';

abstract class ClientRepository {
  Future<List<Client>> searchClient(String search);

  Future<List<Client>> getAll(int start, int limit);

  Future<Save> save(Map<String, dynamic> data);

  Future<List<ClientDetails>> clientDetails(String clientId);

  Future<Save> update(Map<String, dynamic> data);
}

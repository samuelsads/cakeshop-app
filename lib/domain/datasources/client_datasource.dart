import 'package:cakeshopapp/domain/entities/client.dart';
import 'package:cakeshopapp/domain/entities/save.dart';

abstract class ClientDataSource {
  Future<List<Client>> searchClient(String search);

  Future<List<Client>> getAll(int start, int limit);

  Future<Save> save(Map<String, dynamic> data);
}

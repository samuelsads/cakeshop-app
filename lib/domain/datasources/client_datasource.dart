import 'package:cakeshopapp/domain/entities/client.dart';

abstract class ClientDataSource {
  Future<List<Client>> searchClient(String search);
}

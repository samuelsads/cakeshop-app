import 'package:cakeshopapp/domain/entities/client.dart';

abstract class ClientRepository {
  Future<List<Client>> searchClient(String search);
}

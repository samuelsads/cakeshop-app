import 'package:cakeshopapp/domain/entities/save.dart';
import 'package:cakeshopapp/presentation/blocs/client_bloc/client_bloc.dart';

class ViewmodelClient {
  Future<Save> saveOrder(
      Map<String, dynamic> data, ClientBloc bloc, bool update) async {
    return await bloc.saveClient(data, update);
  }

  Future<void> getAllClients(int start, int limit, ClientBloc bloc) async {
    await bloc.allClient(start, limit);
  }
}

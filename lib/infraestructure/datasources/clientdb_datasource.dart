import 'package:cakeshopapp/config/constants/constans.dart';
import 'package:cakeshopapp/config/constants/security_token.dart';
import 'package:cakeshopapp/domain/datasources/client_datasource.dart';
import 'package:cakeshopapp/domain/entities/client.dart';
import 'package:cakeshopapp/infraestructure/mappers/client_mapper.dart';
import 'package:cakeshopapp/infraestructure/models/clientdb/clientdb_search_response.dart';
import 'package:dio/dio.dart';

class ClientdbDatasourceImpl extends ClientDataSource {
  final dio = Dio(BaseOptions(baseUrl: BASE_URL));

  @override
  Future<List<Client>> searchClient(String search) async {
    List<Client> searchList;
    String token = await SecurityToken.getToken();
    try {
      final response = await dio.get("/client/search?search=$search",
          options: Options(headers: {
            'x-token': token,
          }));

      final clientDbResponse = ClientdbSearchResponse.fromJson(response.data);

      searchList = clientDbResponse.data
          .map((e) => ClientMapper.clientDbEntity(e))
          .toList();
    } on DioException catch (e) {
      print(e);
      searchList = [];
    }

    return searchList;
  }
}

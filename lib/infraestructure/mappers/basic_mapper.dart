import 'package:cakeshopapp/domain/entities/save.dart';
import 'package:cakeshopapp/infraestructure/models/ordersdb/savedb_response.dart';

class BasicMapper {
  static Save saveDbEntity(SavedbResponse s) =>
      Save(success: s.success, msg: s.msg, id: s.id ?? "");
}

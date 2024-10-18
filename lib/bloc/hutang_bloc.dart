import 'dart:convert';
import '/helpers/api.dart';
import '/helpers/api_url.dart';
import '/model/Hutang.dart';

class HutangBloc {
  static Future<List<Hutang>> getHutangs() async {
    String apiUrl = ApiUrl.listHutang;
    var response = await Api().get(apiUrl);
    
    if (response.statusCode == 200) {
      var jsonObj = json.decode(response.body);
      List<dynamic> listHutang = (jsonObj as Map<String, dynamic>)['data'];
      return List<Hutang>.from(listHutang.map((item) => Hutang.fromJson(item)));
    } else {
      throw Exception('Failed to load hutang');
    }
  }

  static Future<String> addHutang({required Hutang hutang}) async {
    String apiUrl = ApiUrl.createHutang;
    var body = {
      "person": hutang.person,
      "status": hutang.status,
      "amount": hutang.amount.toString()
    };
    var response = await Api().post(apiUrl, body);
    
    if (response.statusCode == 200) {
      var jsonObj = json.decode(response.body);
      return jsonObj['status'];
    } else {
      throw Exception('Failed to add hutang');
    }
  }

  static Future<String> updateHutang({required Hutang hutang}) async {
    String apiUrl = ApiUrl.updateHutang(hutang.id!);
    var body = {
      "person": hutang.person,
      "status": hutang.status,
      "amount": hutang.amount.toString()
    };
    
    var response = await Api().put(apiUrl, body); // Use body directly
    
    if (response.statusCode == 200) {
      var jsonObj = json.decode(response.body);
      return jsonObj['status'];
    } else {
      throw Exception('Failed to update hutang');
    }
  }

  static Future<bool> deleteHutang({required int id}) async {
    String apiUrl = ApiUrl.deleteHutang(id);
    var response = await Api().delete(apiUrl);
    
    if (response.statusCode == 200) {
      var jsonObj = json.decode(response.body);
      return (jsonObj as Map<String, dynamic>)['data'];
    } else {
      throw Exception('Failed to delete hutang');
    }
  }
}

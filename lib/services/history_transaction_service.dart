import 'dart:convert';

import 'package:entity_delivery_v2/models/history_transaction_detail_model.dart';
import 'package:entity_delivery_v2/models/history_transaction_model.dart';
import 'package:http/http.dart' as http;

class HistoryTransactionService {
  String baseUrl = 'https://dev.ngecode.my.id';

  Future<List<HistoryTransactionModel>> getTransactions({required String token}) async {
    var url = Uri.parse('$baseUrl/api/v1/transactions-optional');
    var headers = {
      'Accept': 'application/json',
      'Authorization': token,
    };

    var response = await http.get(url, headers: headers);
    print(response.statusCode);
    print(response.body);
    
    if(response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      List<HistoryTransactionModel> transactions = [];
      for(var item in data) {
        transactions.add(HistoryTransactionModel.fromJson(item));
      }
      print('success get transactions');
      return transactions;
    } else {
      throw Exception('Gagal get transactions');
    }
  }

  Future<HistoryTransactionDetailModel> getDetailTransaction({required String id, required String token}) async {
    var url = Uri.parse('$baseUrl/api/v1/transactions/$id');
    var headers = {
      'Accept': 'application/json',
      'Authorization': token,
    };

    var response = await http.get(url, headers: headers);
    print(response.statusCode);
    print(response.body);

    if(response.statusCode == 200) {
      HistoryTransactionDetailModel historyTransactionDetailModel = jsonDecode(response.body)['data'];
      print('berhasil get detail');
      return historyTransactionDetailModel;
    } else {
      throw Exception('Fail get detail');
    }
  }
}
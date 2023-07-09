import 'package:entity_delivery_v2/models/cart_model.dart';
import 'package:entity_delivery_v2/models/history_transaction_detail_model.dart';
import 'package:entity_delivery_v2/models/history_transaction_model.dart';
import 'package:entity_delivery_v2/services/history_transaction_service.dart';
import 'package:flutter/material.dart';

class HistoryTransactionProvider with ChangeNotifier {
  List<HistoryTransactionModel> _transactions = [];
  HistoryTransactionDetailModel? _historyTransactionDetailModel;

  List<HistoryTransactionModel> get transactions => _transactions;

  set transactions(List<HistoryTransactionModel> value) {
    _transactions = value;
    notifyListeners();
  }


  HistoryTransactionDetailModel get historyTransactionDetailModel =>
      _historyTransactionDetailModel!;

  set historyTransactionDetailModel(HistoryTransactionDetailModel value) {
    _historyTransactionDetailModel = value;
    notifyListeners();
  }

  Future<bool> getTransactions({required String token}) async {
    try {
      List<HistoryTransactionModel> transactions = await HistoryTransactionService().getTransactions(token: token);
      _transactions = transactions;
      print('success get transaction provider');
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> getDetailTransaction({required String id, required String token}) async {
    try {
      HistoryTransactionDetailModel historyTransactionDetailModel = await HistoryTransactionService().getDetailTransaction(id: id, token: token);
      _historyTransactionDetailModel = historyTransactionDetailModel;
      print('succeed get detail');
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
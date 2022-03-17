import 'dart:convert';

import 'package:baitapbuoi6/resources/models/customer.dart';

class Statistic {
  late List<Customer> listCustomer;
  double? revenue;

  Statistic({required this.listCustomer, this.revenue});

  void setRevenue(newVal) {
    revenue = newVal;
  }

  void setListCustomer(List a) {
    a.forEach((e) {
      listCustomer.add(
          Customer(name: e['name'], quality: e['quality'], isVip: e['isVip']));
    });
  }

  int totalCustomer() {
    return listCustomer.length;
  }

  int totalCustomerVip() {
    if (listCustomer.isNotEmpty) {
      return listCustomer.where((e) => e.isVip == true).length;
    }
    return 0;
  }

  double totalRevenue() {
    double total = 0;
    if (listCustomer.isNotEmpty) {
      listCustomer.forEach((e) {
        total += e.getTotalMoney();
      });
    }
    return total;
  }

  void addCustomer({required Customer newCustomer}) {
    listCustomer.add(newCustomer);
  }

  Map<String, dynamic> toMap() =>
      {"revenue": revenue, "listCustomer": listCustomerCover()};

  List<Map<String, dynamic>> listCustomerCover() {
    List<Map<String, dynamic>> a = [];
    listCustomer.forEach((e) {
      a.add(e.toMap());
    });
    return a;
  }
}

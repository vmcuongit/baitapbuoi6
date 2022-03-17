import 'package:baitapbuoi6/resources/models/customer.dart';

double totalMoney({required int qty, bool? isVip}) {
  double total = qty * 20000;
  if (isVip == true) {
    return total = total - (total * 0.1);
  }
  return total;
}

import 'package:baitapbuoi6/resources/utils/common_functions.dart';

class Customer {
  String? name;
  int? quality;
  bool? isVip;

  Customer({this.name, this.quality, this.isVip});

  Map<String, dynamic> toMap() => {
        "name": name,
        "quality": quality,
        "isVip": isVip,
      };

  double getTotalMoney() {
    return totalMoney(qty: quality!, isVip: isVip);
  }
}

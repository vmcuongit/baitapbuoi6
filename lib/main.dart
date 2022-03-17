import 'dart:convert';

import 'package:baitapbuoi6/resources/app_colors.dart';
import 'package:baitapbuoi6/resources/models/customer.dart';
import 'package:baitapbuoi6/resources/models/statistic.dart';
import 'package:baitapbuoi6/resources/strings.dart';
import 'package:baitapbuoi6/resources/app_styles.dart';
import 'package:baitapbuoi6/resources/utils/common_functions.dart';
import 'package:baitapbuoi6/resources/widgets/label_input_widget.dart';
import 'package:baitapbuoi6/resources/widgets/text_input_widget.dart';
import 'package:baitapbuoi6/resources/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: CHUONG_TRINH_BAN_SACH,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  TextEditingController? nameCustomerController, qualityController;
  late FocusNode nameFocusNode;
  bool? isVip;
  int? totalCustomer, totalCustomerVip;
  double? finalRevenue, totalRevenue;

  late Statistic statistic;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameCustomerController = TextEditingController();
    qualityController = TextEditingController();
    nameFocusNode = FocusNode();

    statistic = Statistic(listCustomer: [], revenue: 0);

    isVip = false;
    totalRevenue = 0;

    loadStatistic();
    loadDataPrefs();
  }

  void loadStatistic() {
    totalCustomer = statistic.totalCustomer();
    totalCustomerVip = statistic.totalCustomerVip();
    finalRevenue = statistic.totalRevenue();
  }

  void saveStringShare({required String key, required String value}) async {
    SharedPreferences prefs = await _prefs;
    prefs.setString(key, value);
  }

  void loadDataPrefs() async {
    SharedPreferences prefs = await _prefs;
    String objRevenue = prefs.getString('objRevenue') ?? '';
    if (objRevenue.isNotEmpty) {
      var mapRevenue = jsonDecode(objRevenue);

      statistic.setListCustomer(mapRevenue['listCustomer']);
      statistic.setRevenue(mapRevenue['revenue']);

      setState(() {
        loadStatistic();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(CHUONG_TRINH_BAN_SACH),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TitleWidget(title: THONG_TIN_HOA_DON),
            Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: LabelInputWidget(name: TEN_KHACH_HANG)),
                      Expanded(
                          child: TextInputWidget(
                        controller: nameCustomerController,
                        focusNode: nameFocusNode,
                        isNumberType: false,
                      ))
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(child: LabelInputWidget(name: SO_LUONG_SACH)),
                      Expanded(
                        child: TextInputWidget(
                          controller: qualityController,
                          isNumberType: true,
                        ),
                      )
                    ],
                  ),
                  Row(children: [
                    Expanded(
                        child: const SizedBox(
                      width: 1,
                    )),
                    Expanded(
                      child: CheckboxListTile(
                          checkColor: Colors.white,
                          contentPadding: const EdgeInsets.only(
                              left: 0, right: 0, top: 15, bottom: 5),
                          title: const Text(
                            KHACH_HANG_VIP,
                            textAlign: TextAlign.left,
                          ),
                          controlAffinity: ListTileControlAffinity.leading,
                          value: isVip,
                          activeColor: Colors.red,
                          onChanged: (newValue) {
                            setState(() {
                              isVip = newValue;
                            });
                          }),
                    )
                  ]),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(child: LabelInputWidget(name: THANH_TIEN)),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          color: AppColors.labelSumBg,
                          alignment: Alignment.center,
                          child: Text("$totalRevenue",
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: AppColors.labelSumColor,
                                  fontWeight: FontWeight.bold)),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                        padding: const EdgeInsets.all(5),
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              totalRevenue = totalMoney(
                                  qty: int.parse(qualityController!.text),
                                  isVip: isVip);
                            });
                          },
                          child: Text(
                            TINH_TT,
                            style: textButtonMainStyle,
                          ),
                          style: buttonMainStyle,
                        ),
                      )),
                      Expanded(
                          child: Container(
                        padding: const EdgeInsets.all(5),
                        child: TextButton(
                          onPressed: () {
                            statistic.addCustomer(
                                newCustomer: Customer(
                                    name: nameCustomerController!.text,
                                    quality: int.parse(qualityController!.text),
                                    isVip: isVip));
                            nameCustomerController!.clear();
                            nameFocusNode.requestFocus();
                            qualityController!.clear();

                            setState(() {
                              totalRevenue = 0;
                              isVip = false;
                              loadStatistic();
                              statistic.setRevenue(finalRevenue);
                            });

                            try {
                              saveStringShare(
                                  key: 'objRevenue',
                                  value: jsonEncode(statistic.toMap()));
                            } catch (e) {
                              print(e);
                            }
                          },
                          child: Text(
                            TIEP,
                            style: textButtonMainStyle,
                          ),
                          style: buttonMainStyle,
                        ),
                      )),
                      Expanded(
                          child: Container(
                        padding: const EdgeInsets.all(5),
                        child: TextButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                      title: Text(TONG_DOANH_THU.toUpperCase()),
                                      content: Text("$finalRevenue"),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            "OK",
                                            style: textButtonMainStyle,
                                          ),
                                          style: buttonMainStyle,
                                        )
                                      ],
                                    ));
                          },
                          child: Text(
                            THONG_KE,
                            style: textButtonMainStyle,
                          ),
                          style: buttonMainStyle,
                        ),
                      ))
                    ],
                  )
                ],
              ),
            ),
            TitleWidget(title: THONG_TIN_THONG_KE),
            Container(
              padding: const EdgeInsets.only(
                  top: 20, bottom: 20, left: 10, right: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: LabelInputWidget(name: TONG_SO_KHACH_HANG)),
                      Expanded(child: Text("$totalCustomer"))
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: LabelInputWidget(
                              name: TONG_SO_KHACH_HANG_LA_VIP)),
                      Expanded(child: Text("$totalCustomerVip"))
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(child: LabelInputWidget(name: TONG_DOANH_THU)),
                      Expanded(child: Text("$finalRevenue"))
                    ],
                  )
                ],
              ),
            ),
            TitleWidget(title: ''),
            Container(
              alignment: Alignment.topRight,
              child: IconButton(
                  onPressed: () => showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                            title: Text(THONG_BAO),
                            content: Text(BAN_CO_CHAC_MUON_THOAT),
                            actions: [
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    THOAT,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  style: buttonDefaultStyle),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop(true);
                                },
                                child: Text(
                                  DONG_Y,
                                  style: textButtonMainStyle,
                                ),
                                style: buttonMainStyle,
                              )
                            ],
                          )),
                  icon: Icon(Icons.exit_to_app_outlined)),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameCustomerController?.dispose();
    qualityController?.dispose();
  }
}

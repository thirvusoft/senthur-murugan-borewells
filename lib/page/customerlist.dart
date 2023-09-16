import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:senthur_murugan/controller/api.dart';
import 'package:senthur_murugan/widgets/appbar.dart';
import 'package:senthur_murugan/widgets/textformfield.dart';

class Cusomerlist extends StatefulWidget {
  const Cusomerlist({super.key});

  @override
  State<Cusomerlist> createState() => _CusomerlistState();
}

class _CusomerlistState extends State<Cusomerlist> {
  final Customer customer = Get.put(Customer());
  var sort = "";
  final TextEditingController searchcontroller = TextEditingController();
  @override
  void initState() {
    super.initState();
    customer.customerlist_();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ReusableAppBar(
        title: 'Customer List',
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: 50,
              child: ReusableTextField(
                labelText: 'Search',
                controller: searchcontroller,
                obscureText: false,
                suffixIcon: HeroIcons.magnifyingGlass,
                onChange: ((value) {
                  setState(() {
                    sort = value;
                  });
                  customer.customerfliter(sort);
                }),
                readyonly: false,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 1.48,
              child: Obx(
                () {
                  if (customer.customerlistisLoading.value) {
                    return const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(child: CircularProgressIndicator()),
                      ],
                    );
                  } else {
                    return ListView.builder(
                        itemCount: (sort.isEmpty)
                            ? customer.customerlist.length
                            : customer.customerfliterlist.length,
                        itemBuilder: (BuildContext context, int index) {
                          final user = (sort.isEmpty)
                              ? customer.customerlist[index]
                              : customer.customerfliterlist[index];
                          print("[]][]][][]][][]][][]");
                          return Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromRGBO(230, 233, 230, 1),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                  ),
                                ],
                              ),
                              child: ListTile(
                                  leading: Text((index + 1).toString()),
                                  title: Text(user['customer_name']),
                                  trailing: const HeroIcon(
                                    HeroIcons.pencilSquare,
                                    color: Color(0xFF752FFF),
                                  ),
                                  subtitle: Text(user['mobile_no'])),
                            ),
                          );
                        });
                  }
                },
              ),
            ),
            SizedBox(
              height: 60,
              child: Stack(
                children: [
                  Positioned(
                    bottom: 0.0,
                    right: 16.0,
                    child: FloatingActionButton(
                      backgroundColor: Colors.white,
                      onPressed: () {
                        Get.toNamed("Customercreation");
                      },
                      child: const Icon(Icons.add),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

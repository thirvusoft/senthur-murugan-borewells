import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:senthur_murugan/controller/api.dart';
import 'package:senthur_murugan/widgets/appbar.dart';

class Employee extends StatefulWidget {
  const Employee({super.key});

  @override
  State<Employee> createState() => _EmployeeState();
}

class _EmployeeState extends State<Employee> {
  @override
  final Customer api = Customer();
  void initState() {
    super.initState();
    api.employeelist_();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableAppBar(
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back, color: Color(0xFF752FFF)),
        //   onPressed: () {},
        // ),
        title: 'Employee creation',
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.search),
        //     onPressed: () {
        //       // Add your search functionality here
        //     },
        //   ),
        //   IconButton(
        //     icon: Icon(Icons.settings),
        //     onPressed: () {
        //       // Add your settings functionality here
        //     },
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Obx(
                () => ListView.builder(
                    itemCount: api.employeelist.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                          leading: Text(index.toString()),
                          trailing: const Text(
                            "GFG",
                            style: TextStyle(color: Colors.green, fontSize: 15),
                          ),
                          subtitle: Text(api.employeelist[index]['name']),
                          title: Text(api.employeelist[index]['first_name']));
                    }),
              )),
        ],
      )),
    );
  }
}

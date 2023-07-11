import 'package:bill_reminder_app/providers/bill_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BillCreation extends StatefulWidget {
  const BillCreation({super.key});

  @override
  State<BillCreation> createState() => _BillCreationState();
}

class _BillCreationState extends State<BillCreation> {
  @override
  Widget build(BuildContext context) {
    return Consumer<BillProvider>(builder: ((context, value, child) {
      return ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 25,
                            backgroundImage: AssetImage('assets/dollar.png'),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              value.bills[index].billName,
                              style: const TextStyle(
                                  color: Colors.blue, fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text("\u2023"),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  '  ${value.bills[index].description}',
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Text("\u2023"),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  '${value.bills[index].billAmount} Ksh',
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              // const Text("\u2023"),
                              // const SizedBox(
                              //   width: 10,
                              // ),
                              Expanded(
                                child: Text(
                                  'Created on: ${DateFormat.yMMMMEEEEd().format(value.bills[index].createdAt ?? DateTime.now())} '
                                  'at'
                                  ' '
                                  '${DateFormat.Hm().format(value.bills[index].createdAt ?? DateTime.now())}  '
                                  'HRS',
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )

              // Card(
              //   elevation: 2,
              //   child: Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: ListTile(
              //       leading: const CircleAvatar(
              //         backgroundImage: AssetImage('assets/dollar.png'),
              //       ),
              //       title: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text('Bill Name:  ${value.bills[index].billName}'),
              //           Text('Bill Desc:   ${value.bills[index].description}'),
              //           Text(
              //               'Bill Amount:  ${value.bills[index].billAmount} Ksh'),
              //           Text(
              //               'Created on: ${DateFormat.yMMMMEEEEd().format(value.bills[index].createdAt ?? DateTime.now())} '
              //               'at'
              //               ' '
              //               '${DateFormat.Hm().format(value.bills[index].createdAt ?? DateTime.now())}  '
              //               'HRS')
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              );
        },
        itemCount: value.bills.length,
      );
    }));
  }
}

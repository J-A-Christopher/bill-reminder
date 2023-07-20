import 'package:bill_reminder_app/providers/bill_provider.dart';
import 'package:bill_reminder_app/screens/edit_bills_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BillCreation extends StatefulWidget {
  const BillCreation({super.key});

  @override
  State<BillCreation> createState() => _BillCreationState();
}

class _BillCreationState extends State<BillCreation> {
  Future<void> _refreshBills() async {
    await Provider.of<BillProvider>(context, listen: false).fetchAndSetBills();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshBills,
      child: FutureBuilder(
          future: Provider.of<BillProvider>(
            context,
            listen: false,
          ).fetchAndSetBills(),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Consumer<BillProvider>(builder: ((context, value, child) {
              return value.bills.isEmpty
                  ? const Center(
                      child: Text(
                          'Nothing to display. Press the plus button to create a bill'),
                    )
                  : Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                              'Below is a list of bills you created. Tap on them to edit various fields when you need to.'),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0, top: 8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return EditBillsScreen(
                                        duDate: value.bills[index].dueDate ??
                                            DateTime.now(),
                                        billTitle: value.bills[index].billName,
                                        billDesc:
                                            value.bills[index].description,
                                        billAmount:
                                            value.bills[index].billAmount,
                                        id: value.bills[index].id ?? '',
                                      );
                                    }));
                                  },
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              const CircleAvatar(
                                                radius: 25,
                                                backgroundImage: AssetImage(
                                                    'assets/dollar.png'),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  value.bills[index].billName,
                                                  style: const TextStyle(
                                                      color: Colors.blue,
                                                      fontSize: 20),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                                                      style: const TextStyle(
                                                          fontSize: 15),
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
                                                      style: const TextStyle(
                                                          fontSize: 15),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      'Created on: ${DateFormat.yMMMMEEEEd().format(value.bills[index].createdAt ?? DateTime.now())} '
                                                      'at'
                                                      ' '
                                                      '${DateFormat.Hm().format(value.bills[index].createdAt ?? DateTime.now())}  '
                                                      'HRS',
                                                      style: const TextStyle(
                                                          fontSize: 15),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: value.bills.length,
                          ),
                        ),
                      ],
                    );
            }));
          })),
    );
  }
}

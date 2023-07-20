import 'package:bill_reminder_app/providers/bill_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../Data/models/bill_model.dart';

class EditBillsScreen extends StatefulWidget {
  final String id;
  final String billTitle;
  final double billAmount;
  final DateTime duDate;
  final String billDesc;
  const EditBillsScreen(
      {super.key,
      required this.id,
      required this.billTitle,
      required this.billAmount,
      required this.duDate,
      required this.billDesc});

  @override
  State<EditBillsScreen> createState() => _EditBillsScreenState();
}

class _EditBillsScreenState extends State<EditBillsScreen> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController billTitle =
      TextEditingController.fromValue(TextEditingValue(text: widget.billTitle));
  late TextEditingController billAmount = TextEditingController.fromValue(
      TextEditingValue(text: widget.billAmount.toString()));
  late TextEditingController duDate = TextEditingController.fromValue(
      TextEditingValue(text: DateFormat.yMMMMEEEEd().format(widget.duDate)));
  late TextEditingController billDescription =
      TextEditingController.fromValue(TextEditingValue(text: widget.billDesc));

  var _edittedBill = BillModel(
      id: null,
      billName: '',
      createdAt: DateTime.now(),
      description: '',
      dueDate: null,
      billAmount: 0);

  void _pickDate() async {
    await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2023),
            lastDate: DateTime(2100))
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      duDate.text = DateFormat.yMMMMEEEEd().format(pickedDate);
    });
  }

  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    _edittedBill = BillModel(
      id: widget.id,
      billName: widget.billTitle,
      billAmount: widget.billAmount,
      createdAt: widget.duDate,
      description: widget.billDesc,
      dueDate: widget.duDate,
    );
  }

  void _submitUpdatedForm() async {
    setState(() {
      _isLoading = true;
    });

    try {
      formKey.currentState!.save();
      await Provider.of<BillProvider>(context, listen: false)
          .updateProduct(widget.id, _edittedBill);
      setState(() {
        _isLoading = false;
      });

      Navigator.of(context).pop();
    } catch (error) {
      await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('An error occured'),
              content: const Text('Ensure that you are online...'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Ok'))
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    var billData = Provider.of<BillProvider>(
      context,
    ).bills;
    var filteredBill = billData.where((bill) => bill.id == widget.id).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome.. Please Edit Your Bills'),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Bill Title'),
                          const SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            onSaved: (value) {
                              _edittedBill = BillModel(
                                  id: _edittedBill.id,
                                  billName: value ?? '',
                                  billAmount: _edittedBill.billAmount,
                                  createdAt: _edittedBill.createdAt,
                                  description: _edittedBill.description,
                                  dueDate: _edittedBill.dueDate);
                            },
                            controller: billTitle,
                            decoration: const InputDecoration(
                                filled: true,
                                fillColor: Color(0xffe8e9ec),
                                contentPadding: EdgeInsets.all(5),
                                border: OutlineInputBorder(),
                                hintText: 'Bill Title'),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text('Bill Amount'),
                          const SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            onSaved: (value) {
                              _edittedBill = BillModel(
                                  id: _edittedBill.id,
                                  billName: _edittedBill.billName,
                                  billAmount: double.parse(value!),
                                  createdAt: _edittedBill.createdAt,
                                  description: _edittedBill.description,
                                  dueDate: _edittedBill.dueDate);
                            },
                            controller: billAmount,
                            decoration: const InputDecoration(
                                filled: true,
                                fillColor: Color(0xffe8e9ec),
                                contentPadding: EdgeInsets.all(5),
                                border: OutlineInputBorder(),
                                hintText: 'Bill Amount'),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text('Due Date'),
                          const SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            onSaved: (value) {
                              DateTime now =
                                  DateFormat.yMMMMEEEEd().parse(duDate.text);
                              _edittedBill = BillModel(
                                  id: _edittedBill.id,
                                  billName: _edittedBill.billName,
                                  billAmount: _edittedBill.billAmount,
                                  createdAt: _edittedBill.dueDate,
                                  description: _edittedBill.description,
                                  dueDate: now);
                            },
                            readOnly: true,
                            onTap: _pickDate,
                            controller: duDate,
                            decoration: const InputDecoration(
                                filled: true,
                                fillColor: Color(0xffe8e9ec),
                                contentPadding: EdgeInsets.all(5),
                                icon: Icon(Icons.calendar_today),
                                border: OutlineInputBorder(),
                                hintText: 'Add Due Date'),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text('Bill Description'),
                          const SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            onSaved: (value) {
                              _edittedBill = BillModel(
                                  id: _edittedBill.id,
                                  billName: _edittedBill.billName,
                                  billAmount: _edittedBill.billAmount,
                                  createdAt: _edittedBill.createdAt,
                                  description: value!,
                                  dueDate: _edittedBill.dueDate);
                            },
                            controller: billDescription,
                            maxLines: 4,
                            decoration: const InputDecoration(
                                filled: true,
                                fillColor: Color(0xffe8e9ec),
                                contentPadding: EdgeInsets.all(5),
                                border: OutlineInputBorder(),
                                hintText: 'Bill Description'),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              ElevatedButton(
                                  onPressed: _submitUpdatedForm,
                                  child: const Text('Update..'))
                            ],
                          )
                        ],
                      ),
                    ));
              },
              itemCount: filteredBill.length,
            ),
    );
  }
}

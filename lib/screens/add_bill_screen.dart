import 'package:bill_reminder_app/Data/models/bill_model.dart';
import 'package:bill_reminder_app/providers/bill_provider.dart';
import 'package:bill_reminder_app/widgets/bills_formation_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddBill extends StatefulWidget {
  const AddBill({super.key});

  @override
  State<AddBill> createState() => _AddBillState();
}

class _AddBillState extends State<AddBill> {
  @override
  void initState() {
    super.initState();
    context.read<BillProvider>().fetchAndSetBills();
  }

  final _formKey = GlobalKey<FormState>();
  var _isLoading = false;
  var _edittedBill = BillModel(
      id: null,
      billName: '',
      createdAt: DateTime.now(),
      description: '',
      dueDate: null,
      billTitle: '',
      billAmount: 0);
  var dateController = TextEditingController();
  DateTime? date;

  Future<void> _submitForm() async {
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<BillProvider>(context, listen: false)
          .addBill(_edittedBill);
    } catch (error) {
      await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('An Error Occured'),
              content: const Text('Something went wrong.. Are you online?'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'))
              ],
            );
          });
    } finally {
      dateController.text = '';
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
    }
  }

  void _selectedDate() async {
    await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2023),
            lastDate: DateTime(2100))
        .then((datePicked) {
      if (datePicked == null) {
        return;
      }
      dateController.text = DateFormat('yyyy-MM-dd').format(datePicked);
      date = datePicked;

      // print('Leo${date!.toIso8601String()}');
    });
  }

  @override
  Widget build(BuildContext context) {
    final billData = Provider.of<BillProvider>(context).bills;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              context: context,
              builder: (context) {
                return Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: SizedBox(
                    height: 470,
                    child: Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15.0, right: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Please Add Bill..',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text('Bill Title'),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                onSaved: (value) {
                                  _edittedBill = BillModel(
                                      id: null,
                                      billName: value!,
                                      billAmount: _edittedBill.billAmount,
                                      createdAt: DateTime.now(),
                                      description: _edittedBill.description,
                                      dueDate: _edittedBill.dueDate,
                                      billTitle: _edittedBill.billTitle);
                                },
                                decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Color(0xffe8e9ec),
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.all(5),
                                    hintText: 'Bill Title'),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text('Bill Amount'),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                onSaved: (value) {
                                  _edittedBill = BillModel(
                                      id: null,
                                      billName: _edittedBill.billName,
                                      billAmount: double.parse(value!),
                                      createdAt: DateTime.now(),
                                      description: _edittedBill.description,
                                      dueDate: _edittedBill.dueDate,
                                      billTitle: _edittedBill.billTitle);
                                },
                                decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Color(0xffe8e9ec),
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.all(5),
                                    hintText: 'Bill Amount'),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text('Due Date For Bill'),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                controller: dateController,
                                onTap: () {
                                  _selectedDate();
                                },
                                onSaved: (date) {
                                  DateTime now =
                                      DateTime.parse(dateController.text);

                                  _edittedBill = BillModel(
                                      id: null,
                                      billName: _edittedBill.billName,
                                      billAmount: _edittedBill.billAmount,
                                      createdAt: null,
                                      description: '',
                                      dueDate: now,
                                      billTitle: '');
                                },
                                decoration: const InputDecoration(
                                    icon: Icon(Icons.calendar_today),
                                    filled: true,
                                    fillColor: Color(0xffe8e9ec),
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.all(5),
                                    hintText: 'Add Due Date'),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text('Bill Description'),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                onSaved: (value) {
                                  _edittedBill = BillModel(
                                      id: null,
                                      billName: _edittedBill.billName,
                                      billAmount: _edittedBill.billAmount,
                                      createdAt: DateTime.now(),
                                      description: value!,
                                      dueDate: _edittedBill.dueDate,
                                      billTitle: _edittedBill.billTitle);
                                },
                                maxLines: 4,
                                decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Color(0xffe8e9ec),
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.all(5),
                                    hintText: 'Bill Description'),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 150,
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                      child: const Text('Cancel'),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 150,
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: _submitForm,
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                      child: const Text('Create Bill'),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        )),
                  ),
                );
              });
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('Hey Jesse'),
      ),
      body: billData.isEmpty
          ? const Center(
              child: Text(
                  'Nothing to display. Press the plus button to create a bill'),
            )
          : const BillCreation(),
    );
  }
}

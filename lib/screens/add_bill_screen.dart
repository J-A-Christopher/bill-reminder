import 'package:flutter/material.dart';

class AddBill extends StatelessWidget {
  const AddBill({super.key});

  @override
  Widget build(BuildContext context) {
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
                    height: 400,
                    child: Form(
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
                            decoration: const InputDecoration(
                                filled: true,
                                fillColor: Color(0xffe8e9ec),
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.all(5),
                                hintText: 'Add Bill Name..'),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text('Due Date For Bill'),
                          const SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  onPressed: () {},
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
    );
  }
}

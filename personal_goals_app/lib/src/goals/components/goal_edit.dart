import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_goals_app/src/provider/goal_provider.dart';
import '../models/goal_model.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class GoalEditPage extends ConsumerStatefulWidget {
  final Goal goal;

  const GoalEditPage({Key? key, required this.goal}) : super(key: key);

  @override
  ConsumerState<GoalEditPage> createState() => _GoalEditFormPageState();
}

class _GoalEditFormPageState extends ConsumerState<GoalEditPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  DateTime? _startDate;
  DateTime? _endDate;
  @override
  void initState() {
    super.initState();
    _nameController.text = widget.goal.name;
    _descriptionController.text = widget.goal.description;
    _startDate = widget.goal.startDate;
    _endDate = widget.goal.endDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Edit Target')),
        body: Form(
            key: _formKey,
            child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Goal Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a goal name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(labelText: 'Description'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                  ),
                  ListTile(
                    title: Text(
                        'Start Date: ${_startDate != null ? DateFormat('yyyy-MM-dd').format(_startDate!) : 'Select'}'),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null && picked != _startDate) {
                        setState(() {
                          _startDate = picked;
                        });
                      }
                    },
                  ),
                  ListTile(
                    title: Text(
                        'End Date: ${_endDate != null ? DateFormat('yyyy-MM-dd').format(_endDate!) : 'Select'}'),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null && picked != _endDate) {
                        setState(() {
                          _endDate = picked;
                        });
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Goal updatedGoal = Goal(
                          id: widget.goal.id,
                          name: _nameController.text,
                          description: _descriptionController.text,
                          startDate: _startDate!,
                          endDate: _endDate,
                          category: widget.goal.category,
                          status: widget.goal.status,
                        );

                        ref
                            .read(goalProvider.notifier)
                            .updateGoal(widget.goal.id, updatedGoal);

                        Navigator.pop(context);
                      }
                    },
                    child: const Text("Edit your goal"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  IconButton(
                    color: Theme.of(context).hintColor,
                    icon: Icon(
                      Icons.delete,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Confirm Deletion"),
                            content: const Text(
                                "Are you sure you want to delete this goal?"),
                            actions: <Widget>[
                              TextButton(
                                child: const Text("Cancel"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: const Text("Delete"),
                                onPressed: () {
                                  // Delete the goal
                                  ref
                                      .read(goalProvider.notifier)
                                      .deleteGoal(widget.goal.id);
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  )
                ]))));
  }
}

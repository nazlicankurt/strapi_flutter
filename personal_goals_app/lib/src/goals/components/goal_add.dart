import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:personal_goals_app/src/provider/goal_provider.dart';
import '../models/goal_model.dart';

class GoalFormPage extends ConsumerStatefulWidget {
  const GoalFormPage({Key? key}) : super(key: key);

  @override
  GoalFormPageState createState() => GoalFormPageState();
}

class GoalFormPageState extends ConsumerState<GoalFormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  DateTime? _startDate;
  DateTime? _endDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Add Target')),
        body: Consumer(
          builder: (context, watch, child) {
            ref.watch(goalProvider.notifier);
            return Form(
                key: _formKey,
                child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(children: [
                      TextFormField(
                        controller: _nameController,
                        decoration:
                            const InputDecoration(labelText: 'Goal Name'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a goal name';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _descriptionController,
                        decoration:
                            const InputDecoration(labelText: 'Description'),
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
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2050),
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
                        onPressed: _saveGoal,
                        child: const Text("Save your goal"),
                      )
                    ])));
          },
        ));
  }

  void _saveGoal() {
    if (_formKey.currentState!.validate()) {
      final newGoal = Goal(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text,
        description: _descriptionController.text,
        startDate: _startDate ?? DateTime.now(),
        endDate: _endDate,
        category: GoalCategory.vacation,
        status: GoalStatus.active,
      );

      ref.read(goalProvider.notifier).addGoal(newGoal);
      Navigator.pop(context, true);
    }
  }
}

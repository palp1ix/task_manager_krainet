import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:task_manager_krainet/core/constants/constants.dart';
import 'package:task_manager_krainet/presentation/screens/add_task/bloc/add_task_bloc.dart';
import 'package:task_manager_krainet/shared/theme/colors.dart';
import 'package:task_manager_krainet/shared/widgets/decorated_button.dart';
import 'package:task_manager_krainet/shared/widgets/decorated_dialog.dart';
import 'package:task_manager_krainet/shared/widgets/decorated_text_form_field.dart';
import 'package:task_manager_krainet/shared/widgets/tap_outside_to_unfocus.dart';

@RoutePage()
class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key, required this.categoryName});

  final String categoryName;

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  late AddTaskBloc addTaskBloc;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    addTaskBloc = context.read<AddTaskBloc>();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return BlocListener<AddTaskBloc, AddTaskState>(
      listener: (context, state) {
        if (state is AddTaskInProgress) {
          showProgressIndicatorDialog(context);
        } else if (state is AddTaskFailed) {
          // Close progress dialog
          Navigator.of(context).pop();

          // Show message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.error,
              content: Text(localization.errorMessage),
            ),
          );
        } else if (state is AddTaskSuccess) {
          // Return to tasks page
          context.router.back();
          // Show message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.success,
              content: Text(localization.taskCreated),
            ),
          );
        }
      },
      child: TapOutsideToUnfocus(
        child: Scaffold(
          appBar: AppBar(
            title: Text(localization.addNewTask),
            surfaceTintColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              // For keyboard adaptivity
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Title input
                    DecoratedTextFormField(
                        controller: _titleController,
                        labelText: localization.title),
                    const SizedBox(height: 16),

                    // Description input
                    DecoratedTextFormField(
                      controller: _descriptionController,
                      labelText: localization.description,
                      maxLines: 3,
                    ),
                    const SizedBox(height: 16),

                    // Date Input
                    InkWell(
                      onTap: () => _selectDate(context),
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: localization.dueDate,
                          border: OutlineInputBorder().copyWith(
                              borderRadius: BorderRadius.circular(
                                  AppConstants.inputBorderRadius)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              DateFormat('MM dd').format(_selectedDate),
                            ),
                            const Icon(Icons.calendar_today),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    //Submit button
                    DecoratedButton(
                      onPressed: () {
                        _submitForm();
                      },
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        localization.createTask,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: theme.colorScheme.surface),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Function for select date
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(AppConstants.lastYearRange),
    );

    // Also validating
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // Final after validating we submit form and push event to bloc
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      addTaskBloc.add(CreateTask(
          title: _titleController.text,
          description: _descriptionController.text,
          category: widget.categoryName,
          date: _selectedDate,
          isCompleted: false));
    }
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:task_manager_krainet/core/constants/constants.dart';
import 'package:task_manager_krainet/presentation/screens/add_task/bloc/add_task_bloc.dart';
import 'package:task_manager_krainet/presentation/screens/add_task/widgets/date_time_picker.dart';
import 'package:task_manager_krainet/presentation/screens/add_task/widgets/submit_button.dart';
import 'package:task_manager_krainet/presentation/screens/add_task/widgets/task_form_fields.dart';
import 'package:task_manager_krainet/presentation/screens/add_task/widgets/task_status_listener.dart';
import 'package:task_manager_krainet/shared/widgets/tap_outside_to_unfocus.dart';

/// The main screen for adding a new task
/// Uses a form with various input fields for task details
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
  TimeOfDay _selectedTime = TimeOfDay.now();

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

    return TaskStatusListener(
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
                    // Title and description input fields
                    TaskFormFields(
                      titleController: _titleController,
                      descriptionController: _descriptionController,
                    ),
                    const SizedBox(height: 16),

                    // Date Input
                    DatePickerField(
                      selectedDate: _selectedDate,
                      onTap: _selectDate,
                    ),
                    const SizedBox(height: 16),

                    // Time Input
                    TimePickerField(
                      selectedTime: _selectedTime,
                      onTap: _selectTime,
                    ),
                    const SizedBox(height: 24),

                    // Submit button
                    SubmitButton(
                      onPressed: _submitForm,
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

  /// Opens a date picker dialog and updates the selected date
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(AppConstants.lastYearRange),
    );

    // Update state if a new valid date was selected
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  /// Opens a time picker dialog and updates the selected time
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: _selectedTime);

    // Update state if a new valid time was selected
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  /// Validates the form and submits task data to the bloc
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Combine date and time into a single DateTime object
      final DateTime combinedDateTime = DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        _selectedTime.hour,
        _selectedTime.minute,
      );

      addTaskBloc.add(CreateTask(
        title: _titleController.text,
        description: _descriptionController.text,
        category: widget.categoryName,
        date: combinedDateTime,
        isCompleted: false,
      ));
    }
  }
}

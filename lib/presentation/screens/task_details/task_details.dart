import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_krainet/core/constants/constants.dart';
import 'package:task_manager_krainet/domain/entities/task.dart';
import 'package:task_manager_krainet/presentation/screens/task_details/bloc/task_details_bloc.dart';
import 'package:task_manager_krainet/shared/theme/colors.dart';
import 'package:task_manager_krainet/shared/widgets/date_time_picker.dart';
import 'package:task_manager_krainet/shared/widgets/decorated_button.dart';
import 'package:task_manager_krainet/shared/widgets/decorated_dialog.dart';
import 'package:task_manager_krainet/shared/widgets/decorated_text_form_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:task_manager_krainet/shared/widgets/showDeleteTaskDialog.dart';
import 'package:task_manager_krainet/shared/widgets/tap_outside_to_unfocus.dart';

@RoutePage()
class TaskDetailsScreen extends StatefulWidget {
  const TaskDetailsScreen({super.key, required this.task});

  final Task task;

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  late TaskDetailsBloc _taskDetailsBloc;
  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    initLateFields();
    super.initState();
  }

  void initLateFields() {
    final dateTime = widget.task.date;
    _titleController = TextEditingController(text: widget.task.title);
    _descriptionController =
        TextEditingController(text: widget.task.description);
    _selectedDate = dateTime;
    _selectedTime = TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    _taskDetailsBloc = context.read<TaskDetailsBloc>();

    return BlocListener(
      bloc: _taskDetailsBloc,
      listener: (context, state) {
        if (state is TaskDetailsSuccess) {
          // Close progressIndicator
          Navigator.of(context).pop();

          context.router.back();
        } else if (state is TaskDetailsError) {
          // Close progressIndicator
          Navigator.of(context).pop();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.error,
              content: Text(localization.errorMessage),
            ),
          );
        } else {
          showProgressIndicatorDialog(context);
        }
      },
      child: TapOutsideToUnfocus(
        child: Scaffold(
          appBar: AppBar(
            surfaceTintColor: Colors.transparent,
            backgroundColor: Colors.transparent,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: AppConstants.topInset),
                  DecoratedTextFormField(
                    controller: _titleController,
                    labelText: localization.title,
                    hintText: localization.title,
                  ),
                  FieldsSpacer(),
                  DecoratedTextFormField(
                    hintText: localization.description,
                    labelText: localization.description,
                    controller: _descriptionController,
                    maxLines: 5,
                  ),
                  FieldsSpacer(),
                  DatePickerField(
                    selectedDate: _selectedDate,
                    onTap: _selectDate,
                  ),
                  FieldsSpacer(),
                  TimePickerField(
                    selectedTime: _selectedTime,
                    onTap: _selectTime,
                  ),
                  FieldsSpacer(),
                  DecoratedButton(
                      height: 50,
                      onPressed: () {
                        showDeleteTaskDialog(
                          context: context,
                          onDelete: () {
                            _taskDetailsBloc.add(
                              DeleteTaskEvent(widget.task),
                            );
                          },
                        );
                      },
                      color: AppColors.error,
                      child: Text(localization.deleteTask,
                          style: theme.textTheme.bodyLarge
                              ?.copyWith(color: AppColors.whiteBackground))),
                  SizedBox(height: 10),
                  DecoratedButton(
                      height: 50,
                      onPressed: _onTaskUpdate,
                      child: Text(localization.saveChanges,
                          style: theme.textTheme.bodyLarge
                              ?.copyWith(color: AppColors.whiteBackground))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTaskUpdate() {
    _taskDetailsBloc.add(
      UpdateTaskEvent(
        Task(
          id: widget.task.id,
          title: _titleController.text,
          description: _descriptionController.text,
          category: widget.task.category,
          isCompleted: widget.task.isCompleted,
          date: DateTime(
            _selectedDate.year,
            _selectedDate.month,
            _selectedDate.day,
            _selectedTime.hour,
            _selectedTime.minute,
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
}

class FieldsSpacer extends StatelessWidget {
  const FieldsSpacer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 30);
  }
}

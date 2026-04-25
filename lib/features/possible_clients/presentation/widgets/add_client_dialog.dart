import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saidco/core/validators/validators.dart';
import 'package:saidco/features/possible_clients/domain/entities/possible_clients.dart';
import 'package:saidco/features/possible_clients/presentation/cubit/possible_clients_cubit.dart';
import 'package:saidco/features/possible_clients/presentation/widgets/custom_dropdown_menu.dart';
import 'package:saidco/features/possible_clients/presentation/widgets/custom_text_field.dart';
import 'package:saidco/features/possible_clients/presentation/widgets/date_picker.dart';
import 'package:saidco/ui/common/custom_button.dart';
import 'package:saidco/core/utils/custom_toast.dart';

class AddUpdateClientDialog extends StatefulWidget {
  const AddUpdateClientDialog({
    super.key,
    this.id,
    this.name,
    this.phoneNumber,
    this.programLevel,
    this.expectedCost,
    this.travelDate,
    this.dayCount,
    this.roomType,
    this.hotelPreferences,
    this.flightPreferences,
    this.additionalInfo,
    this.updateMode = false,
  });

  final bool? updateMode;
  final String? id;
  final String? name;
  final String? phoneNumber;
  final String? programLevel;
  final String? expectedCost;
  final String? travelDate;
  final String? dayCount;
  final String? roomType;
  final String? hotelPreferences;
  final String? flightPreferences;
  final String? additionalInfo;

  @override
  State<AddUpdateClientDialog> createState() => _AddUpdateClientDialogState();
}

class _AddUpdateClientDialogState extends State<AddUpdateClientDialog> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController programLevelController = TextEditingController();
  TextEditingController dayCountController = TextEditingController();
  TextEditingController roomTypeController = TextEditingController();
  TextEditingController expectedCostController = TextEditingController();
  TextEditingController hotelPreferencesController = TextEditingController();
  TextEditingController flightPreferencesController = TextEditingController();
  TextEditingController additionalInfoController = TextEditingController();

  DateTime myTravelDateVariable = DateTime.now();

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  String? programLevelError;
  String? dayCountError;
  String? roomTypeError;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    phoneController = TextEditingController(text: widget.phoneNumber);
    expectedCostController = TextEditingController(text: widget.expectedCost);
    hotelPreferencesController = TextEditingController(
      text: widget.hotelPreferences,
    );
    flightPreferencesController = TextEditingController(
      text: widget.flightPreferences,
    );
    additionalInfoController = TextEditingController(
      text: widget.additionalInfo,
    );
    programLevelController = TextEditingController(text: widget.programLevel);
    dayCountController = TextEditingController(text: widget.dayCount);
    roomTypeController = TextEditingController(text: widget.roomType);
    if (widget.travelDate != null && widget.travelDate!.isNotEmpty) {
      myTravelDateVariable =
          DateTime.tryParse(widget.travelDate!) ?? DateTime.now();
    }
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    phoneController.dispose();
    expectedCostController.dispose();
    hotelPreferencesController.dispose();
    flightPreferencesController.dispose();
    additionalInfoController.dispose();
    programLevelController.dispose();
    dayCountController.dispose();
    roomTypeController.dispose();
  }

  Future<void> onSave() async {
    bool isNotValid = !formKey.currentState!.validate();

    if (programLevelController.text.trim().isEmpty) {
      programLevelError = 'يرجى اختيار نوع المستوى';
    } else {
      programLevelError = null;
    }

    if (dayCountController.text.trim().isEmpty) {
      dayCountError = 'يرجى اختيار عدد الأيام';
    } else {
      dayCountError = null;
    }

    if (roomTypeController.text.trim().isEmpty) {
      roomTypeError = 'يرجى اختيار نوع الغرفة';
    } else {
      roomTypeError = null;
    }

    setState(() {});

    if (isNotValid ||
        programLevelError != null ||
        dayCountError != null ||
        roomTypeError != null) {
      return;
    }

    PossibleClient newClient = PossibleClient(
      clientId: widget.id ?? UniqueKey().toString(),
      name: nameController.text,
      phoneNumber: phoneController.text,
      programLevel: programLevelController.text,
      expectedCost: expectedCostController.text,
      travelDate: myTravelDateVariable.toString(),
      dayCount: dayCountController.text,
      roomType: roomTypeController.text,
      hotelPreferences: hotelPreferencesController.text,
      flightPreferences: flightPreferencesController.text,
      additionalInfo: additionalInfoController.text,
      submissionDate: DateTime.now(),
    );

    if (widget.updateMode == false) {
      await context.read<PossibleClientsCubit>().addPossibleClients(newClient);
    } else if (widget.updateMode == true) {
      await context.read<PossibleClientsCubit>().updatePossibleClient(
        newClient,
      );
    }
    if (!mounted) return;

    showCustomToast(context, 'تم حفظ بيانات العميل بنجاح');
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      backgroundColor: Colors.grey[100],
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minHeight: 800,
          minWidth: 1100,
          maxWidth: 1100,
        ),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: SingleChildScrollView(
                  child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: formKey,
                    child: Column(
                      spacing: 20,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              'إضافة عميل محتمل',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        CustomTextField(
                          controller: nameController,
                          label: 'اسم العميل',
                          validator: (value) =>
                              validateString(value, 'برجى إدخال اسم العميل'),
                        ),
                        CustomTextField(
                          controller: phoneController,
                          label: 'رقم الهاتف',
                          validator: (value) => validatePhoneNumber(value),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomDropdownMenu(
                                label: 'المستوى',
                                errorMessage: programLevelError,
                                controller: programLevelController,
                                onSelected: (value) {
                                  if (value != null && value.isNotEmpty) {
                                    setState(() {
                                      programLevelError = null;
                                    });
                                  }
                                },
                                dropdownMenuEntries:
                                    [
                                          'برنامج اقتصادي',
                                          'برنامج 4 نجوم',
                                          'برنامج 5 نجوم',
                                        ]
                                        .map(
                                          (level) => DropdownMenuEntry(
                                            value: level,
                                            label: level,
                                          ),
                                        )
                                        .toList(),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: CustomTextField(
                                controller: expectedCostController,
                                label: 'سعر البرنامج',
                                validator: (value) => validateString(
                                  value,
                                  'برجى إدخال سعر البرنامج',
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomDropdownMenu(
                                label: 'عدد الأيام',
                                errorMessage: dayCountError,
                                controller: dayCountController,
                                onSelected: (value) {
                                  if (value != null && value.isNotEmpty) {
                                    setState(() {
                                      dayCountError = null;
                                    });
                                  }
                                },
                                dropdownMenuEntries:
                                    ['4 أيام', '10 أيام', '15 يوم']
                                        .map(
                                          (dayCount) => DropdownMenuEntry(
                                            value: dayCount,
                                            label: dayCount,
                                          ),
                                        )
                                        .toList(),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: CustomDropdownMenu(
                                errorMessage: roomTypeError,
                                label: 'نوع الغرفة',
                                controller: roomTypeController,
                                onSelected: (value) {
                                  if (value != null && value.isNotEmpty) {
                                    setState(() {
                                      roomTypeError = null;
                                    });
                                  }
                                },
                                dropdownMenuEntries:
                                    ['فردي', 'ثنائي', 'ثلاثي', 'رباعي']
                                        .map(
                                          (roomType) => DropdownMenuEntry(
                                            value: roomType,
                                            label: roomType,
                                          ),
                                        )
                                        .toList(),
                              ),
                            ),
                          ],
                        ),
                        CustomDatePicker(
                          selectedDate: myTravelDateVariable,
                          onDateChanged: (newDate) {
                            setState(() {
                              myTravelDateVariable = newDate;
                            });
                          },
                        ),
                        CustomTextField(
                          controller: hotelPreferencesController,
                          label: 'ملاحظات الفنادق السكنية',
                          isMultiLine: true,
                        ),
                        CustomTextField(
                          controller: flightPreferencesController,
                          label: 'ملاحظات شركة الطيران',
                          isMultiLine: true,
                        ),
                        CustomTextField(
                          controller: additionalInfoController,
                          label: 'الملاحظات الاضافية',
                          isMultiLine: true,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Row(
                children: [
                  CustomButton(
                    text: 'إغلاق',
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Spacer(),

                  CustomButton(
                    text: 'حفظ البيانات',
                    backgroundColor: Colors.greenAccent.withValues(alpha: 0.35),
                    foregroundColor: Colors.lightGreen[700],

                    onPressed: () async {
                      await onSave();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

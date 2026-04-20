import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saidco/features/possible_clients/domain/entities/possible_clients.dart';
import 'package:saidco/features/possible_clients/presentation/cubit/possible_clients_cubit.dart';
import 'package:saidco/features/possible_clients/presentation/widgets/custom_dropdown_menu.dart';
import 'package:saidco/features/possible_clients/presentation/widgets/custom_text_field.dart';
import 'package:saidco/features/possible_clients/presentation/widgets/date_picker.dart';
import 'package:saidco/ui/common/custom_button.dart';
import 'package:saidco/core/utils/custom_toast.dart';

class AddClientDialog extends StatefulWidget {
  const AddClientDialog({
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
  });

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
  State<AddClientDialog> createState() => _AddClientDialogState();
}

class _AddClientDialogState extends State<AddClientDialog> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController programLevelController = TextEditingController();
  TextEditingController expectedCostController = TextEditingController();
  TextEditingController dayCountController = TextEditingController();
  TextEditingController roomTypeController = TextEditingController();
  TextEditingController hotelPreferencesController = TextEditingController();
  TextEditingController flightPreferencesController = TextEditingController();
  TextEditingController additionalInfoController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  DateTime myTravelDateVariable = DateTime.now();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    phoneController.dispose();
    programLevelController.dispose();
    expectedCostController.dispose();
    dayCountController.dispose();
    roomTypeController.dispose();
    hotelPreferencesController.dispose();
    flightPreferencesController.dispose();
    additionalInfoController.dispose();
  }

  Future<void> onSave() async {
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
      submissionDate: Timestamp.now(),
    );

    await context.read<PossibleClientsCubit>().addPossibleClients(newClient);
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
                    key: formKey,
                    child: Column(
                      spacing: 20,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
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
                          content: widget.name,
                        ),
                        CustomTextField(
                          controller: phoneController,
                          label: 'رقم الهاتف',
                          content: widget.phoneNumber,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomDropdownMenu(
                                label: 'المستوى',
                                dropdownMenuEntries:
                                    [
                                          Text('اقتصادي'),
                                          Text('4 نجوم'),
                                          Text('5 نجوم'),
                                        ]
                                        .map(
                                          (level) => DropdownMenuEntry(
                                            value: level.data!,
                                            label: level.data!,
                                          ),
                                        )
                                        .toList(),
                              ),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: CustomTextField(
                                controller: expectedCostController,
                                label: 'السعر المتوقع',
                                content: widget.expectedCost,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                controller: dayCountController,
                                label: 'عدد الأيام',
                                content: widget.dayCount,
                              ),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: CustomDropdownMenu(
                                label: 'نوع الغرفة',
                                dropdownMenuEntries:
                                    [
                                          Text('فردي'),
                                          Text('ثنائي'),
                                          Text('ثلاثي'),
                                          Text('رباعي'),
                                        ]
                                        .map(
                                          (roomType) => DropdownMenuEntry(
                                            value: roomType.data!,
                                            label: roomType.data!,
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
                          content: widget.hotelPreferences,
                          isMultiLine: true,
                        ),
                        CustomTextField(
                          controller: flightPreferencesController,
                          label: 'ملاحظات شركة الطيران',
                          content: widget.flightPreferences,
                          isMultiLine: true,
                        ),
                        CustomTextField(
                          controller: additionalInfoController,
                          label: 'الملاحظات الاضافية',
                          content: widget.additionalInfo,
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

                    onPressed: () {
                      onSave();
                      showCustomToast(context, 'تم حفظ بيانات العميل بنجاح');
                      Navigator.pop(context);
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

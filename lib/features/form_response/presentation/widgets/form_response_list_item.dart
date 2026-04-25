import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saidco/core/utils/custom_toast.dart';
import 'package:saidco/core/utils/date_helper.dart';
import 'package:saidco/features/form_response/domain/entities/form_response.dart';
import 'package:saidco/features/form_response/presentation/cubit/form_response_cubit.dart';
import 'package:saidco/ui/common/data_cell.dart';
import 'package:saidco/ui/common/deletion_dialog.dart';
import 'package:saidco/ui/common/profile_dialog.dart';

class FormResponseListItem extends StatelessWidget {
  const FormResponseListItem({super.key, required this.response});

  final FormResponse response;

  String formatDate(String dateString) {
    DateTime date = DateTime.parse(dateString);
    return DateHelper.formatShortDate(date);
  }

  @override
  Widget build(BuildContext context) {
    final formResponseCubit = context.read<FormResponseCubit>();
    return Material(
      color: Colors.white70,
      borderRadius: BorderRadius.circular(12),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        hoverColor: Colors.grey.withValues(alpha: 0.1),
        splashColor: Colors.deepPurple.withValues(alpha: 0.15),
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => ProfileDialog(
              id: response.responseId,
              name: response.name,
              phoneNumber: response.phoneNumber,
              programLevel: response.programLevel,
              expectedCost: response.expectedCost,
              travelDate: response.travelDate,
              dayCount: response.dayCount,
              roomType: response.roomType,
              hotelPreferences: response.hotelPreferences,
              flightPreferences: response.flightPreferences,
              additionalInfo: response.additionalInfo,
              isContacted: response.isContacted,
              toggleContacted: () {
                formResponseCubit.toggleContactStatus(
                  response.responseId,
                  !response.isContacted,
                );
              },
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 60,
          padding: const EdgeInsets.only(left: 24, top: 16, bottom: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              PopupMenuButton(
                position: PopupMenuPosition.under,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.zero,
                menuPadding: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.only(right: 16, left: 4),
                  child: SizedBox(
                    height: 50,
                    child: Icon(
                      Icons.more_vert,
                      size: 20,
                      color: Colors.grey[400],
                    ),
                  ),
                ),
                itemBuilder: (context) {
                  return [
                    if (response.isContacted == true)
                      PopupMenuItem(
                        onTap: () async {
                          await Future.delayed(
                            const Duration(milliseconds: 50),
                          );
                          formResponseCubit.transferToPossibleClient(response);
                        },
                        child: const Text('تحويل لعميل محتمل'),
                      ),
                    PopupMenuItem(
                      onTap: () async {
                        await Future.delayed(const Duration(milliseconds: 50));
                        if (!context.mounted) return;
                        showDialog(
                          context: context,
                          builder: (context) => BlocProvider.value(
                            value: formResponseCubit,
                            child: DeletionDialog(
                              alertMessage: 'هل أنت متأكد من حذف هذا التسجيل؟',
                              content: 'الاسم : ${response.name}',
                              onDelete: () {
                                formResponseCubit.deleteFormResponse(
                                  response.responseId,
                                );
                                Navigator.pop(context);
                                showCustomToast(
                                  context,
                                  'تم حذف التسجيل بنجاح',
                                );
                              },
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        'حذف التسجيل',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ];
                },
              ),
              TextCell(text: response.name, flex: 3, isBold: true),
              TextCell(text: response.phoneNumber, flex: 2),
              TextCell(text: response.programLevel, flex: 2),
              TextCell(text: formatDate(response.travelDate), flex: 2),
              TextCell(text: response.dayCount, flex: 2),
              TextCell(
                text: response.roomType == 'ثلاثي'
                    ? 'ثـــلاثي'
                    : response.roomType,
                flex: 2,
              ),
              TextCell(
                text: response.isContacted ? 'تم التواصل' : 'لم يتم التواصل',
                flex: 2,
                color: response.isContacted ? Colors.green : Colors.red,
              ),
              Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
            ],
          ),
        ),
      ),
    );
  }
}

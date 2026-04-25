import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saidco/core/utils/custom_toast.dart';
import 'package:saidco/core/utils/date_helper.dart';
import 'package:saidco/features/possible_clients/domain/entities/possible_clients.dart';
import 'package:saidco/features/possible_clients/presentation/cubit/possible_clients_cubit.dart';
import 'package:saidco/features/possible_clients/presentation/widgets/add_client_dialog.dart';
import 'package:saidco/ui/common/data_cell.dart';
import 'package:saidco/ui/common/deletion_dialog.dart';
import 'package:saidco/ui/common/profile_dialog.dart';

class PossibleClientListItem extends StatelessWidget {
  const PossibleClientListItem({super.key, required this.possibleClient});

  final PossibleClient possibleClient;

  String formatDate(String dateString) {
    DateTime date = DateTime.parse(dateString);
    return DateHelper.formatShortDate(date);
  }

  @override
  Widget build(BuildContext context) {
    final possibleClientsCubit = context.read<PossibleClientsCubit>();
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
            builder: (context) => BlocProvider.value(
              value: possibleClientsCubit,
              child: ProfileDialog(
                isPossibleClient: true,
                id: possibleClient.clientId,
                name: possibleClient.name,
                phoneNumber: possibleClient.phoneNumber,
                programLevel: possibleClient.programLevel,
                expectedCost: possibleClient.expectedCost,
                travelDate: possibleClient.travelDate,
                dayCount: possibleClient.dayCount,
                roomType: possibleClient.roomType,
                hotelPreferences: possibleClient.hotelPreferences,
                flightPreferences: possibleClient.flightPreferences,
                additionalInfo: possibleClient.additionalInfo,
              ),
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
                    PopupMenuItem(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return BlocProvider.value(
                              value: possibleClientsCubit,
                              child: AddUpdateClientDialog(
                                updateMode: true,
                                id: possibleClient.clientId,
                                name: possibleClient.name,
                                phoneNumber: possibleClient.phoneNumber,
                                programLevel: possibleClient.programLevel,
                                expectedCost: possibleClient.expectedCost,
                                travelDate: possibleClient.travelDate,
                                dayCount: possibleClient.dayCount,
                                roomType: possibleClient.roomType,
                                familyInfo: possibleClient.familyInfo,
                                hotelPreferences:
                                    possibleClient.hotelPreferences,
                                flightPreferences:
                                    possibleClient.flightPreferences,
                                additionalInfo: possibleClient.additionalInfo,
                              ),
                            );
                          },
                        );
                      },
                      child: const Text('تعديل التسجيل'),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (dialogContext) => BlocProvider.value(
                            value: possibleClientsCubit,
                            child: DeletionDialog(
                              alertMessage: 'هل أنت متأكد من حذف هذا العميل؟',
                              content: 'الاسم : ${possibleClient.name}',
                              onDelete: () {
                                possibleClientsCubit.deletePossibleClient(
                                  possibleClient.clientId,
                                );
                                Navigator.pop(context);
                                showCustomToast(context, 'تم حذف العميل بنجاح');
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
              TextCell(text: possibleClient.name, flex: 3, isBold: true),
              TextCell(text: possibleClient.phoneNumber, flex: 2),
              TextCell(text: possibleClient.programLevel, flex: 2),
              TextCell(text: formatDate(possibleClient.travelDate), flex: 2),
              TextCell(text: possibleClient.dayCount, flex: 2),
              TextCell(
                text: possibleClient.roomType == 'ثلاثي'
                    ? 'ثـــلاثي'
                    : possibleClient.roomType,
                flex: 2,
              ),
              Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
            ],
          ),
        ),
      ),
    );
  }
}

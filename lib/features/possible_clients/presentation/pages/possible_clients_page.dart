import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saidco/core/utils/custom_toast.dart';
import 'package:saidco/core/utils/date_helper.dart';
import 'package:saidco/features/form_response/presentation/widgets/profile_dialog.dart';
import 'package:saidco/features/possible_clients/presentation/cubit/possible_clients_cubit.dart';
import 'package:saidco/features/possible_clients/presentation/cubit/possible_clients_states.dart';
import 'package:saidco/ui/common/custom_button.dart';
import 'package:saidco/ui/common/data_cell.dart';
import 'package:saidco/ui/common/header_cell.dart';

class PossibleClientsPage extends StatefulWidget {
  const PossibleClientsPage({super.key});

  @override
  State<PossibleClientsPage> createState() => _PossibleClientsPageState();
}

class _PossibleClientsPageState extends State<PossibleClientsPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    context.read<PossibleClientsCubit>().getPossibleClients();
  }

  String formatDate(String dateString) {
    DateTime date = DateTime.parse(dateString);
    return DateHelper.formatShortDate(date);
  }

  @override
  Widget build(BuildContext context) {
    final possibleClientsCubit = context.read<PossibleClientsCubit>();

    return BlocBuilder<PossibleClientsCubit, PossibleClientsState>(
      builder: (context, state) {
        if (state is PossibleClientsLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is PossibleClientsError) {
          return Center(
            child: Text(
              'حدث خطأ أثناء تحميل البيانات: ${state.message}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
          );
        }

        if (state is PossibleClientsLoaded) {
          final possibleClients = state.possibleClients;

          if (possibleClients.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.only(bottom: 75),
                child: Text(
                  'لا يوجد بيانات لعرضها',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            );
          }

          return Column(
            children: [
              SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 20,
                ),
                child: Column(
                  children: [
                    const Row(
                      children: [
                        SizedBox(width: 16),
                        HeaderCell(icon: Icons.person, text: 'الاسم', flex: 3),
                        HeaderCell(
                          icon: Icons.phone,
                          text: 'رقم الهاتف',
                          flex: 2,
                        ),
                        HeaderCell(icon: Icons.grade, text: 'المستوى', flex: 2),
                        HeaderCell(
                          icon: Icons.date_range,
                          text: 'تاريخ السفر',
                          flex: 2,
                        ),
                        HeaderCell(
                          icon: Icons.timelapse,
                          text: 'عدد الأيام',
                          flex: 2,
                        ),
                        HeaderCell(
                          icon: Icons.hotel,
                          text: 'نوع الغرفة',
                          flex: 2,
                        ),

                        SizedBox(width: 26),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.only(bottom: 75),
                  itemCount: possibleClients.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final possibleClient = possibleClients[index];

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
                                id: possibleClient.clientId,
                                name: possibleClient.name,
                                phoneNumber: possibleClient.phoneNumber,
                                programLevel: possibleClient.programLevel,
                                expectedCost: possibleClient.expectedCost,
                                travelDate: possibleClient.travelDate,
                                dayCount: possibleClient.dayCount,
                                roomType: possibleClient.roomType,
                                hotelPreferences:
                                    possibleClient.hotelPreferences,
                                flightPreferences:
                                    possibleClient.flightPreferences,
                                additionalInfo: possibleClient.additionalInfo,
                              ),
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          height: 60,
                          padding: const EdgeInsets.only(
                            left: 24,
                            top: 16,
                            bottom: 16,
                          ),
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
                                  padding: const EdgeInsets.only(
                                    right: 16,
                                    left: 4,
                                  ),
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
                                          builder: (dialogContext) => BlocProvider.value(
                                            value: possibleClientsCubit,
                                            child: AlertDialog(
                                              content: SizedBox(
                                                height: 200,
                                                width: 350,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                    8.0,
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Center(
                                                        child: Text(
                                                          'هل أنت متأكد من حذف هذا التسجيل؟',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(height: 50),
                                                      Text(
                                                        'الاسم : ${possibleClient.name}',
                                                      ),
                                                      Spacer(),
                                                      Row(
                                                        children: [
                                                          CustomButton(
                                                            width: 130,
                                                            text: 'إغلاق',
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                  dialogContext,
                                                                ),
                                                          ),
                                                          Spacer(),
                                                          CustomButton(
                                                            width: 140,
                                                            text: 'حذف التسجيل',
                                                            backgroundColor:
                                                                Colors.redAccent
                                                                    .withValues(
                                                                      alpha:
                                                                          0.35,
                                                                    ),
                                                            foregroundColor:
                                                                Colors.red[700],
                                                            onPressed: () {
                                                              log(
                                                                possibleClient
                                                                    .clientId
                                                                    .toString(),
                                                              );
                                                              possibleClientsCubit
                                                                  .deletePossibleClient(
                                                                    possibleClient
                                                                        .clientId,
                                                                  );
                                                              Navigator.pop(
                                                                context,
                                                              );
                                                              showCustomToast(
                                                                context,
                                                                'تم حذف التسجيل بنجاح',
                                                              );
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        'حذف التسجيل',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ];
                                },
                              ),
                              TextCell(
                                text: possibleClient.name,
                                flex: 3,
                                isBold: true,
                              ),
                              TextCell(
                                text: possibleClient.phoneNumber,
                                flex: 2,
                              ),
                              TextCell(
                                text: possibleClient.programLevel,
                                flex: 2,
                              ),
                              TextCell(
                                text: formatDate(possibleClient.travelDate),
                                flex: 2,
                              ),
                              TextCell(text: possibleClient.dayCount, flex: 2),
                              TextCell(
                                text: possibleClient.roomType == 'ثلاثي'
                                    ? 'ثـــلاثي'
                                    : possibleClient.roomType,
                                flex: 2,
                              ),

                              Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                                color: Colors.grey[400],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}

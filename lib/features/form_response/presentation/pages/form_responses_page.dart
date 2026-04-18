import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saidco/core/enums/filtering_enums.dart';
import 'package:saidco/features/form_response/presentation/cubit/form_response_cubit.dart';
import 'package:saidco/features/form_response/presentation/cubit/form_response_state.dart';
import 'package:saidco/features/form_response/presentation/widgets/filter_toggle_buttons.dart';
import 'package:saidco/ui/common/custom_button.dart';
import 'package:saidco/ui/common/data_cell.dart';
import 'package:saidco/ui/common/header_cell.dart';
import 'package:saidco/features/form_response/presentation/widgets/profile_dialog.dart';
import 'package:saidco/core/utils/custom_toast.dart';

class ResponsesPage extends StatefulWidget {
  const ResponsesPage({super.key});

  @override
  State<ResponsesPage> createState() => _ResponsesPageState();
}

class _ResponsesPageState extends State<ResponsesPage> {
  @override
  void initState() {
    super.initState();
    context.read<FormResponseCubit>().getFormResponses();
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FilterStatus filterStatus = FilterStatus.all;

  @override
  Widget build(BuildContext context) {
    final formResponseCubit = context.read<FormResponseCubit>();
    return BlocBuilder<FormResponseCubit, FormResponseState>(
      builder: (context, state) {
        if (state is FormResponseLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is FormResponseError) {
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

        if (state is FormResponseLoaded) {
          final responses = state.responses;

          if (responses.isEmpty) {
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
              FilterToggleButtons(
                onPressed: (index) {
                  setState(() {
                    if (index == 0) {
                      filterStatus = FilterStatus.all;
                      context.read<FormResponseCubit>().getFormResponses();
                    }
                    if (index == 1) {
                      filterStatus = FilterStatus.notContacted;
                      context.read<FormResponseCubit>().getFormResponses(
                        filterStatus: FilterStatus.notContacted.name,
                      );
                    }
                  });
                },
                isSelected: [
                  filterStatus == FilterStatus.all,
                  filterStatus == FilterStatus.notContacted,
                ],
              ),
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
                        HeaderCell(
                          icon: Icons.forum,
                          text: 'حالة التواصل',
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
                  padding: EdgeInsets.zero,
                  itemCount: responses.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final response = responses[index];

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
                            builder: (context) =>
                                ProfileDialog(formResponse: response),
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
                                    if (response.isContacted == true)
                                      PopupMenuItem(
                                        onTap: () async {
                                          await Future.delayed(
                                            Duration(milliseconds: 50),
                                          );
                                          formResponseCubit.transferToPossibleClient(
                                            response,
                                          );
                                        },
                                        child: Text('تحويل لعميل محتمل'),
                                      ),
                                    PopupMenuItem(
                                      onTap: () async {
                                        await Future.delayed(
                                          Duration(milliseconds: 50),
                                        );
                                        if (!context.mounted) return;
                                        showDialog(
                                          context: context,
                                          builder: (context) => BlocProvider.value(
                                            value: formResponseCubit,
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
                                                        'الاسم : ${response.name}',
                                                      ),
                                                      Spacer(),
                                                      Row(
                                                        children: [
                                                          CustomButton(
                                                            width: 130,
                                                            text: 'إغلاق',
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                  context,
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
                                                              formResponseCubit
                                                                  .deleteFormResponse(
                                                                    response
                                                                        .responseId,
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
                                text: response.name,
                                flex: 3,
                                isBold: true,
                              ),
                              TextCell(text: response.phoneNumber, flex: 2),
                              TextCell(text: response.programLevel, flex: 2),
                              TextCell(text: response.travelDate, flex: 2),
                              TextCell(text: response.dayCount, flex: 2),
                              TextCell(
                                text: response.roomType == 'ثلاثي'
                                    ? 'ثـــلاثي'
                                    : response.roomType,
                                flex: 2,
                              ),
                              TextCell(
                                text: response.isContacted
                                    ? 'تم التواصل'
                                    : 'لم يتم التواصل',
                                flex: 2,
                                color: response.isContacted
                                    ? Colors.green
                                    : Colors.red,
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

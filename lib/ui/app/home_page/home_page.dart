import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:saidco/services/remote_form_response_service.dart';
import 'package:saidco/ui/common/custom_button.dart';
import 'package:saidco/ui/common/custom_rich_text.dart';
import 'package:saidco/ui/common/data_cell.dart';
import 'package:saidco/ui/common/header_cell.dart';
import 'package:saidco/ui/app/profile/profile_dialog.dart';
import 'package:saidco/ui/common/layouts/main_layout.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final Stream<List<dynamic>> _formStream;

  @override
  void initState() {
    super.initState();
    _formStream = RemoteFormResponseService().getFormResponse();
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      body: StreamBuilder(
        stream: _formStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'حدث خطأ أثناء تحميل البيانات: ${snapshot.error}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
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

          final responses = snapshot.data!;

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 20,
                ),
                child: const Row(
                  children: [
                    SizedBox(width: 16),
                    HeaderCell(icon: Icons.person, text: 'الاسم', flex: 3),
                    HeaderCell(icon: Icons.phone, text: 'رقم الهاتف', flex: 2),
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
                    HeaderCell(icon: Icons.hotel, text: 'نوع الغرفة', flex: 2),
                    HeaderCell(
                      icon: Icons.forum,
                      text: 'حالة التواصل',
                      flex: 2,
                    ),
                    SizedBox(width: 26),
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
                                iconColor: Colors.grey[400],
                                iconSize: 20,
                                itemBuilder: (context) {
                                  return [
                                    PopupMenuItem(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            content: SizedBox(
                                              height: 200,
                                              width: 350,
                                              child: Padding(
                                                padding: const EdgeInsets.all(
                                                  8.0,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
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
                                                    SizedBox(height: 40),
                                                    Text(
                                                      'بإسم : ${response.name}',
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
                                                                    alpha: 0.35,
                                                                  ),
                                                          foregroundColor:
                                                              Colors.red[700],
                                                          onPressed: () {
                                                            firestore
                                                                .collection(
                                                                  'form_submissions',
                                                                )
                                                                .doc(
                                                                  response
                                                                      .formId,
                                                                )
                                                                .delete();
                                                            Navigator.pop(
                                                              context,
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
        },
      ),
    );
  }
}

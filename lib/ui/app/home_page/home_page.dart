import 'package:flutter/material.dart';
import 'package:saidco/services/remote_form_response_service.dart';
import 'package:saidco/ui/app/common/text_cell.dart';
import 'package:saidco/ui/app/profile/profile_page.dart';
import 'package:saidco/ui/values/spaces.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          backgroundColor: Colors.grey[50]!,
          toolbarHeight: 100,
          title: Row(
            children: [Image.asset('assets/images/logo.png', height: 165)],
          ),
          centerTitle: true,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.grey[50]!, Colors.deepPurple[100]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(paddingSpace),
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: RemoteFormResponseService().getFormResponse(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'Failed to load form responses + ${snapshot.error}',
                        ),
                      );
                    }

                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text('No form responses found'),
                      );
                    }

                    final responses = snapshot.data!;

                    return SingleChildScrollView(
                      child: SizedBox(
                        width: double.infinity,
                        child: DataTable(
                          columns: const [
                            DataColumn(
                              label: TextCell(
                                label: 'الاسم',
                                icon: Icons.person,
                              ),
                            ),
                            DataColumn(
                              label: TextCell(
                                label: 'رقم الهاتف',
                                icon: Icons.phone,
                              ),
                            ),
                            DataColumn(
                              label: TextCell(
                                label: 'المستوى',
                                icon: Icons.star,
                              ),
                            ),
                            DataColumn(
                              label: TextCell(
                                label: 'تاريخ السفر',
                                icon: Icons.calendar_month,
                              ),
                            ),
                            DataColumn(
                              label: TextCell(
                                label: 'عدد الأيام',
                                icon: Icons.timelapse,
                              ),
                            ),
                            DataColumn(
                              label: TextCell(
                                label: 'نوع الغرفة',
                                icon: Icons.hotel,
                              ),
                            ),
                          ],
                          rows: responses.map((response) {
                            return DataRow(
                              onSelectChanged: (value) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ProfilePage(),
                                  ),
                                );
                              },
                              cells: [
                                DataCell(Text(response.name)),
                                DataCell(Text(response.phoneNumber)),
                                DataCell(Text(response.programLevel)),
                                DataCell(Text(response.travelDate)),
                                DataCell(Text(response.dayCount)),
                                DataCell(Text(response.roomType)),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:saidco/services/remote_form_response_service.dart';
import 'package:saidco/ui/app/common/data_cell.dart';
import 'package:saidco/ui/app/common/header_cell.dart';
import 'package:saidco/ui/values/spaces.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        toolbarHeight: 100,
        leadingWidth: 200,
        leading: Transform.scale(
          scale: 1.8,
          child: Padding(
            padding: const EdgeInsets.only(top: 8, right: 8),
            child: Image.asset('assets/images/logo.png', fit: BoxFit.contain),
          ),
        ),
        title: const Text('DASHBOARD'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.grey[100]!, Colors.deepPurple[50]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(paddingSpace),
          child: Column(
            children: [
              SizedBox(height: 100),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 20,
                ),
                child: const Row(
                  children: [
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
                    SizedBox(width: 26),
                  ],
                ),
              ),

              const SizedBox(height: 16),
              Expanded(
                child: StreamBuilder(
                  stream: _formStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No data found'));
                    }

                    final responses = snapshot.data!;

                    return ListView.separated(
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
                            hoverColor: Colors.grey.withValues(alpha: 0.075),
                            splashColor: Colors.deepPurple.withValues(
                              alpha: 0.1,
                            ),
                            onTap: () {
                              print('Testing');
                            },
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 16,
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
                                  TextCell(
                                    text: response.name,
                                    flex: 3,
                                    isBold: true,
                                  ),
                                  TextCell(text: response.phoneNumber, flex: 2),
                                  TextCell(
                                    text: response.programLevel,
                                    flex: 2,
                                  ),
                                  TextCell(text: response.travelDate, flex: 2),
                                  TextCell(text: response.dayCount, flex: 2),
                                  TextCell(text: response.roomType, flex: 2),
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

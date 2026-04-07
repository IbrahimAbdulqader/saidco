import 'package:flutter/material.dart';
import 'package:saidco/services/remote_form_response_service.dart';
import 'package:saidco/ui/app/common/list_tiles/form_list_tile.dart';
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
            colors: [Colors.grey[50]!, Colors.grey[100]!],
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

                    return Column(
                      children: [
                        const FormListTile(
                          name: 'الاسم',
                          phoneNumber: 'رقم الهاتف',
                          programLevel: 'المستوى',
                          travelDate: 'تاريخ السفر',
                          dayCount: 'عدد الأيام',
                          roomType: 'نوع الغرفة',
                          isHeader: true,
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final formResponse = snapshot.data![index];
                              return FormListTile(
                                name: formResponse.name,
                                phoneNumber: formResponse.phoneNumber,
                                programLevel: formResponse.programLevel,
                                travelDate: formResponse.travelDate,
                                dayCount: formResponse.dayCount,
                                roomType: formResponse.roomType,
                              );
                            },
                          ),
                        ),
                      ],
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

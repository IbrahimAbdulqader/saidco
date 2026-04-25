import 'package:flutter/material.dart';
import 'package:saidco/ui/common/header_cell.dart';

class FormResponsesHeader extends StatelessWidget {
  const FormResponsesHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 25, bottom: 25, left: 20, right: 20),
      child: Row(
        children: [
          SizedBox(width: 16),
          HeaderCell(icon: Icons.person, text: 'الاسم', flex: 3),
          HeaderCell(icon: Icons.phone, text: 'رقم الهاتف', flex: 2),
          HeaderCell(icon: Icons.grade, text: 'المستوى', flex: 2),
          HeaderCell(icon: Icons.date_range, text: 'تاريخ السفر', flex: 2),
          HeaderCell(icon: Icons.timelapse, text: 'عدد الأيام', flex: 2),
          HeaderCell(icon: Icons.hotel, text: 'نوع الغرفة', flex: 2),
          HeaderCell(icon: Icons.forum, text: 'حالة التواصل', flex: 2),
          SizedBox(width: 26),
        ],
      ),
    );
  }
}

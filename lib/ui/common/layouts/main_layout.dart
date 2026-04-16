import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saidco/core/di/injection_container.dart';
import 'package:saidco/features/form_response/presentation/cubit/form_response_cubit.dart';
import 'package:saidco/features/form_response/presentation/pages/form_responses_page.dart';
import 'package:saidco/ui/common/custom_app_bar.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  final List<String> _titles = [
    'تسجيلات العملاء',
    'العملاء المحتملين',
    'إدارة التسكينات',
    'إدارة الحسابات',
  ];

  final List<Widget> _pages = [
    BlocProvider(
      create: (context) => sl<FormResponseCubit>(),
      child: ResponsesPage(),
    ),
    Center(child: Text('صفحة العملاء المحتملين')),
    Center(child: Text('صفحة إدارة التسكينات')),
    Center(child: Text('صفحة إدارة الحسابات')),
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: CustomAppBar(title: _titles[selectedIndex]),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.grey[100]!, Colors.deepPurple[100]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Row(
          children: [
            MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: NavigationRail(
                groupAlignment: -1,
                minWidth: 60,
                backgroundColor: Colors.deepPurpleAccent[100]!.withValues(
                  alpha: 0.5,
                ),
                indicatorColor: Colors.deepPurple.withValues(alpha: 0.2),
                indicatorShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                unselectedIconTheme: IconThemeData(color: Colors.grey[700]),
                selectedIconTheme: IconThemeData(color: Colors.deepPurple),
                unselectedLabelTextStyle: TextStyle(color: Colors.grey[700]),
                selectedLabelTextStyle: TextStyle(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                ),
                onDestinationSelected: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                },
                leading: Column(
                  children: [
                    Image.asset('assets/images/logo.png', width: 100),
                    SizedBox(height: 25),
                  ],
                ),
                labelType: NavigationRailLabelType.all,
                destinations: [
                  NavigationRailDestination(
                    padding: EdgeInsets.only(bottom: 12),
                    icon: Icon(Icons.table_chart_outlined),
                    selectedIcon: Icon(Icons.table_chart),
                    label: Text('تسجيلات العملاء'),
                  ),
                  NavigationRailDestination(
                    padding: EdgeInsets.only(bottom: 12),
                    icon: Icon(Icons.group_outlined),
                    selectedIcon: Icon(Icons.group),
                    label: Text('العملاء المحتملين'),
                  ),
                  NavigationRailDestination(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    icon: Icon(Icons.hotel_outlined),
                    selectedIcon: Icon(Icons.hotel),
                    label: Text('إدارة التسكينات'),
                  ),
                  NavigationRailDestination(
                    padding: EdgeInsets.only(top: 12),
                    icon: Icon(Icons.account_balance_outlined),
                    selectedIcon: Icon(Icons.account_balance),
                    label: Text('إدارة الحسابات'),
                  ),
                ],
                selectedIndex: selectedIndex,
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.grey[100]!, Colors.deepPurple[100]!],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 36,
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 100),
                      Expanded(child: _pages[selectedIndex]),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

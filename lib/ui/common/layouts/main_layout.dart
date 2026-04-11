import 'package:flutter/material.dart';
import 'package:saidco/ui/common/custom_app_bar.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key, required this.body});

  final Widget body;

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int selectedIndex = 0;
  List<String> titles = [
    'تسجيلات العملاء',
    'ادارة التسكينات',
    'ادارة الحسابات',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: CustomAppBar(title: titles[selectedIndex]),
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
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    icon: Icon(Icons.hotel_outlined),
                    selectedIcon: Icon(Icons.hotel),
                    label: Text('ادارة التسكينات'),
                  ),
                  NavigationRailDestination(
                    padding: EdgeInsets.only(top: 12),
                    icon: Icon(Icons.account_balance_outlined),
                    selectedIcon: Icon(Icons.account_balance),
                    label: Text('ادارة الحسابات'),
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
                      Expanded(child: widget.body),
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

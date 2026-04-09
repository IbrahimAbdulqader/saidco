import 'package:flutter/material.dart';
import 'package:saidco/ui/common/custom_app_bar.dart';
import 'package:saidco/ui/values/spaces.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key, required this.body});

  final Widget body;

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int selectedIndex = 0;
  List<String> titles = ['الرئيسية', 'الملف الشخصي', 'الإعدادات'];

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
                    label: Text('الرئيسية'),
                  ),
                  NavigationRailDestination(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    icon: Icon(Icons.account_box_outlined),
                    selectedIcon: Icon(Icons.account_box),
                    label: Text('الملف الشخصي'),
                  ),
                  NavigationRailDestination(
                    padding: EdgeInsets.only(top: 12),
                    icon: Icon(Icons.settings_outlined),
                    selectedIcon: Icon(Icons.settings),
                    label: Text('الإعدادات'),
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
                  padding: const EdgeInsets.all(paddingSpace),
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

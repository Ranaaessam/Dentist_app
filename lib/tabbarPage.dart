import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:idental/Pending.dart';
import 'approved.dart';

class TabBarPage extends StatefulWidget {
  const TabBarPage({Key? key}) : super(key: key);

  @override
  _TabBarPageState createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Text('Appointments',
                  style: GoogleFonts.montserrat(
                      fontSize: 26,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
              Container(
                width: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: Column(
                  children: [
                    TabBar(
                        padding: EdgeInsets.only(top: 25),
                        unselectedLabelColor: Colors.teal,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicator: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Colors.teal,
                              Color(0xFF80CBC4),
                            ]),
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.redAccent),
                        controller: tabController,
                        tabs: [
                          Tab(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text("Pending"),
                            ),
                          ),
                          Tab(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text("Approved"),
                            ),
                          ),
                        ]),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    pending(),
                    approved(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

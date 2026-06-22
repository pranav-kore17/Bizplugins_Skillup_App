import 'package:flutter/material.dart';
import 'package:bizplugins_skillup/utils/colors.dart';
import 'package:bizplugins_skillup/screens/leave/apply_leave_dialog.dart';
import 'package:bizplugins_skillup/screens/leave/widgets/leave_summary_card.dart';
import 'package:bizplugins_skillup/screens/leave/data/leave_data.dart';
import 'package:bizplugins_skillup/screens/leave/widgets/leave_card.dart';
import 'package:bizplugins_skillup/screens/leave/data/leave_summary_data.dart';
import 'package:bizplugins_skillup/screens/leave/comp_off_dialog.dart';
import 'package:bizplugins_skillup/screens/leave/data/comp_off_data.dart';
import 'package:bizplugins_skillup/screens/leave/widgets/comp_off_card.dart';

class LeaveScreen extends StatefulWidget {
  const LeaveScreen({super.key});

  @override
  State<LeaveScreen> createState() => _LeaveScreenState();
}

class _LeaveScreenState extends State<LeaveScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  String? selectedFilter;

  final List<String> filterTypes = [
    "Month",
    "Quarter",
    "Half Year",
    "Year",
  ];

  List leaves = leaveData["leaveRequests"];
  Map employee = leaveData["employee"];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      floatingActionButton:
          (_tabController.index == 0 || _tabController.index == 2)
              ? FloatingActionButton(
                  shape: const CircleBorder(),
                  backgroundColor: primaryColor,
                  elevation: 6,
                  onPressed: () {
                    if (_tabController.index == 0) {
                      showDialog(
                        context: context,
                        builder: (_) => const ApplyLeaveDialog(),
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (_) => const CompOffDialog(),
                      );
                    }
                  },
                  child: const Icon(Icons.add, size: 28, color: Colors.white),
                )
              : null,
      body: Column(
        children: [
          Container(
            color: primaryColor,
            child: TabBar(
              controller: _tabController,
              indicatorColor: Colors.white,
              indicatorWeight: 4,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white70,
              onTap: (index) {
                setState(() {});
              },
              tabs: const [
                Tab(text: "APPLY LEAVES"),
                Tab(text: "MY LEAVES"),
                Tab(text: "COMP OFF"),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ListView(
                  padding: const EdgeInsets.all(10),
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            "My Request",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: primaryColor),
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.white,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.filter_list,
                                  size: 18, color: Colors.grey),
                              const SizedBox(width: 6),
                              DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: selectedFilter,
                                  hint: const Text("Select Types"),
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  items: filterTypes.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedFilter = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: leaves.length,
                      itemBuilder: (context, index) {
                        final leave = leaves[index];

                        return LeaveCard(
                          title: leave["title"],
                          appliedOn: leave["appliedOn"],
                          days: "${leave["days"]} days",
                          date:
                              "${leave["dateRange"]["from"]} - ${leave["dateRange"]["to"]}",
                          reason: leave["reason"],
                          status: leave["status"],
                          employeeName: employee["name"],
                          designation: employee["designation"],
                          employeeId: employee["employeeId"],
                        );
                      },
                    ),
                  ],
                ),
                ListView.builder(
                  padding: const EdgeInsets.all(14),
                  itemCount: leaveSummaryData.length,
                  itemBuilder: (context, index) {
                    final item = leaveSummaryData[index];

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: LeaveSummaryCard(
                        title: item["title"],
                        total: item["total"],
                        balance: item["balance"],
                        icon: item["icon"],
                        color: item["color"],
                      ),
                    );
                  },
                ),
                ListView.builder(
                  padding: const EdgeInsets.all(14),
                  itemCount: compOffData.length,
                  itemBuilder: (context, index) {
                    final item = compOffData[index];
                    return CompOffCard(
                      date: item["date"],
                      hours: item["hours"],
                      status: item["status"],
                      reason: item["reason"],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

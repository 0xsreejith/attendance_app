import 'package:flutter/material.dart';

class ApplyForLeaveScreen extends StatefulWidget {
  const ApplyForLeaveScreen({super.key});

  @override
  State<ApplyForLeaveScreen> createState() => _ApplyForLeaveScreenState();
}

class _ApplyForLeaveScreenState extends State<ApplyForLeaveScreen> {
  final TextEditingController reasonController = TextEditingController();
  String? selectedLeaveType;

  final List<String> leaveTypes = [
    "Annual Leave",
    "Sick Leave",
    "Maternity Leave",
    "Paternity Leave",
    "Unpaid Leave",
    "Other"
  ];

  DateTime? fromDate;
  DateTime? toDate;

  Future<void> pickFromDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() => fromDate = picked);
      if (toDate != null && toDate!.isBefore(fromDate!)) {
        toDate = null;
      }
    }
  }

  Future<void> pickToDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: fromDate ?? DateTime.now(),
      firstDate: fromDate ?? DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() => toDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Row
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey, // Line color
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CircleAvatar(
                        backgroundImage: AssetImage("assets/images/logo.jpeg"),
                        radius: 28,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  offset: const Offset(
                                      -2, 2), // Left & bottom shadow
                                  blurRadius: 6,
                                  spreadRadius: 0,
                                ),
                              ],
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "Search",
                                hintStyle: TextStyle(color: Colors.grey[600]),
                                border: InputBorder.none,
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 10),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Stack(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: const BoxDecoration(
                                  color: Colors.blue,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.notifications,
                                    color: Colors.white),
                              ),
                              Positioned(
                                top: 2,
                                right: 2,
                                child: Container(
                                  width: 8,
                                  height: 8,
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 12),
                          const CircleAvatar(
                            backgroundImage: NetworkImage(
                                "https://imgs.search.brave.com/EQwbpjTWOjGzqB5UYYu9inlAzhLlj1S_N7qOUUOxkY0/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9zdGF0/aWMudmVjdGVlenku/Y29tL3N5c3RlbS9y/ZXNvdXJjZXMvdGh1/bWJuYWlscy8wNTkv/MzQwLzY4OC9zbWFs/bC9wcm9mZXNzaW9u/YWwtbWFuLXBvc2Vz/LWNvbmZpZGVudGx5/LWluLW1vZGVybi1v/ZmZpY2Utd2l0aC1s/YXJnZS13aW5kb3dz/LWFuZC11cmJhbi12/aWV3LXBob3RvLmpw/Zw"),
                            radius: 23,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // use two containers btn dashboard and request to leave 
                //if clicked show dashborad if clike request to leave show above 
                const SizedBox(height: 24),
                const Text(
                  "Apply for leave",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                const SizedBox(height: 16),
                buildLabeledTextField("Employee Name", Icons.person,
                    "Employee Name - auto-filled",
                    readOnly: true),
                const SizedBox(height: 16),
                buildLabeledTextField(
                    "Employee ID", Icons.badge, "Employee ID - auto-filled",
                    readOnly: true),
                const SizedBox(height: 24),
                const Text("From",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Expanded(
                      child:
                          buildDatePicker("From Date", fromDate, pickFromDate),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: buildDatePicker("To Date", toDate, pickToDate),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const Text("Leave Type",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                DropdownButtonFormField<String>(
                  value: selectedLeaveType,
                  icon: const Icon(Icons.arrow_drop_down),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.list),
                    hintText: 'Choose Type',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  items: leaveTypes
                      .map((type) =>
                          DropdownMenuItem(value: type, child: Text(type)))
                      .toList(),
                  onChanged: (value) =>
                      setState(() => selectedLeaveType = value),
                ),
                const SizedBox(height: 24),
                const Text("Reason",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                TextFormField(
                  controller: reasonController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: "Text area",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                const SizedBox(height: 24),
                const Text("Attachment",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "Attachment (Optional)",
                    prefixIcon: const Icon(Icons.attach_file),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  padding:const EdgeInsets.all(10),
                  decoration:const BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: const Center(
                    child: Text("Submit",style: TextStyle(color: Colors.white),),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLabeledTextField(String label, IconData icon, String hintText,
      {bool readOnly = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        TextFormField(
          readOnly: readOnly,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: Icon(icon),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );
  }

  Widget buildDatePicker(String label, DateTime? date, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: InputDecorator(
        decoration: InputDecoration(
          hintText: label,
          prefixIcon: const Icon(Icons.calendar_today),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(
          date != null ? "${date.day}/${date.month}/${date.year}" : label,
          style: TextStyle(
              color: date != null ? Colors.black : Colors.grey.shade600),
        ),
      ),
    );
  }
}

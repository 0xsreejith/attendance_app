import 'package:attendance_app/app/modules/payslip/controller/pay_slip_controller.dart';
import 'package:attendance_app/app/modules/payslip/view/coponents/info_row.dart';
import 'package:attendance_app/app/widgets/custom_header.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaylipScreen extends StatelessWidget {
  PaylipScreen({super.key});
  final PayslipController controller = Get.put(PayslipController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomHeader(),
            const SizedBox(height: 20),
            Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back, color: Colors.black),
                ),
                const SizedBox(width: 10),
                const Text(
                  "Payslip",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 20),

            RepaintBoundary(
              key: controller.payslipBoundaryKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo + Month
                  Obx(() => Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                  offset: Offset(4, 4)),
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset("assets/images/logo.jpeg",
                                    height: 50, width: 50),
                                const SizedBox(width: 10),
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("ZiyaAcademy",
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue)),
                                    Text("KEY-TO SUCCESS",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.green)),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Text("Payslip for the Month"),
                                Text(controller.selectedMonth.value,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)),
                              ],
                            )
                          ],
                        ),
                      )),
                  const SizedBox(height: 20),

                  Obx(() => Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                offset: Offset(4, 4)),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("EMPLOYEE SUMMARY",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
                                  SizedBox(height: 10),
                                  InfoRow("Employee Name", "Hemant Rangarajan"),
                                  InfoRow(
                                      "Designation", "Full-stack Developer"),
                                  InfoRow("Employee ID", "Employee ID"),
                                  InfoRow("Date of Joining", "30/05/2025"),
                                  InfoRow("Pay Period", "June 2025"),
                                  InfoRow("Pay Date", "15/07/2025"),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              flex: 2,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[50],
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 4,
                                        offset: Offset(-4, -4)),
                                    BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 4,
                                        offset: Offset(4, 4)),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(12),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.green.shade100,
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(12),
                                            topRight: Radius.circular(12)),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                              width: 5,
                                              height: 50,
                                              color: Colors.green.shade700),
                                          const SizedBox(width: 10),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(controller.netPay.value,
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              const Text("Employee Net Pay"),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const DottedLine(),
                                    const SizedBox(height: 10),
                                    const Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        children: [
                                          InfoRow("Paid Days", "31"),
                                          InfoRow("LOP Days", "0"),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                  const SizedBox(height: 20),

                  // PF & UAN
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("PF A/C Number    :",
                          style: TextStyle(
                              fontSize: 14, color: Colors.grey.shade700)),
                      const Text("AA/AAA/999999/99G/9899",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("UAN    :",
                          style: TextStyle(
                              fontSize: 14, color: Colors.grey.shade700)),
                      const Text("1111111111",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Earnings & Deductions
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12)),
                    ),
                    child: Table(
                      columnWidths: const {
                        0: FlexColumnWidth(1),
                        1: FlexColumnWidth(1),
                        2: FlexColumnWidth(1),
                        3: FlexColumnWidth(1),
                        4: FlexColumnWidth(1),
                      },
                      children: [
                        _buildTableRow([
                          "EARNINGS",
                          "AMOUNT",
                          "YTD",
                          "DEDUCTIONS",
                          "AMOUNT",
                          "YTD"
                        ], isHeader: true),
                        _buildTableRow([
                          "Basic",
                          "₹25,000",
                          "₹3,00,000",
                          "PF Deduction",
                          "₹2,500",
                          "₹30,000"
                        ]),
                        _buildTableRow([
                          "HRA",
                          "₹10,000",
                          "₹1,20,000",
                          "Tax Deduction",
                          "₹7,500",
                          "₹90,000"
                        ]),
                        _buildTableRow([
                          "Travel Allowance",
                          "₹3,000",
                          "₹36,000",
                          "",
                          "",
                          ""
                        ]),
                        _buildTableRow([
                          "Meal / Other Allow.",
                          "₹2,000",
                          "₹24,000",
                          "",
                          "",
                          ""
                        ]),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    color: Colors.blue.shade50,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Gross Earnings ₹55,000",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text("Total Deductions ₹10,000",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Net Pay Box
                  Obx(() => Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade200),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Net Salary",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                                Text("Gross Earnings - Total Deductions",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.black54)),
                              ],
                            ),
                            Text(controller.netPay.value,
                                style: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      )),
                  const SizedBox(height: 8),
                  Obx(() => Text(
                        "Amount in Words: ${_amountInWords(controller.netPay.value)}",
                        style: const TextStyle(fontSize: 14),
                      )),
                  const SizedBox(height: 20),
                  const Text(
                    "-This document has been automatically generated by Ziya Academy",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // ✅ Download Button
            GestureDetector(
              onTap: () => controller.exportPayslipToPdf(),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blue.shade400,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    "Download the sample salary slip format for PDF",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Payslip History
            const Text("Monthly Payslip History",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            _buildPayslipHistoryCard(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  String _amountInWords(String amount) {
    final value = amount.replaceAll('₹', '').replaceAll(',', '');
    final numericValue = double.tryParse(value) ?? 0;

    if (numericValue == 41000) return "Indian Rupee Forty-One Thousand Only";
    if (numericValue == 43500)
      return "Indian Rupee Forty-Three Thousand Five Hundred Only";
    if (numericValue == 45000) return "Indian Rupee Forty-Five Thousand Only";
    return "Indian Rupee ${numericValue.toInt()} Only";
  }

  TableRow _buildTableRow(List<String> cells, {bool isHeader = false}) {
    return TableRow(
      children: cells
          .map((cell) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(cell,
                  style: TextStyle(
                      fontWeight:
                          isHeader ? FontWeight.bold : FontWeight.normal))))
          .toList(),
    );
  }

  Widget _buildPayslipHistoryCard() {
    final List<List<String>> payslips = [
      ['March 2025', '₹41,000'],
      ['April 2025', '₹43,500'],
      ['May 2025', '₹45,000'],
      ['June 2025', '₹45,000'],
    ];

    return Obx(() {
      final controller = Get.find<PayslipController>();
      return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow(
              decoration: BoxDecoration(color: Colors.grey.shade200),
              children: [
                _tableHeaderCell("Month"),
                _tableHeaderCell("Net Pay"),
                _tableHeaderCell("Status"),
                _tableHeaderCell("Action"),
              ],
            ),
            for (final row in payslips)
              TableRow(
                children: [
                  _tableCell(row[0]),
                  _tableCell(row[1]),
                  _tableCell("✅ Generated"),
                  GestureDetector(
                    onTap: () {
                      controller.updatePayslipData(row[0]);
                      controller.markAsDownloaded(row[0]);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        controller.downloadedMonths[row[0]] == true
                            ? "✅ Downloaded"
                            : "📥 Download",
                        style: TextStyle(
                          fontSize: 13,
                          color: controller.downloadedMonths[row[0]] == true
                              ? Colors.green
                              : Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      );
    });
  }

  Widget _tableCell(String text) => Padding(
        padding: const EdgeInsets.all(10),
        child: Text(text, style: const TextStyle(fontSize: 13)),
      );

  Widget _tableHeaderCell(String text) => Padding(
        padding: const EdgeInsets.all(10),
        child: Text(text,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
      );
}

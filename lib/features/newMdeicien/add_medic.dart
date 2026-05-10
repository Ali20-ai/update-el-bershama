import 'dart:io';

import 'package:el_bershama/core/data_Source/data_source.dart';
import 'package:el_bershama/core/notifications/notification_service.dart';
import 'package:el_bershama/core/style/colors_manger.dart';
import 'package:el_bershama/core/style/styles_manger.dart';
import 'package:el_bershama/core/widgets/button_widget.dart';
import 'package:el_bershama/features/models/personal/models.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';

class AddMedicineScreen extends StatefulWidget {
  const AddMedicineScreen({super.key});

  @override
  State<AddMedicineScreen> createState() => _AddMedicineScreenState();
}

class _AddMedicineScreenState extends State<AddMedicineScreen> {
  int doseCount = 1;

  DateTime? startDate;
  DateTime? endDate;

  File? selectedImage;

  final ImagePicker picker = ImagePicker();

  final List<TextEditingController> timeControllers = [];

  final TextEditingController medicineNameController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    timeControllers.add(TextEditingController());
  }

  @override
  void dispose() {
    medicineNameController.dispose();

    for (var c in timeControllers) {
      c.dispose();
    }

    super.dispose();
  }

  Future<void> pickImageFromCamera() async {
    final XFile? image = await picker.pickImage(
      source: ImageSource.camera,
    );

    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  Future<void> _selectDate(
    BuildContext context,
    bool isStartDate,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        if (isStartDate) {
          startDate = picked;
        } else {
          endDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: ColorsManger.withColor,

        appBar: AppBar(
          backgroundColor: ColorsManger.primaryColor,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  "إضافة دواء جديد",
                  style: StylesManger.white20Bold,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: ColorsManger.withColor,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ],
          ),
        ),

        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE8F0FE),
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                        child: selectedImage != null
                            ? Image.file(selectedImage!, fit: BoxFit.cover)
                            : const Icon(
                                Icons.medication,
                                size: 80,
                                color: ColorsManger.primaryColor,
                              ),
                      ),
                    ),
                    Positioned(
                      bottom: 5,
                      left: 5,
                      child: InkWell(
                        onTap: pickImageFromCamera,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: ColorsManger.primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              _buildLabel("اسم الدواء"),

              _buildTextField(
                hint: "اكتب اسم الدواء",
                controller: medicineNameController,
              ),

              const SizedBox(height: 20),

              _buildLabel("عدد الجرعات يومياً"),

              _buildCounter(),

              const SizedBox(height: 20),

              _buildLabel("مواعيد الجرعات"),

              Column(
                children: [
                  ...List.generate(
                    timeControllers.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: timeControllers[index],
                              readOnly: true,
                              onTap: () async {
                                final picked = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );

                                if (picked != null) {
                                  timeControllers[index].text =
                                      picked.format(context);
                                }
                              },
                              decoration: InputDecoration(
                                hintText: "اختار الوقت",
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                if (timeControllers.length > 1) {
                                  timeControllers[index].dispose();
                                  timeControllers.removeAt(index);
                                }
                              });
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: ColorsManger.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: _buildAddAppointmentButton(),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              _buildLabel("تاريخ البداية"),

              _buildDatePickerField(
                hint: startDate == null
                    ? "اختر التاريخ"
                    : "${startDate!.year}-${startDate!.month}-${startDate!.day}",
                onTap: () => _selectDate(context, true),
              ),

              const SizedBox(height: 20),

              _buildLabel("تاريخ النهاية (اختياري)"),

              _buildDatePickerField(
                hint: endDate == null
                    ? "اختر التاريخ"
                    : "${endDate!.year}-${endDate!.month}-${endDate!.day}",
                onTap: () => _selectDate(context, false),
              ),

              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ButtonWidget(
                  onpress: () async {

                    final times = timeControllers
                        .map((e) => e.text)
                        .where((e) => e.isNotEmpty)
                        .toList();

                    final medicine = Medicine(
                      name: medicineNameController.text,
                      doseCount: doseCount,
                      times: times,
                      startDate: startDate!,
                      endDate: endDate,
                      image: selectedImage?.path ?? '',
                    );

                    await FirebaseDataSource().addMedicine(medicine);

                    // 🔥 تحويل أول وقت لإشعار
                    final time = times.first;
                    final clean = time.replaceAll(RegExp(r'[^0-9:]'), '');
                    final parts = clean.split(':');

                    final now = DateTime.now();

                    final scheduledTime = DateTime(
                      now.year,
                      now.month,
                      now.day,
                      int.parse(parts[0]),
                      int.parse(parts[1]),
                    );

                    await NotificationService.scheduleNotification(
                      id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
                      title: "ميعاد الدواء 💊",
                      body: medicine.name,
                      time: scheduledTime,
                    );

                    Navigator.pop(context, medicine);
                  },
                  text: 'حفظ الدواء',
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: StylesManger.black18Bold.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String hint,
    required TextEditingController controller,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildCounter() {
    return Container(
      width: 150,
      height: 55,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                if (doseCount > 1) doseCount--;
              });
            },
            icon: const Icon(Icons.remove,
                color: ColorsManger.primaryColor),
          ),
          Text("$doseCount", style: StylesManger.black18Bold),
          IconButton(
            onPressed: () {
              setState(() {
                doseCount++;
              });
            },
            icon: const Icon(Icons.add,
                color: ColorsManger.primaryColor),
          ),
        ],
      ),
    );
  }

  Widget _buildAddAppointmentButton() {
    return InkWell(
      onTap: () {
        setState(() {
          timeControllers.add(TextEditingController());
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.add, color: ColorsManger.primaryColor),
            SizedBox(width: 8),
            Text("إضافة موعد"),
          ],
        ),
      ),
    );
  }

  Widget _buildDatePickerField({
    required String hint,
    required VoidCallback onTap,
  }) {
    return TextField(
      readOnly: true,
      onTap: onTap,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        prefixIcon: const Icon(Icons.calendar_today_outlined),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
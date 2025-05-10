import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ongi/widgets/medicine/medicine_type_selector.dart';

class TimedMedicineAdder extends StatefulWidget {
  final String medicationName;

  const TimedMedicineAdder({Key? key, required this.medicationName}) : super(key: key);

  @override
  State<TimedMedicineAdder> createState() => _TimedMedicineAdderState();
}

class _TimedMedicineAdderState extends State<TimedMedicineAdder> {
  List<TimeOfDay> selectedTimes = [];

  void _showTimerPicker() async {
    Duration tempDuration = const Duration(hours: 0, minutes: 0);

    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: 400,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Expanded(
                child: CupertinoTimerPicker(
                  mode: CupertinoTimerPickerMode.hm,
                  initialTimerDuration: const Duration(hours: 0, minutes: 0),
                  onTimerDurationChanged: (Duration newDuration) {
                    tempDuration = newDuration;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('취소', style: TextStyle(color: Colors.grey, fontSize: 16)),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, tempDuration),
                      child: const Text('확인', style: TextStyle(color: Colors.deepOrange, fontSize: 16)),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    ).then((picked) {
      if (picked != null) {
        setState(() {
          selectedTimes.add(TimeOfDay(hour: picked.inHours, minute: picked.inMinutes.remainder(60)));
        });
      }
    });
  }

  void _removeTime(TimeOfDay time) {
    setState(() {
      selectedTimes.remove(time);
    });
  }

  bool get _isValid => selectedTimes.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade300), // ✅ 전체 박스 테두리 유지
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('약 이름', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F0F0),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(widget.medicationName, style: const TextStyle(color: Colors.black87)),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _showTimerPicker,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.grey,
                    elevation: 0,
                    side: const BorderSide(color: Colors.grey),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text('복용시간 추가하기', style: TextStyle(fontSize: 16)),
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.builder(
                  itemCount: selectedTimes.length,
                  itemBuilder: (context, index) {
                    final time = selectedTimes[index];
                    return ListTile(
                      title: Text(
                        '${time.hour.toString().padLeft(2, '0')}시 ${time.minute.toString().padLeft(2, '0')}분',
                        style: const TextStyle(fontSize: 16),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.grey),
                        onPressed: () => _removeTime(time),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
              // ✅ 회색 테두리를 제거한 버튼 Row
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const MedicineTypeSelector()),
                        (route) => false,
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.grey),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('닫기', style: TextStyle(color: Colors.black)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _isValid
                          ? () {
                              final medicine = {
                                'name': widget.medicationName,
                                'type': 'timed',
                                'times': selectedTimes,
                              };
                              Navigator.pop(context, medicine);
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF8A50),
                        disabledBackgroundColor: Colors.grey.shade300,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('저장'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

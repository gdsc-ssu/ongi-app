import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
          height: 400, // ✅ picker 높이 키움
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
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '약 이름',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFF0F0F0),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                widget.medicationName,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _showTimerPicker,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange.shade50,
                foregroundColor: Colors.deepOrange,
                elevation: 2,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('복용시간 추가하기', style: TextStyle(fontSize: 18)),
            ),
            const SizedBox(height: 16),
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
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.grey),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('닫기', style: TextStyle(fontSize: 18, color: Colors.black)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: _isValid ? () {} : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF8A50),
                  disabledBackgroundColor: Colors.grey.shade300,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('저장', style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimedMedicineAdder extends StatefulWidget {
  final String medicationName;
  final void Function(Map<String, dynamic>) onSaved;

  const TimedMedicineAdder({
    Key? key,
    required this.medicationName,
    required this.onSaved,
  }) : super(key: key);

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
                      child: const Text('Cancel', style: TextStyle(color: Colors.grey, fontSize: 16)),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, tempDuration),
                      child: const Text('Confirm', style: TextStyle(color: Colors.deepOrange, fontSize: 16)),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        const Text('Medication Time', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 12),
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
            child: const Text('Add Medication Time', style: TextStyle(fontSize: 16)),
          ),
        ),
        const SizedBox(height: 12),
        ...selectedTimes.map((time) => ListTile(
              leading: const Icon(Icons.access_time),
              title: Text(
                '${time.hour.toString().padLeft(2, '0')}Hour ${time.minute.toString().padLeft(2, '0')}Minute',
                style: const TextStyle(fontSize: 16),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.grey),
                onPressed: () => _removeTime(time),
              ),
            )),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _isValid
                ? () {
                    final medicine = {
                      'name': widget.medicationName,
                      'type': 'timed',
                      'times': selectedTimes,
                    };
                    widget.onSaved(medicine);
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF8A50),
              disabledBackgroundColor: Colors.grey.shade300,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Save'),
          ),
        )
      ],
    );
  }
}

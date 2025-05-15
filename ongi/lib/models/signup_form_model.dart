import 'package:flutter/material.dart';

class SignUpFormModel extends ChangeNotifier {
  String? loginId;
  String? password;
  String? guardianName;
  String? guardianPhone;
  String? seniorName;
  int? seniorAge;
  String? seniorPhone;
  String? relation;
  String alertMax = 'MINUTES_30';
  int ignoreCnt = 3;
  bool pushAgreement = false;
  bool voiceAgreement = false;
  bool backgroundAgreement = false;

  Map<String, dynamic> toJson() => {
        "loginId": loginId,
        "password": password,
        "guardianName": guardianName,
        "guardianPhone": guardianPhone,
        "seniorName": seniorName,
        "seniorAge": seniorAge,
        "seniorPhone": seniorPhone,
        "relation": relation,
        "alertMax": alertMax,
        "ignoreCnt": ignoreCnt,
        "pushAgreement": pushAgreement,
        "voiceAgreement": voiceAgreement,
        "backgroundAgreement": backgroundAgreement,
      };
    
    List<Map<String, dynamic>> medications = [];

    void addMedication(Map<String, dynamic> med) {
    medications.add(med);
    notifyListeners();
    }

    List<Map<String, dynamic>> meals = [];

    void addMeal({required String type, required TimeOfDay time}) {
    final formattedTime = '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    meals.add({
        'meal_type': type, // BREAKFAST, LUNCH, DINNER
        'meal_time': formattedTime,
    });
    notifyListeners();
    }

}


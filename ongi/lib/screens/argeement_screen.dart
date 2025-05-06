import 'package:flutter/material.dart';

class AgreementScreen extends StatefulWidget {
  const AgreementScreen({Key? key}) : super(key: key);

  @override
  State<AgreementScreen> createState() => _AgreementScreenState();
}

class _AgreementScreenState extends State<AgreementScreen> {
  bool allChecked = false;
  List<bool> checked = [false, false, false];
  bool get isAllRequiredChecked => checked.every((v) => v);

  void onAllCheckedChanged(bool? value) {
    setState(() {
      allChecked = value ?? false;
      for (int i = 0; i < checked.length; i++) {
        checked[i] = allChecked;
      }
    });
  }

  void onCheckedChanged(int idx, bool? value) {
    setState(() {
      checked[idx] = value ?? false;
      allChecked = checked.every((v) => v);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 48),
              Text('서비스 이용 동의', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              SizedBox(height: 12),
              Text('서비스 이용을 위해 약관에 동의해 주세요.', style: TextStyle(fontSize: 18, color: Colors.grey)),
              SizedBox(height: 36),
              CheckboxListTile(
                value: allChecked,
                onChanged: onAllCheckedChanged,
                activeColor: Color(0xFFFF8A4D),
                title: Text('전체동의', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                subtitle: Text('서비스 이용을 위해 아래 약관에 모두 동의합니다.', style: TextStyle(color: Colors.grey)),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
              ),
              Divider(height: 32, thickness: 1),
              CheckboxListTile(
                value: checked[0],
                onChanged: (val) => onCheckedChanged(0, val),
                activeColor: Color(0xFFFF8A4D),
                title: Row(
                  children: [
                    Text('개인정보 이용 동의 (필수)', style: TextStyle(fontSize: 18)),
                    Spacer(),
                    Text('보기', style: TextStyle(color: Colors.grey)),
                  ],
                ),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
              ),
              CheckboxListTile(
                value: checked[1],
                onChanged: (val) => onCheckedChanged(1, val),
                activeColor: Color(0xFFFF8A4D),
                title: Row(
                  children: [
                    Text('보이스 알림 제공 동의 (필수)', style: TextStyle(fontSize: 18)),
                    Spacer(),
                    Text('보기', style: TextStyle(color: Colors.grey)),
                  ],
                ),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
              ),
              CheckboxListTile(
                value: checked[2],
                onChanged: (val) => onCheckedChanged(2, val),
                activeColor: Color(0xFFFF8A4D),
                title: Row(
                  children: [
                    Text('백그라운드 작동 동의 (필수)', style: TextStyle(fontSize: 18)),
                    Spacer(),
                    Text('보기', style: TextStyle(color: Colors.grey)),
                  ],
                ),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
              ),
              if (!isAllRequiredChecked)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 4.0),
                  child: Text(
                    '(필수) 표시가 된 모든 항목에 동의가 필요합니다.',
                    style: TextStyle(color: Colors.red, fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ),
              Spacer(),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.grey),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        padding: EdgeInsets.symmetric(vertical: 18),
                      ),
                      child: Text('이전', style: TextStyle(fontSize: 20, color: Colors.grey[700], fontWeight: FontWeight.bold)),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: isAllRequiredChecked ? () {} : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFF8A4D),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        padding: EdgeInsets.symmetric(vertical: 18),
                        elevation: 0,
                      ),
                      child: Text('다음', style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

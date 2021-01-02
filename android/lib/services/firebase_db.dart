import 'package:air_quality/controller/data_ctl.dart';
import 'package:air_quality/controller/status_ctl.dart';
import 'package:air_quality/model/kolam_model.dart';
import 'package:air_quality/model/status_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class FirebaseDb {
  static realtimeData() async {
    final ctl = Get.put(StatusCtl());
    Query ref = FirebaseDatabase.instance.reference().child('/realtime');
    ref.onValue.listen(
      (event) {
        DataSnapshot snapshot = event.snapshot;
        Map<dynamic, dynamic> data = snapshot.value;
        // print(data);
        ctl.updateRealtime(StatusModel.fromMap(data));
      },
    );
  }

  static history() async {
    final ctl = Get.put(DataCtl());
    Query ref = FirebaseDatabase.instance.reference().child('/history');
    ref.onValue.listen(
      (event) {
        List<KolamModel> model = [];
        DataSnapshot snapshot = event.snapshot;
        Map<dynamic, dynamic> logs = snapshot.value;
        try {
          logs.forEach(
            (key, value) {
              try {
                model.add(KolamModel.fromMap(value));
              } catch (e) {
                print('Error : $e');
              }
            },
          );
        } catch (e) {}
        model.sort((a, b) => a.timestamp.compareTo(b.timestamp));
        ctl.updateHistory(model);
      },
    );
  }
}

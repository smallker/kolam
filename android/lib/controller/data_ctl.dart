import 'package:get/get.dart';
import 'package:air_quality/model/kolam_model.dart';

class DataCtl extends GetxController {
  KolamModel kolam0 =
      KolamModel(id: '0', flow: '0', ph: '0', temperature: '0', timestamp: 0);
  KolamModel kolam1 =
      KolamModel(id: '0', flow: '0', ph: '0', temperature: '0', timestamp: 0);
  KolamModel kolam2 =
      KolamModel(id: '0', flow: '0', ph: '0', temperature: '0', timestamp: 0);
  KolamModel kolam3 =
      KolamModel(id: '0', flow: '0', ph: '0', temperature: '0', timestamp: 0);
  // KolamModel kolam1;
  // KolamModel kolam2;
  List<KolamModel> history;

  updateHistory(List<KolamModel> history) {
    this.history = history;
    history.forEach(
      (element) {
        switch (int.parse(element.id)) {
          case 0:
            this.kolam0 = element;
            break;
          case 1:
            this.kolam1 = element;
            break;
          case 2:
            this.kolam2 = element;
            break;
          case 3:
            this.kolam3 = element;
            break;
          default:
            break;
        }
      },
    );
    update();
  }
}

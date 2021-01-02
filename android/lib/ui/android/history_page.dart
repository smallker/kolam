import 'package:air_quality/controller/data_ctl.dart';
import 'package:air_quality/widgets/mytext.dart';
import 'package:air_quality/widgets/pixel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class HistoryPage extends StatelessWidget {
  Widget _body() {
    return Expanded(
      flex: 4,
      child: GetBuilder<DataCtl>(
        init: DataCtl(),
        builder: (snapshot) {
          snapshot.history = snapshot.history.reversed.toList();
          return Container(
            width: Pixel.x * 90,
            height: Pixel.y * 40,
            child: snapshot.history == null || snapshot.history.length == 0
                ? Center(
                    child: MyText(
                      text: 'Tidak ada data',
                      color: Colors.blue,
                      fontSize: Pixel.x * 7,
                    ),
                  )
                : ListView.builder(
                    itemCount: snapshot.history.length,
                    itemBuilder: (context, index) {
                      var id = snapshot.history[index].id;
                      var temperature = snapshot.history[index].temperature;
                      var ph = snapshot.history[index].ph;
                      var flow = snapshot.history[index].flow;
                      var timestamp = snapshot.history[index].timestamp;
                      return _item(
                        'Kolam $id',
                        'Suhu : $temperature  pH : $ph  Flow : $flow',
                        timestamp,
                      );
                    },
                  ),
          );
        },
      ),
    );
  }

  Widget _item(String status, String detail, int timestamp) {
    return Container(
      width: Pixel.x * 90,
      height: Pixel.y * 15,
      padding: EdgeInsets.all(
        Pixel.x * 2,
      ),
      margin: EdgeInsets.all(
        Pixel.x * 2,
      ),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(
          Pixel.x * 3,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              child: Icon(
                Icons.history,
                size: Pixel.x * 10,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                    text: status,
                    fontSize: Pixel.x * 5,
                  ),
                  MyText(
                    text: detail,
                    fontSize: Pixel.x * 4,
                  ),
                  MyText(
                    text: DateTime.fromMillisecondsSinceEpoch(timestamp)
                        .toString()
                        .split('.')[0],
                    fontSize: Pixel.x * 4,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Pixel().init(context);
    return Column(
      children: [
        _body(),
      ],
    );
  }
}

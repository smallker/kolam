import 'package:air_quality/controller/data_ctl.dart';
import 'package:air_quality/model/kolam_model.dart';
import 'package:air_quality/widgets/pixel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class StatusCarouselPage extends StatefulWidget {
  @override
  _StatusCarouselPageState createState() => _StatusCarouselPageState();
}

class _StatusCarouselPageState extends State<StatusCarouselPage> {
  int carouselIndex = 0;

  Widget _sensorBox({String title, String subtitle, IconData icon}) {
    return Expanded(
      flex: 2,
      child: Container(
        child: ListTile(
          leading: Icon(
            icon,
            color: Colors.white,
            size: Pixel.x * 13,
          ),
          title: Text(
            title,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: Pixel.x * 5,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: Pixel.x * 7,
            ),
          ),
        ),
      ),
    );
  }

  Widget _kolam(KolamModel model) {
    return Container(
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.transparent,
              child: Lottie.asset('assets/liquid.json'),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(
                  Pixel.x * 5,
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Text(
                        'Kolam ${model.id}',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: Pixel.x * 5,
                        ),
                      ),
                    ),
                  ),
                  _sensorBox(
                    icon: Icons.thermostat_rounded,
                    title: 'Suhu',
                    subtitle: '${model.temperature} °C',
                  ),
                  _sensorBox(
                    icon: Icons.timeline,
                    title: 'pH',
                    subtitle: '${model.ph}',
                  ),
                  _sensorBox(
                    icon: Icons.mic_external_on,
                    title: 'Flow',
                    subtitle: '${model.flow}L/H',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dot() {
    return Expanded(
      flex: 1,
      child: Container(
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(1),
              width: Pixel.x * 2,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: carouselIndex == 0 ? Colors.blue : Colors.grey,
              ),
            ),
            Container(
              margin: EdgeInsets.all(1),
              width: Pixel.x * 2,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: carouselIndex == 1 ? Colors.blue : Colors.grey,
              ),
            ),
            Container(
              margin: EdgeInsets.all(1),
              width: Pixel.x * 2,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: carouselIndex == 2 ? Colors.blue : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Pixel().init(context);
    return Container(
      margin: EdgeInsets.only(
        top: Pixel.y * 10,
        bottom: Pixel.y * 10,
        left: Pixel.x * 10,
        right: Pixel.x * 10,
      ),
      child: Column(
        children: [
          Expanded(
            flex: 9,
            child: GetBuilder<DataCtl>(
                init: DataCtl(),
                builder: (snapshot) {
                  return CarouselSlider(
                    options: CarouselOptions(
                      height: Pixel.y * 80,
                      aspectRatio: 2 / 4,
                      autoPlay: false,
                      enlargeCenterPage: true,
                      viewportFraction: 1,
                      onPageChanged: (index, carousel) =>
                          setState(() => carouselIndex = index),
                    ),
                    items: [
                      _kolam(snapshot.kolam0),
                      _kolam(snapshot.kolam1),
                      _kolam(snapshot.kolam2),
                    ],
                  );
                }),
          ),
          _dot(),
        ],
      ),
    );
  }
}

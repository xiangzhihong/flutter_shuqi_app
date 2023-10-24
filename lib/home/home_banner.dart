import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../public.dart';
import '../utility/screen.dart';
import 'home_model.dart';

class HomeBanner extends StatelessWidget {
  final List<CarouselInfo> carouselInfos;

  HomeBanner(this.carouselInfos);

  @override
  Widget build(BuildContext context) {
    if (carouselInfos.isEmpty) {
      return SizedBox();
    }

    return Container(
      color: Colors.white,
      child: CarouselSlider(
        items: carouselInfos.map((info) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: Screen.width,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                child: GestureDetector(
                  child: Image.network(
                    info.imageUrl ?? '',
                    fit: BoxFit.cover,
                  ),
                  onTap: (){
                    AppNavigator.pushWeb(context, 'https://t.shuqi.com/', '书旗小说');
                  },
                ),
              );
            },
          );
        }).toList(),
        options: CarouselOptions(
          aspectRatio: 2,
          autoPlay: true,
        ),
      ),
    );
  }
}

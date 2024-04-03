import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/image_strings.dart';

class CarouselDashboard extends StatelessWidget {
  const CarouselDashboard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: const Image(
                  image: AssetImage(tCarouselFirst) ,fit: BoxFit.contain,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: const Image(
                  image: AssetImage(tCarouselSec),fit: BoxFit.contain,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: const Image(
                  image: AssetImage(tCarouselThird),fit: BoxFit.contain,
                ),
              ),
            ),
          ],
          options: CarouselOptions(
            viewportFraction: 1,
            autoPlay: true,
            autoPlayAnimationDuration: const Duration(seconds: 2),
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        // Row(
        //   children: [
        //     for(int i = 0; i< 3; i++)
        //       Container(
        //         width: 20.0,
        //         height: 4.0,
        //         margin: EdgeInsets.only(right: 10.0),
        //         padding: EdgeInsets.all(5.0),
        //         decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(5.0),
        //             color: tPrimaryColor
        //         ),
        //       ),
        //   ],
        // ),
      ],
    );
  }
}
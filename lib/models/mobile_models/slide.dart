import 'package:brixmarket/res/strings.dart';

class Slider {
  final String sliderImageUrl;
  final String sliderTopSubHeading;
  final String sliderHeading;
  final String sliderSubHeading;
  final String skipBtn;

  Slider(
      {required this.sliderImageUrl,
      required this.sliderHeading,
      required this.sliderSubHeading,
      required this.sliderTopSubHeading,
      this.skipBtn = ''});
}

final sliderArrayList = [
  Slider(
      sliderImageUrl: 'assets/images/home1.jpg',
      sliderTopSubHeading: SLIDER_HEADING_1_SUB,
      sliderHeading: SLIDER_HEADING_1,
      sliderSubHeading: SLIDER_DESC1,
      skipBtn: SKIP),
  Slider(
      sliderImageUrl: 'assets/images/hero1.jpg',
      sliderTopSubHeading: SLIDER_HEADING_2_SUB,
      sliderHeading: SLIDER_HEADING_2,
      sliderSubHeading: SLIDER_DESC2,
      skipBtn: SKIP),
  Slider(
      sliderImageUrl: 'assets/images/welcome2.jpg',
      sliderTopSubHeading: SLIDER_HEADING_3_SUB,
      sliderHeading: SLIDER_HEADING_3,
      sliderSubHeading: SLIDER_DESC3,
      skipBtn: ''),
];

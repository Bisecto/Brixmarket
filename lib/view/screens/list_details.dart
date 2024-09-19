import 'dart:math';

import 'package:brixmarket/config/theme/color.dart';
import 'package:brixmarket/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';

import '../../controllers/instance.dart';
import '../../controllers/property_controller.dart';
import '../../core/app.dart';
import '../../models/media_model.dart';
import '../../models/property_model.dart';
import '../../utils/utils.dart';
import '../widgets/custom_button.dart';
import '../widgets/footer_page.dart';
import '../widgets/form_inputs.dart';
import '../widgets/navbar.dart';
import '../widgets/save_property_icon.dart';

class PropertyDetailsListsPage extends StatefulWidget {
  const PropertyDetailsListsPage({Key? key}) : super(key: key);

  @override
  State<PropertyDetailsListsPage> createState() => _PropertyDetailsListsPageState();
}

class _PropertyDetailsListsPageState extends State<PropertyDetailsListsPage> {
  late PageController _controller;
  bool checkState = true;

  @override
  void initState() {
    _controller = PageController(
      initialPage: 0,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var vw = MediaQuery.of(context).size.width;
    double mainPad = (pow(vw, 5) / 40000000000000.1);
    int iFeature = 0;
    Property property = homeCtrl.property;
    String image = property.media!.isNotEmpty ? property.media![0].media! : '';
    List<Media> images = property.media ?? [];
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        backgroundColor: Pallet.homeBackground,
        body: (constraints.maxWidth <= 950)
            ? Center(
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CustomText(
                    text: 'Display mobile view',
                  ),
                  CustomText(
                    text: '${constraints.maxWidth}',
                    size: 22,
                    weight: FontWeight.w800,
                  ),
                ],
              ))
            : Container(
                height: Get.height,
                width: Get.width,
                color: Pallet.homeBackground,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      navBar(),
                      topMessage(homeCtrl: homeCtrl),
                      InkWell(
                        onTap: () => Get.back(),
                        child: Container(
                          height: 42,
                          color: const Color.fromARGB(153, 206, 203, 203),
                          padding: const EdgeInsets.only(left: 120),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.arrow_back_ios_new,
                                size: 11,
                                color: Colors.black54,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              CustomText(
                                text: 'Back to properties',
                                size: 14,
                                color: Pallet.secondaryColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: mainPad, vertical: 20),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 8,
                              child: Stack(
                                children: [
                                  SizedBox(
                                    height: Get.width * 0.4,
                                    child: PageView(
                                      controller: _controller,
                                      children: [
                                        ...images.map((media) {
                                          return Stack(
                                            children: [
                                              Container(
                                                width: Get.width,
                                                decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(propertyImgPath + media.media!))),
                                              ),
                                              Container(
                                                width: Get.width,
                                                color: Colors.black.withOpacity(0.1),
                                              ),
                                            ],
                                          );
                                        }).toList(),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    top: 275,
                                    left: 40,
                                    child: GestureDetector(
                                      onTap: () => previousPage(),
                                      child: Container(
                                        height: 30,
                                        width: 30,
                                        child: const Icon(Icons.arrow_back_ios_new, size: 10),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(40), color: Colors.white.withOpacity(0.6)),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 275,
                                    right: 40,
                                    child: GestureDetector(
                                      onTap: () => nextPage(),
                                      child: Container(
                                        height: 30,
                                        width: 30,
                                        child: const Icon(
                                          Icons.arrow_forward_ios,
                                          size: 10,
                                        ),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(40), color: Colors.white.withOpacity(0.4)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: Get.width * 0.4 * 0.02,
                            ),
                            Expanded(
                              flex: 2,
                              child: ListView.builder(
                                  itemCount: 3,
                                  shrinkWrap: true,
                                  itemBuilder: ((context, index) {
                                    return (index == 2)
                                        ? Stack(
                                            children: [
                                              Container(
                                                height: Get.width * 0.4 * 0.32,
                                                decoration:
                                                    BoxDecoration(image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(propertyImgPath + images[index].media!))),
                                              ),
                                              Container(
                                                height: Get.width * 0.4 * 0.32,
                                                color: Colors.black.withOpacity(0.4),
                                              ),
                                              images.length > 3
                                                  ? SizedBox(
                                                      height: Get.width * 0.4 * 0.32,
                                                      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                                        CustomText(
                                                            text: (images.length > 3 ? (images.length - 3).toString() + ' images' : '').toString(),
                                                            color: Colors.white70,
                                                            size: 14),
                                                        const SizedBox(width: 5),
                                                        const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 12)
                                                      ]),
                                                    )
                                                  : const SizedBox.shrink(),
                                            ],
                                          )
                                        : Stack(
                                            children: [
                                              Container(
                                                height: Get.width * 0.4 * 0.32,
                                                margin: EdgeInsets.only(
                                                  bottom: Get.width * 0.4 * 0.02,
                                                ),
                                                decoration:
                                                    BoxDecoration(image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(propertyImgPath + images[index].media!))),
                                              ),
                                            ],
                                          );
                                  })),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: mainPad),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 8,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 32,
                                        width: 120,
                                        padding: const EdgeInsets.only(top: 3),
                                        child: Center(
                                          child: CustomText(color: const Color(0xFF308b85), text: property.type!.toUpperCase(), weight: FontWeight.w500, size: 14),
                                        ),
                                        color: const Color(0xFFebfcfb),
                                      ),
                                      Container(
                                        height: 32,
                                        width: 84,
                                        padding: const EdgeInsets.only(top: 3),
                                        margin: const EdgeInsets.only(left: 8),
                                        child: Center(
                                          child: CustomText(color: Colors.white, text: property.status!.toUpperCase(), weight: FontWeight.w500, size: 14),
                                        ),
                                        color: Pallet.secondaryColor,
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 35,
                                  ),
                                  Row(
                                    children: const [
                                      Icon(Icons.calendar_month, color: Pallet.secondaryColor, size: 18),
                                      SizedBox(width: 5),
                                      CustomText(
                                        text: '22-03-11', //Utils.stringToDate(property.createdAt!),
                                        size: 14,
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 35,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.visibility, color: Pallet.secondaryColor, size: 14),
                                      const SizedBox(width: 5),
                                      CustomText(
                                        text: '${property.views} views',
                                        size: 14,
                                      )
                                    ],
                                  ),
                                  const SizedBox(width: 35),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      RatingBarIndicator(
                                        rating: property.averageRating ?? 5,
                                        unratedColor: Pallet.whiteColor,
                                        itemBuilder: (context, index) => Icon(
                                          Icons.star,
                                          color: property.averageRating == null ? Colors.black26 : Colors.yellow[900],
                                          size: 18,
                                        ),
                                        itemCount: 5,
                                        itemSize: 18.0,
                                        direction: Axis.horizontal,
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      CustomText(text: (property.numberOfRatingUsers ?? 'No Review').toString(), weight: FontWeight.w200, size: 16),
                                    ],
                                  ),
                                  const SizedBox(width: 24),
                                  Obx(() => SavePropertyIconText(property: property, user: homeCtrl.user.value, state: homeCtrl.savingProperty.value)),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Row(
                                children: [
                                  Image.asset('assets/images/megap.png', height: 18, width: 18),
                                  const CustomText(color: Colors.black, text: 'Flag as inappropriate', weight: FontWeight.w200, size: 13),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: mainPad),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 10,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          CustomText(color: Colors.black, text: property.title, weight: FontWeight.bold, size: 25),
                                          const SizedBox(
                                            width: 40,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 12.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                CustomText(color: Pallet.secondaryColor, text: Utils.amount(property.price!), weight: FontWeight.bold, size: 20),
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 4.0),
                                                  child: CustomText(
                                                      color: Colors.black.withOpacity(0.4),
                                                      text: property.priceDuration!.substring(0, 3) == 'Per' ? property.priceDuration!.toUpperCase() : '',
                                                      weight: FontWeight.w200,
                                                      size: 9),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 30),
                                      Row(
                                        children: [
                                          const Icon(Icons.location_on, color: Pallet.secondaryColor, size: 12),
                                          const SizedBox(width: 12),
                                          CustomText(
                                              color: Colors.black,
                                              text: '${property.location!.address}, ${property.location!.city}, ${property.location!.state}',
                                              weight: FontWeight.w300,
                                              size: 16),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Column(
                                                children: [
                                                  Container(
                                                    height: 20,
                                                    width: 3,
                                                    color: Pallet.secondaryColor,
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              const CustomText(color: Colors.black, text: 'Description', weight: FontWeight.w800, size: 18),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 23.0),
                                            child: ReadMoreText(
                                              '${property.description}',
                                              trimLines: 4,
                                              textAlign: TextAlign.justify,
                                              colorClickableText: Pallet.secondaryColor,
                                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w200, color: Colors.grey[600]),
                                              trimMode: TrimMode.Line,
                                              lessStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w200, color: Pallet.secondaryColor),
                                              trimCollapsedText: '  Read more',
                                              trimExpandedText: '  Read less',
                                              moreStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.normal, color: Pallet.secondaryColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Column(
                                                children: [
                                                  Container(
                                                    height: 20,
                                                    width: 3,
                                                    color: Pallet.secondaryColor,
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              const CustomText(color: Colors.black, text: 'Property Details', weight: FontWeight.w800, size: 18),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          Padding(
                                              padding: const EdgeInsets.only(left: 23.0),
                                              child: Container(
                                                // height: ,
                                                width: Get.width,
                                                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.035),
                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: Colors.grey, width: 0.2)),
                                                child: GridView.builder(
                                                  physics: const BouncingScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount: 12,
                                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 4,
                                                    mainAxisExtent: 78,
                                                  ),
                                                  itemBuilder: (_, index) => Container(
                                                    margin: const EdgeInsets.fromLTRB(20, 28, 20, 0),
                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: Colors.grey, width: 0.2)),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Icon(
                                                          Icons.bed,
                                                          color: Colors.grey.shade500,
                                                          size: 12,
                                                        ),
                                                        CustomText(color: Colors.grey.shade500, text: '3 bedrooms', weight: FontWeight.w200, size: 11),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              )),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Column(
                                                children: [
                                                  Container(
                                                    height: 20,
                                                    width: 3,
                                                    color: Pallet.secondaryColor,
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              const CustomText(color: Colors.black, text: 'Location', weight: FontWeight.w800, size: 18),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 23.0),
                                            child: ReadMoreText(
                                              'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.',
                                              trimLines: 4,
                                              textAlign: TextAlign.justify,
                                              colorClickableText: Pallet.secondaryColor,
                                              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w200, color: Colors.grey[600]),
                                              trimMode: TrimMode.Line,
                                              lessStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w200, color: Pallet.secondaryColor),
                                              trimCollapsedText: '  Read more',
                                              trimExpandedText: '  Read less',
                                              moreStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.normal, color: Pallet.secondaryColor),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Image.asset('assets/images/map.jpeg'),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            children: [
                                              Column(
                                                children: [
                                                  Container(
                                                    height: 20,
                                                    width: 3,
                                                    color: Pallet.secondaryColor,
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              const CustomText(color: Colors.black, text: 'Customer Reviews', weight: FontWeight.w800, size: 18),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          ListTile(
                                            leading: Container(
                                              width: 38,
                                              height: 38,
                                              margin: const EdgeInsets.only(
                                                right: 10,
                                              ),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(48),
                                                child: const FadeInImage(
                                                  image: NetworkImage(
                                                    'https://cdn.pixabay.com/photo/2014/07/09/10/04/man-388104_960_720.jpg',
                                                  ),
                                                  placeholder: AssetImage('assets/images/bedroom2.jpg'),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            title: const CustomText(
                                              size: 12,
                                              color: Colors.black,
                                              weight: FontWeight.bold,
                                              text: 'John Doe',
                                            ),
                                            subtitle: const CustomText(
                                              size: 12,
                                              color: Colors.black,
                                              weight: FontWeight.w500,
                                              text: 'Great Location I am intrested in the property.',
                                            ),
                                            trailing: const CustomText(
                                              size: 12,
                                              color: Colors.black,
                                              weight: FontWeight.w500,
                                              text: '30, oct. 2022',
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 3,
                                          ),
                                          const Divider(
                                            height: 0,
                                          ),
                                          const SizedBox(
                                            height: 3,
                                          ),
                                          ListTile(
                                            leading: Container(
                                              width: 38,
                                              height: 38,
                                              margin: const EdgeInsets.only(
                                                right: 10,
                                              ),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(48),
                                                child: const FadeInImage(
                                                  image: NetworkImage(
                                                    'https://i0.wp.com/www.naijachoice.com.ng/wp-content/uploads/2021/06/is-this-the-most-beautiful-darkest-person-in-the-world-picturesNAIJACHOICEcomng.jpg',
                                                  ),
                                                  placeholder: AssetImage('assets/images/bedroom2.jpg'),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            title: const CustomText(
                                              size: 12,
                                              color: Colors.black,
                                              weight: FontWeight.bold,
                                              text: 'Mary Kay',
                                            ),
                                            subtitle: const CustomText(
                                              size: 12,
                                              color: Colors.black,
                                              weight: FontWeight.w500,
                                              text: 'The property pictures are not clear enough can you retake it please. Thanks.',
                                            ),
                                            trailing: const CustomText(
                                              size: 12,
                                              color: Colors.black,
                                              weight: FontWeight.w500,
                                              text: '10, aug. 2021',
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(left: 60),
                                            child: const CustomText(color: Colors.black, text: 'Add a review', weight: FontWeight.w600, size: 18),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(left: 80),
                                            child: Row(
                                              children: [
                                                const CustomText(color: Colors.black, text: 'Start by rating this property', weight: FontWeight.w200, size: 11),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                Column(
                                                  children: [
                                                    SizedBox(
                                                      child: Column(
                                                        children: [
                                                          RatingBarIndicator(
                                                            rating: 0,
                                                            itemPadding: const EdgeInsets.all(0),
                                                            unratedColor: Colors.grey,
                                                            itemBuilder: (context, index) => Container(
                                                              margin: const EdgeInsets.all(3),
                                                              child: Icon(
                                                                Icons.star,
                                                                color: Colors.yellow[900],
                                                                size: 22,
                                                              ),
                                                            ),
                                                            itemCount: 5,
                                                            itemSize: 28.0,
                                                            direction: Axis.horizontal,
                                                          ),
                                                          const CustomText(
                                                              spacing: 3, color: Colors.black, text: '1    2    3    4    5', weight: FontWeight.w800, size: 8),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: Get.width * 0.4 + 12 + 80,
                                            height: 260,
                                            padding: const EdgeInsets.all(40),
                                            margin: const EdgeInsets.only(left: 40, top: 20),
                                            color: const Color(0xFFf9f9f9),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 42,
                                                  // width: Get.width,
                                                  child: Row(mainAxisSize: MainAxisSize.max, children: [
                                                    SizedBox(
                                                      width: Get.width * 0.2,
                                                      child: UnderlineFormInput(
                                                        controller: TextEditingController(text: ''),
                                                        hint: 'Name',
                                                      ),
                                                    ),
                                                    const SizedBox(width: 12),
                                                    SizedBox(
                                                      width: Get.width * 0.2,
                                                      child: UnderlineFormInput(
                                                        controller: TextEditingController(text: ''),
                                                        hint: 'Email',
                                                      ),
                                                    ),
                                                  ]),
                                                ),
                                                const SizedBox(
                                                  height: 24,
                                                ),
                                                SizedBox(
                                                  width: Get.width * 0.4 + 12,
                                                  child: UnderlineFormInput(
                                                    controller: TextEditingController(text: ''),
                                                    hint: 'Message',
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                FormButton(
                                                  onPressed: () {},
                                                  text: 'submit',
                                                  width: 70,
                                                  height: 36,
                                                  size: 14,
                                                  // color: Colors.white,
                                                  radius: 4,
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  )),
                              Expanded(
                                  flex: 4,
                                  child: Container(
                                    height: 1600,
                                    padding: const EdgeInsets.only(left: 90),
                                    child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(12),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(3),
                                                border: Border.all(
                                                  color: Colors.grey.shade200,
                                                )),
                                            child: Column(
                                              children: [
                                                const CustomText(color: Colors.black, text: 'share via:', weight: FontWeight.w500, size: 16),
                                                const SizedBox(height: 20),
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Image.asset('assets/images/share.png', height: 16, width: 16),
                                                      const SizedBox(width: 6),
                                                      Image.asset('assets/images/facebook1.png', height: 16, width: 16),
                                                      const SizedBox(width: 10),
                                                      Image.asset('assets/images/twitter1.png', height: 20, width: 20),
                                                      const SizedBox(width: 10),
                                                      Image.asset('assets/images/instagram1.png', height: 20, width: 20),
                                                      const SizedBox(width: 10),
                                                      Image.asset('assets/images/whatsapp.png', height: 16, width: 16),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 12),
                                          Container(
                                            padding: const EdgeInsets.all(0),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(3),
                                                border: Border.all(
                                                  color: Colors.grey.shade200,
                                                )),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: double.infinity,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(3), topRight: Radius.circular(3)),
                                                    color: Colors.grey.shade300,
                                                  ),
                                                  child: const Center(
                                                    child: CustomText(color: Colors.black, text: 'AGENT INFORMATION', weight: FontWeight.w700, size: 11),
                                                  ),
                                                ),
                                                const SizedBox(height: 20),
                                                Container(
                                                  width: 42,
                                                  height: 42,
                                                  margin: const EdgeInsets.only(
                                                    right: 0,
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(48),
                                                    child: const FadeInImage(
                                                      image: NetworkImage(
                                                        'https://cdn.pixabay.com/photo/2014/07/09/10/04/man-388104_960_720.jpg',
                                                      ),
                                                      placeholder: AssetImage('assets/images/bedroom2.jpg'),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 20),
                                                CustomText(
                                                    color: Colors.black,
                                                    text: property.user!.isAgent! ? property.user!.agency!.name : '${property.user!.firstName} ${property.user!.surname}',
                                                    weight: FontWeight.w300,
                                                    size: 14),
                                                const SizedBox(
                                                  height: 16,
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    const Flexible(
                                                      child: Icon(
                                                        Icons.phone,
                                                        color: Pallet.secondaryColor,
                                                        size: 12,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 6,
                                                    ),
                                                    Flexible(
                                                      child: CustomText(
                                                          underline: true,
                                                          color: Pallet.secondaryColor,
                                                          text: '${property.user!.phoneNumber}',
                                                          weight: FontWeight.w700,
                                                          size: 11),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: const [
                                                    Flexible(
                                                      child: Icon(
                                                        Icons.mail,
                                                        color: Pallet.secondaryColor,
                                                        size: 12,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 6,
                                                    ),
                                                    Flexible(
                                                      child:
                                                          CustomText(underline: true, color: Pallet.secondaryColor, text: 'send mail', weight: FontWeight.w700, size: 11),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 40,
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(0),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(3),
                                                border: Border.all(
                                                  color: Colors.grey.shade200,
                                                )),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: double.infinity,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(3), topRight: Radius.circular(3)),
                                                    color: Colors.grey.shade300,
                                                  ),
                                                  child: const Center(
                                                    child: CustomText(color: Colors.black, text: 'REQUEST A TOUR', weight: FontWeight.w700, size: 12),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      UnderlineFormInput(
                                                        controller: TextEditingController(text: ''),
                                                        hint: 'Name',
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      SelectUnderlineFormInput(iconColor: Colors.grey, controller: TextEditingController(text: ''), hint: 'Location'),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      UnderlineFormInput(
                                                        controller: TextEditingController(text: ''),
                                                        hint: 'Phone',
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      UnderlineFormInput(
                                                        controller: TextEditingController(text: ''),
                                                        hint: 'Email',
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      UnderlineFormInput(
                                                        controller: TextEditingController(text: ''),
                                                        hint: 'Message',
                                                      ),
                                                      const SizedBox(height: 20),
                                                      SizedBox(
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Transform.scale(
                                                              scale: 0.6,
                                                              child: Checkbox(
                                                                  activeColor: Pallet.secondaryColor,
                                                                  checkColor: Colors.white,
                                                                  side: const BorderSide(color: Colors.white),
                                                                  value: checkState,
                                                                  onChanged: (state) {
                                                                    checkState = state!;
                                                                  }),
                                                            ),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            Flexible(
                                                              child: TextStyles.richTexts(
                                                                  onPress1: () {},
                                                                  onPress2: () {},
                                                                  size: 12,
                                                                  color2: Colors.blueGrey[900],
                                                                  text1: 'By signing up, you agree to our ',
                                                                  text2: ' Terms and Conditions',
                                                                  text3: '',
                                                                  text4: ''),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      FormButton(
                                                        onPressed: () {},
                                                        text: 'send message',
                                                        txtColor: Colors.white,
                                                        // width: do,
                                                        height: 32,
                                                        size: 14,
                                                        radius: 4,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Image.asset('assets/images/banner.png'),
                                          )
                                        ]),
                                  )),
                            ],
                          )),
                      const SizedBox(height: 80),
                      Container(
                        height: 72,
                        color: Pallet.secondaryColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const CustomText(
                                color: Colors.white, text: 'Are you an estate agent or developer? List your property for FREE.', weight: FontWeight.w200, size: 14),
                            const SizedBox(width: 80),
                            Container(
                              height: 35,
                              width: 95,
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.only(left: 8),
                              child: Center(
                                child: CustomText(color: Colors.blueGrey[600], text: 'Register', weight: FontWeight.w500, size: 12),
                              ),
                              color: Pallet.whiteColor,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      pageFooter(),
                    ],
                  ),
                ),
              ),
      );
    });
  }

  void nextPage() {
    _controller.animateToPage(_controller.page!.toInt() + 1, duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
  }

  void previousPage() {
    _controller.animateToPage(_controller.page!.toInt() - 1, duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
  }
}

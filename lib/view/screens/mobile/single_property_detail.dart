import 'dart:io';

import 'package:brixmarket/res/lists.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:readmore/readmore.dart';
import 'package:share_plus/share_plus.dart';

import '../../../config/theme/color.dart';
import '../../../controllers/edit_controller.dart';
import '../../../controllers/home_controller.dart';
import '../../../controllers/instance.dart';
import '../../../controllers/property_controller.dart';
import '../../../core/app.dart';
import '../../../redirect/dynamic_link.dart';
import '../../../res/strings.dart';
import '../../../utils/utils.dart';
import '../../../utils/validations.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/form_inputs.dart';
import '../../widgets/save_property_icon.dart';
import 'explore_page.dart';
import 'package:brixmarket/models/single_property_model.dart';
import 'package:device_info_plus/device_info_plus.dart';

class SinglePropertyDetailPage extends StatefulWidget {
  List<Media> images;
  String title;
  Location location;
  String userImage;
  String propertyId;
  Property property;
  String contact;
  String user;
  String landMark;
  List<Amenity> amenities;
  List<Feature> feature;
  List<Review> review;
  int price;

  SinglePropertyDetailPage(
      {Key? key,
      required this.images,
      required this.property,
      required this.contact,
      required this.title,
      required this.propertyId,
      required this.amenities,
      required this.location,
      required this.price,
      required this.feature,
      required this.user,
      required this.landMark,
      required this.review,
      required this.userImage})
      : super(key: key);

  @override
  State<SinglePropertyDetailPage> createState() =>
      _SinglePropertyDetailPageState();
}

class _SinglePropertyDetailPageState extends State<SinglePropertyDetailPage> {
  int imageNum = 0;
  PageController _controller = PageController();
  bool checkState = true;
  List detailsDescription = [];
  double total_rating = 0;
  double average_rating = 0;

  String deviceId = 'unknown';

  var deviceData = <String, dynamic>{};

  @override
  void initState() {
    EditCtrl.message.clear();
    super.initState();
    if (widget.review.isNotEmpty) {
      for (int i = 0; i < widget.review.length; i++) {
        setState(() {
          total_rating = total_rating + widget.review[i].rating;
        });
      }

      setState(() {
        average_rating = total_rating / widget.review.length;
      });
    }
    Utils.initPlatformState().then((value) => {
          deviceData = value,
          if (Platform.isAndroid)
            {deviceId = deviceData['androidId'] ?? 'unknown'}
          else if (Platform.isIOS)
            {deviceId = deviceData['identifierForVendor'] ?? 'unknown'}
        });

    Future.delayed(const Duration(seconds: 1), () {
      if (HomeController.isLogin.value) {
        PropCtrl.markPropertyAsViewed(widget.propertyId, widget.user);
      } else if (deviceId != 'unknown') {
        PropCtrl.markPropertyAsViewed(widget.propertyId, deviceId);
      }
    });
  }

  _onPageChanged(int index) {
    setState(() {
      imageNum = index;
    });
  }

  _callNumber(phoneNumber) async {
    //set the number here
    await FlutterPhoneDirectCaller.callNumber(phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    _controller = PageController(
      initialPage: 0,
    );
    var details = widget.property.features.map((feature) {
      if(feature.feature.isNotEmpty){

        return Container(
        width: Get.width * 0.9,
        margin: const EdgeInsets.only(bottom: 8),
        child: Row(
          children: [
            const Icon(Icons.control_camera, color: Colors.black54, size: 18),
            const SizedBox(width: 16),
            Expanded(
                child: CustomText(
                    color: Colors.black54,
                    text: feature.feature,
                    weight: FontWeight.w500,
                    size: 16)),
          ],
        ),
      );}else{
         return Container(height:0);
      }
    }).toList();
    var amenities = widget.property.amenities.map((value) {
      if(value.amenity.isNotEmpty){

        return Container(
        width: Get.width * 0.9,
        margin: const EdgeInsets.only(bottom: 8),
        child: Row(
          children: [
            const Icon(Icons.light_outlined, color: Colors.black54, size: 18),
            const SizedBox(width: 16),
            if(value.amenity.isNotEmpty)
            CustomText(
                color: Colors.black54,
                text: value.amenity,
                weight: FontWeight.w500,
                size: 16),
          ],
        ),
      );}else{
        return SizedBox(height: 0,);
      }
    }).toList();
    detailsDescription.add(details);
    detailsDescription.add(amenities);
    detailsDescription.add(productReviews(widget.property, average_rating));
    return Scaffold(
        body: ListView(
          shrinkWrap: true,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: Get.width,
                  child: PageView.builder(
                    itemCount: widget.images.length,
                    controller: _controller,
                    onPageChanged: _onPageChanged,
                    itemBuilder: (BuildContext context, int index) {
                      return Stack(
                        children: [
                          Container(
                            width: Get.width,
                            height: Get.width,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(propertyImgPath +
                                        widget.images[index].media))),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Positioned(
                  top: Get.width * 0.42,
                  left: 25,
                  child: GestureDetector(
                    onTap: () {
                      previousPage();
                    },
                    child: Container(
                      height: 35,
                      width: 35,
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                        size: 15,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Colors.black),
                    ),
                  ),
                ),
                Positioned(
                  top: Get.width * 0.42,
                  right: 25,
                  child: GestureDetector(
                    onTap: () {
                      nextPage();
                    },
                    child: Container(
                      height: 35,
                      width: 35,
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 15,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Colors.black),
                    ),
                  ),
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  right: 20,
                  child: SafeArea(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: const CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.black,
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Obx(() => SaveProperty(
                            property: widget.property,
                            user: propCtrl.user.value,
                            state: homeCtrl.savingProperty.value,
                            color: Colors.white)),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 0,
                  child: SizedBox(
                    width: Get.width,
                    child: Center(
                      child: SizedBox(
                        width: 78,
                        child: Material(
                          type: MaterialType.card,
                          color: Colors.black38,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.camera_enhance,
                                    color: Colors.orange,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 6),
                                  CustomText(
                                    maxLines: 1,
                                    text: imageNum == 0
                                        ? '1/${widget.images.length}'
                                        : '${imageNum + 1}/${widget.images.length}',
                                    color: Colors.orange,
                                    size: 14,
                                    weight: FontWeight.w400,
                                  ),
                                ]),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () => Get.to(() => FullGalleryScreen(
                    index: 1,
                    images: widget.images,
                  )),
              child: const Center(
                child: CustomText(
                    color: Colors.black54,
                    text: 'Tap to view in fullScreen',
                    weight: FontWeight.w700,
                    size: 13),
              ),
            ),
            const SizedBox(height: 20),
            FittedBox(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Center(
                            child: CustomText(
                                color: const Color(0xFF308b85),
                                text: widget.property.type.toUpperCase(),
                                weight: FontWeight.w400,
                                size: 13),
                          ),
                          color: Colors.black12,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          margin: const EdgeInsets.only(left: 8, right: 8),
                          child: Center(
                            child: CustomText(
                                color: Colors.white,
                                text: widget.property.status.toUpperCase(),
                                weight: FontWeight.w400,
                                size: 13),
                          ),
                          color: Pallet.secondaryColor,
                        )
                      ],
                    ),
                    const SizedBox(width: 24),
                    RatingBarIndicator(
                      rating: average_rating,
                      unratedColor: Pallet.grayColor,
                      itemBuilder: (context, index) => Icon(
                        Icons.star,
                        color: average_rating == null
                            ? Colors.black26
                            : Colors.yellow[900],
                        size: 18,
                      ),
                      itemCount: 5,
                      itemSize: 18.0,
                      direction: Axis.horizontal,
                    ),
                    CustomText(
                        text: (widget.property.reviews.length).toString(),
                        weight: FontWeight.w200,
                        size: 14),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: CustomText(
                        color: Colors.black,
                        text: widget.property.title
                            .replaceAll(RegExp('!~`@#\$%^&*()+|[]/?><{}'), ''),
                        weight: FontWeight.w500,
                        size: 18),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Pallet.secondaryColor,
                      ),
                      const SizedBox(width: 4),
                      SizedBox(
                        width: Get.width * 0.8,
                        child: Text(
                          '${widget.property.location.address.replaceAll(RegExp('[!~`@#\$%^&*()+|/?><{}]'), ' ')}, ${widget.property.location.city.replaceAll(RegExp('[!~`@#\$%^&*()+|/?><{}]'), ' ')}, ${widget.property.location.state.replaceAll(RegExp('[!~`@#\$%^&*()+|/?><{}]'), ' ')}',
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 14),
                          // overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(
              thickness: 1,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 45 + 2,
                        backgroundColor: Colors.blueGrey,
                        child: CircleAvatar(
                          radius: 45,
                          backgroundImage: (user.image != null &&
                                  user.image != '')
                              ? NetworkImage(
                                      '$userImgPath${widget.property.user.image}')
                                  as ImageProvider
                              : const AssetImage(ImgStr.avatarImg),
                        ),
                      ),
                      // Container(
                      //   height: 75,
                      //   width: 75,
                      //   decoration:
                      //       BoxDecoration(shape: BoxShape.circle,color: Colors.red, image: DecorationImage(fit: BoxFit.cover, image: NetworkImage('$userImgPath${property.user?.image}'))),
                      // ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Container(
                                  margin:
                                      const EdgeInsets.only(top: 12, right: 24),
                                  child: CustomText(
                                      color: Colors.black,
                                      text: accountName1(
                                          user: widget.property.user),
                                      weight: FontWeight.bold,
                                      size: 16)),
                              widget.property.user.verifiedAgent == 0
                                  ? const SizedBox.shrink()
                                  : const Positioned(
                                      right: 2,
                                      top: 2,
                                      child: Icon(Icons.verified,
                                          color: Colors.green)),
                            ],
                          ),
                          const SizedBox(height: 5),
                          CustomText(
                              color: widget.property.user.verifiedAgent == 0
                                  ? Colors.deepOrangeAccent
                                  : Colors.green,
                              text: (widget.property.user.verifiedAgent == 0
                                      ? 'Not Verified '
                                      : 'Verified ') +
                                  (widget.property.user.isUser == 1
                                      ? 'Property Agent'
                                      : widget.property.user.isAgent == 1
                                          ? 'Realtor/Agent'
                                          : 'Real Estate Agency'),
                              weight: FontWeight.w400,
                              size: 14),
                          const SizedBox(height: 12),
                        ],
                      )
                    ],
                  ),
                  const SizedBox.shrink(),
                ],
              ),
            ),
            const Divider(
              thickness: 1,
            ),
            user.id == widget.property.user.id
                ? const SizedBox.shrink()
                : const SizedBox(height: 24),
            user.id == widget.property.user.id
                ? const SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.only(right: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // Container(
                        //   height: 42,
                        //   width: 42,
                        //   decoration: BoxDecoration(shape: BoxShape.circle, color: Pallet.secondaryColor.withOpacity(0.2)),
                        //   child: OpenUrl(
                        //     url: 'https://wa.me/${property.contact?.phoneNumber}',
                        //     //phone: Str.contactPhone1.replaceAll(' ', ''),
                        //     widget: Icon(
                        //       Icons.whatsapp,
                        //       color: Pallet.secondaryColor,
                        //       size: 20,
                        //     ),
                        //   ),
                        // ),
                        GestureDetector(
                          onTap: () async {
                            showDialog(
                              context: context,
                              builder: (ctx) => const AlertDialog(
                                title: Text("Msg"),
                                content: Text(
                                    "Please wait while link is been generated"),
                                actions: <Widget>[
                                  Center(
                                    child: CircularProgressIndicator(
                                      backgroundColor: Colors.red,
                                      strokeWidth: 3,
                                    ),
                                  )
                                ],
                              ),
                            );

                            String generatedDeepLink =
                                await FirebaseDynamicLinkService
                                    .createDynamicLink(
                              widget.property,
                              widget.images[0].media.toString(),
                              true,
                            );
                            Navigator.pop(context);

                            await Share.share(
                              "Check out this property at brixmarket " +
                                  generatedDeepLink,
                            );
                          },
                          // homeCtrl.shareApp(property: property),
                          child: Container(
                            height: 42,
                            width: 42,
                            child: const Icon(
                              Icons.share,
                              size: 20,
                              color: Pallet.secondaryColor,
                            ),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Pallet.secondaryColor.withOpacity(0.2)),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _callNumber(widget.property.user.phoneNumber);
                          },
                          child: Container(
                            height: 42,
                            width: 42,
                            child: const Icon(
                              Icons.call,
                              size: 20,
                              color: Pallet.secondaryColor,
                            ),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Pallet.secondaryColor.withOpacity(0.2)),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            homeCtrl.loginRequest(
                                request: () =>
                                    homeCtrl.chatWithSeller1(widget.property));
                          },
                          child: Container(
                            height: 42,
                            width: 42,
                            child: const Icon(
                              Icons.wechat,
                              size: 28,
                              color: Pallet.secondaryColor,
                            ),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Pallet.secondaryColor.withOpacity(0.2)),
                          ),
                        ),
                      ],
                    ),
                  ),
            const SizedBox(height: 24),
            const Divider(
              thickness: 1,
              color: Colors.black12,
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: [
                  Container(
                    height: 5,
                    width: 35,
                    color: Pallet.secondaryColor,
                  ),
                  const SizedBox(width: 10),
                  const CustomText(
                      color: Colors.black,
                      text: 'Description',
                      weight: FontWeight.w400,
                      size: 18),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: ReadMoreText(
                '${widget.property.description}',
                trimLines: 9,
                colorClickableText: Colors.pink,
                textAlign: TextAlign.justify,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600]),
                trimMode: TrimMode.Line,
                lessStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Pallet.secondaryColor),
                trimCollapsedText: '  Read more',
                trimExpandedText: '  Read less',
                moreStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Pallet.secondaryColor),
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Container(
                    height: 5,
                    width: 35,
                    color: Pallet.secondaryColor,
                  ),
                  const SizedBox(width: 10),
                  const CustomText(
                      maxLines: 2,
                      color: Colors.black,
                      text: 'Landmarks near this property',
                      weight: FontWeight.w400,
                      size: 18),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: CustomText(
                  maxLines: 2,
                  color: Colors.black,
                  text: widget.property.location.landmarks,
                  //weight: FontWeight.w400,
                  size: 18),
            ),
            const SizedBox(height: 15),
            Container(
              color: const Color(0xFFf9f9f9),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 0),
                      width: double.infinity,
                      color: Colors.white,
                      child: Material(
                        type: MaterialType.card,
                        child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: Lst.propertyDetailTitle.length,
                            itemBuilder: ((context, index) {
                              return Column(
                                children: [
                                  GestureDetector(
                                    onTap: (() {
                                      setState(() {
                                        _handleTap(index);
                                      });
                                    }),
                                    child:
                                    Container(
                                        height: 50,
                                        width: double.infinity,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 0),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border(
                                                bottom: BorderSide(
                                                    color:
                                                        Colors.grey.shade200))),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            active.contains(index)
                                                ? const Icon(
                                                    Icons.remove,
                                                    color:
                                                        Pallet.secondaryColor,
                                                    size: 24,
                                                  )
                                                : const Icon(
                                                    Icons.add,
                                                    color:
                                                        Pallet.secondaryColor,
                                                    size: 24,
                                                  ),
                                            const SizedBox(width: 12),
                                            if (index == 0)
                                              Expanded(
                                                child: CustomText(
                                                  text:
                                                      "${Lst.propertyDetailTitle[0]} (Nearby)",
                                                  size: 18,
                                                  weight: FontWeight.w600,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            if (index != 0)
                                              Expanded(
                                                child: CustomText(
                                                  text: Lst.propertyDetailTitle[
                                                      index],
                                                  size: 18,
                                                  weight: FontWeight.w600,
                                                  color: Colors.black,
                                                ),
                                              ),
                                          ],
                                        )),
                                  ),
                                  Visibility(
                                    visible:
                                        active.contains(index) ? true : false,
                                    child: AnimatedContainer(
                                      width: double.infinity,
                                      duration: const Duration(seconds: 1),
                                      child: Container(
                                          padding: const EdgeInsets.only(
                                              left: 16,
                                              bottom: 24,
                                              top: 24,
                                              right: 8),
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.black.withOpacity(0.005),
                                            border: const Border.symmetric(
                                                horizontal: BorderSide(
                                                    color: Colors.black12)),
                                          ),
                                          child: index == 0 || index == 1
                                              ? Wrap(
                                                  alignment: WrapAlignment
                                                      .spaceBetween,
                                                  children: detailsDescription[
                                                          index] ??
                                                      [],
                                                )
                                              : detailsDescription[index]),
                                    ),
                                  ),
                                ],
                              );
                            })),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 8),
            if (user.id == widget.property.user.id)
              const SizedBox.shrink()
            else
              Align(
                child: Container(
                  padding: const EdgeInsets.only(left: 16),
                  child: GestureDetector(
                    onTap: () => homeCtrl.loginRequest(
                        request: () => writeReview(widget.property.id)),
                    child: const Text(
                      'Write a Review',
                      style: TextStyle(
                          color: Pallet.secondaryColor,
                          decoration: TextDecoration.underline,
                          fontSize: 16),
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 30),
            user.id == widget.property.user.id
                ? const SizedBox.shrink()
                : GestureDetector(
                    onTap: () {
                      EditCtrl.message.clear();
                      flagInappropriate(widget.property.id);
                    },
                    child: Container(
                      height: 50,
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border:
                              Border.all(color: Colors.blueGrey, width: 1.5)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/megap.png',
                              height: 25, width: 25),
                          const SizedBox(width: 10),
                          const CustomText(
                              color: Colors.black,
                              text: 'Flag as inappropriate',
                              weight: FontWeight.w400,
                              size: 14),
                        ],
                      ),
                    ),
                  ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () => homeCtrl.shareApp(),
              child: Container(
                height: 50,
                margin: const EdgeInsets.symmetric(horizontal: 12),
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.blueGrey, width: 1.5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.share,
                      color: Pallet.secondaryColor,
                    ),
                    SizedBox(width: 10),
                    CustomText(
                        color: Colors.black,
                        text: 'Share to a Friend',
                        weight: FontWeight.w400,
                        size: 14),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
              height: 62,
              padding: const EdgeInsets.only(left: 12, right: 12, bottom: 8),
              decoration: const BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.black12))),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const CustomText(
                            color: Colors.blueGrey,
                            text: 'PRICE',
                            weight: FontWeight.bold,
                            size: 14),
                        Row(
                          children: [
                            CustomText(
                                color: Pallet.secondaryColor,
                                text: Utils.amount(widget.property.price),
                                weight: FontWeight.bold,
                                size: 16),
                            const SizedBox(width: 5),
                            widget.property.priceDuration.substring(0, 3) ==
                                    'Per'
                                ? CustomText(
                                    color: Colors.blueGrey,
                                    text: widget.property.priceDuration
                                                .substring(0, 3) ==
                                            'Per'
                                        ? widget.property.priceDuration
                                            .toUpperCase()
                                        : '',
                                    weight: FontWeight.bold,
                                    size: 10)
                                : const SizedBox(height: 8),
                          ],
                        ),
                        const SizedBox(height: 4),
                      ],
                    ),
                  ),
                  user.id == widget.property.user.id
                      ?
                  FormButton(
                          onPressed: () async {
                            showDialog(
                              context: context,
                              builder: (ctx) => const AlertDialog(
                                title: Text("Msg"),
                                content: Text(
                                    "Please wait while link is been generated"),
                                actions: <Widget>[
                                  Center(
                                    child: CircularProgressIndicator(
                                      backgroundColor: Colors.red,
                                      strokeWidth: 3,
                                    ),
                                  )
                                ],
                              ),
                            );

                            String generatedDeepLink =
                                await FirebaseDynamicLinkService
                                    .createDynamicLink(
                              widget.property,
                              widget.images[0].media.toString(),
                              true,
                            );
                            Navigator.pop(context);

                            await Share.share(
                              "Check out this property at brixmarket " +
                                  generatedDeepLink,
                            );
                          },
                          text: 'Share property',
                          width: 140,
                          height: 48,
                          size: 16,
                          radius: 4,
                          top: 12,
                          txtColor: Colors.white,
                        )
                      : const SizedBox(height: 24),
                  user.id == widget.property.user.id
                      ? const SizedBox.shrink()
                      : FormButton(
                          onPressed: () => requestATour(widget.property.id,widget.property.user),
                          text: 'Request Tour',
                          width: 140,
                          height: 48,
                          size: 14,
                          radius: 4,
                          top: 12,
                          txtColor: Colors.white,
                        )
                ],
              )),
        ));
  }

  void nextPage() {
    _controller.animateToPage(_controller.page!.toInt() + 1,
        duration: const Duration(milliseconds: 400), curve: Curves.easeIn);

    setState(() {
      if (imageNum == widget.images.length - 1) {
      } else {
        imageNum = imageNum + 1;
      }
    });
  }

  void previousPage() {
    _controller.animateToPage(_controller.page!.toInt() - 1,
        duration: const Duration(milliseconds: 400), curve: Curves.easeIn);

    setState(() {
      if (imageNum == 0) {
      } else {
        imageNum = imageNum - 1;
      }
    });
  }

  Set active = {};

  void _handleTap(index) {
    setState(() {
      active.contains(index) ? active.remove(index) : active.add(index);
    });
  }

  writeReview(propertyId) {
    showMaterialModalBottomSheet(
      context: Get.context!,
      builder: (context) => SingleChildScrollView(
        controller: ModalScrollController.of(context),
        child: Container(
          height: MediaQuery.of(context).size.height - 120,
          color: Colors.white,
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            children: [
              const CustomText(
                color: Colors.blueGrey,
                size: 18,
                weight: FontWeight.w600,
                text: 'Review this Property',
              ),
              const SizedBox(height: 16),
              Center(
                child: RatingBar.builder(
                  minRating: 1,
                  itemCount: 5,
                  itemSize: 32,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) =>
                      const Icon(Icons.star, color: Colors.amber),
                  onRatingUpdate: (rating) {
                    EditCtrl.rating.text = rating.toInt().toString();
                  },
                ),
              ),
              const SizedBox(height: 8),
              FormInput(
                controller: EditCtrl.messageReview,
                validate: Val.name,
                error: EditCtrl.messageErr,
                height: 164,
                maxLines: 8,
                width: double.infinity,
                label: 'Review text',
                hint: 'Write your review...',
              ),
              FormButton(
                onPressed: () => propCtrl.submitPropertyReviewMobile(
                    propertyId, widget.property,widget.property.user),
                text: 'Submit',
                width: double.infinity,
                height: 48,
                size: 16,
                radius: 4,
                top: 12,
                txtColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget productReviews(Property property, double averageRating) {
  List<Review>? reviews = property.reviews;
  return (reviews == [])
      ? const Text(
          'No review for this property',
          style: TextStyle(fontSize: 16),
        )
      : Column(
          children: [
            ...(reviews.map((e) {
              return e.message == ''
                  ? const SizedBox.shrink()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RatingBarIndicator(
                              rating: e.rating.toDouble(),
                              unratedColor: Pallet.grayColor,
                              itemBuilder: (context, index) => Icon(
                                Icons.star,
                                color: averageRating == null
                                    ? Colors.black26
                                    : Colors.yellow[900],
                                size: 18,
                              ),
                              itemCount: 5,
                              itemSize: 18.0,
                              direction: Axis.horizontal,
                            ),
                            Text(
                              e.createdAt.toString(),
                              style: const TextStyle(color: Colors.black54),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(e.message),
                        const SizedBox(height: 24),
                      ],
                    );
            }).toList()),
          ],
        );
}

flagInappropriate(propertyId) {
  showMaterialModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: Get.context!,
    builder: (context) => SingleChildScrollView(
      controller: ModalScrollController.of(context),
      child: Container(
        height: MediaQuery.of(context).size.height - 70,
        child: Align(
          alignment: Alignment.topRight,
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(16, 15, 16, 0),
            constraints: const BoxConstraints(maxWidth: 480),
            child: Column(
              children: [
                const CustomText(
                  color: Colors.blueGrey,
                  size: 18,
                  weight: FontWeight.w600,
                  text: 'Flag as Inappropriate',
                ),
                const SizedBox(height: 10),
                FormInput(
                  value: isLogin ? accountName(user: user) : '',
                  width: double.infinity,
                  controller: EditCtrl.name,
                  error: EditCtrl.nameErr,
                  validate: Val.name,
                  label: 'Name',
                  hint: 'Enter full Name',
                ),
                const SizedBox(height: 10),
                FormInput(
                  value: isLogin ? user.emailAddress : '',
                  width: double.infinity,
                  controller: EditCtrl.email,
                  error: EditCtrl.emailErr,
                  validate: Val.email,
                  label: 'Email',
                  hint: 'Enter Email',
                ),
                const SizedBox(height: 10),
                FormInput(
                  value: isLogin &&
                          user.phoneNumber != null &&
                          user.phoneNumber != ''
                      ? user.phoneNumber
                      : '',
                  controller: EditCtrl.phone,
                  error: EditCtrl.phoneErr,
                  validate: Val.phone,
                  width: double.infinity,
                  label: 'Phone number',
                  hint: 'Enter Phone number',
                ),
                const SizedBox(height: 10),
                FormInput(
                  controller: EditCtrl.message,
                  validate: Val.name,
                  error: EditCtrl.messageErr,
                  height: 164,
                  maxLines: 8,
                  width: double.infinity,
                  label: 'Message',
                  hint: 'Enter message',
                ),
                FormButton(
                  onPressed: () => propCtrl.submitFlagInappropriate(propertyId),
                  text: 'Submit',
                  width: double.infinity,
                  height: 48,
                  size: 16,
                  radius: 4,
                  top: 12,
                  txtColor: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

requestATour(propertyId,propertyUserId) {
  showMaterialModalBottomSheet(
    context: Get.context!,
    builder: (context) => SingleChildScrollView(
      controller: ModalScrollController.of(context),
      child: Container(
        height: MediaQuery.of(context).size.height - 70,
        color: Colors.white,
        padding: const EdgeInsets.fromLTRB(16, 15, 16, 0),
        child: Column(
          children: [
            const CustomText(
              color: Colors.blueGrey,
              size: 18,
              weight: FontWeight.w600,
              text: 'Request for a tour',
            ),
            const SizedBox(height: 10),
            FormInput(
              value: isLogin ? accountName(user: user) : '',
              width: double.infinity,
              controller: EditCtrl.name,
              error: EditCtrl.nameErr,
              validate: Val.name,
              label: 'Name',
              hint: 'Enter full Name',
            ),
            const SizedBox(height: 10),
            FormInput(
              value: isLogin ? user.emailAddress : '',
              width: double.infinity,
              controller: EditCtrl.email,
              error: EditCtrl.emailErr,
              validate: Val.email,
              label: 'Email',
              hint: 'Enter Email',
            ),
            const SizedBox(height: 10),
            FormInput(
              value:
                  isLogin && user.phoneNumber != null && user.phoneNumber != ''
                      ? user.phoneNumber
                      : '',
              controller: EditCtrl.phone,
              error: EditCtrl.phoneErr,
              validate: Val.phone,
              width: double.infinity,
              label: 'Phone number',
              hint: 'Enter Phone number',
            ),
            const SizedBox(height: 10),
            FormInput(
              controller: EditCtrl.messageTour,
              validate: Val.name,
              error: EditCtrl.messageErr,
              height: 164,
              maxLines: 8,
              width: double.infinity,
              label: 'Message',
              hint: 'Enter message',
            ),
            FormButton(
              onPressed: () => propCtrl.submitRequestATour(propertyId,propertyUserId),
              text: 'Submit',
              width: double.infinity,
              height: 48,
              size: 16,
              radius: 4,
              top: 12,
              txtColor: Colors.white,
            ),
          ],
        ),
      ),
    ),
  );
}

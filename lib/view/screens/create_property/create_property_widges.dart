import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../config/theme/color.dart';
import '../../../controllers/edit_controller.dart';
import '../../../controllers/instance.dart';
import '../../../models/property_model.dart';
import '../../../res/lists.dart';
import '../../../services/provider.dart';
import '../../../utils/utils.dart';
import '../../../utils/validations.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/drop_down.dart';
import '../../widgets/form_button.dart';
import '../../widgets/form_inputs.dart';

class CreatePropertyWidget extends StatelessWidget {
  const CreatePropertyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double dashPadding = Get.width * 0.05;
    return Container(
      height: Get.height,
      width: double.infinity,
      margin: const EdgeInsets.only(top: 0),
      color: Colors.white,
      child: Scrollbar(
        controller: cPropCtrl.createPropScrollCtrl,
        isAlwaysShown: true,
        interactive: true,
        child: ListView(
          shrinkWrap: true,
          controller: cPropCtrl.createPropScrollCtrl,
          padding: EdgeInsets.fromLTRB(dashPadding, 0, dashPadding, 0),
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: CustomText(
                text: 'Create List',
                color: Colors.black,
                weight: FontWeight.bold,
                size: 18,
              ),
            ),
            const Divider(color: Colors.black26),
            const SizedBox(height: 24),
            buildStepNumber(),
            const SizedBox(
              height: 32,
            ),
            SizedBox(
              height: 860,
              child: PageView(
                controller: cPropCtrl.cPPageController,
                physics: const NeverScrollableScrollPhysics(),
                children: <Widget>[
                  createPropertyDetails(),
                  createPropertyMedia(),
                  createPropertyLocation(),
                  createPropertyMorDetails(),
                  createPropertyAmenities(),
                  createPropertyContact(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget stepWidget(int i) {
  double screenWidth = Get.width;
  return Obx(
    () => Flexible(
      flex: cPropCtrl.createPropPageIndex.value == i && (screenWidth > 430)
          ? screenWidth < 980
              ? 7
              : 3
          : 2,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(color: (cPropCtrl.createPropPageIndex.value >= i) ? Pallet.secondaryColor : Colors.grey, borderRadius: BorderRadius.circular(50)),
            child: Center(
              child: CustomText(color: Colors.white, size: 14, textAlign: TextAlign.center, weight: FontWeight.w500, text: '${i + 1}'),
            ), //Icon(stepItems[i]['icon'], color: Colors.white, size: 16),
          ),
          // ),
          (screenWidth <= 430 || cPropCtrl.createPropPageIndex.value != i && screenWidth < 1260)
              ? Container()
              : Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: CustomText(
                      color: (cPropCtrl.createPropPageIndex.value >= i) ? Pallet.secondaryColor : Colors.grey.shade500,
                      size: 14,
                      textAlign: TextAlign.center,
                      weight: FontWeight.w100,
                      text: Lst.stepItems[i].label),
                ),
          (screenWidth > 430 && cPropCtrl.createPropPageIndex.value == i || screenWidth > 780) ? const SizedBox(width: 4) : const SizedBox.shrink(),
          (screenWidth > 430 && cPropCtrl.createPropPageIndex.value == i || screenWidth > 780)
              ? Expanded(
                  flex: 4,
                  child: Container(
                    margin: const EdgeInsets.only(top: 6),
                    color: (cPropCtrl.createPropPageIndex.value >= i) ? Pallet.secondaryColor : Colors.grey,
                    height: 3,
                  ),
                )
              : const SizedBox.shrink(),
          i == 5 && screenWidth < 780 ? const SizedBox.shrink() : const SizedBox(width: 12),
        ],
      ),
    ),
  );
}

Widget buildStepNumber() {
  return SizedBox(
    width: double.infinity,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [stepWidget(0), stepWidget(1), stepWidget(2), stepWidget(3), stepWidget(4), stepWidget(5)],
    ),
  );
}

Widget buttonRow(Function() nextFunction) {
  return Padding(
    padding: const EdgeInsets.only(
      top: 8.0,
      right: 0,
      bottom: 8,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Obx(() => Flexible(
              child: FormButton(
                width: 100,
                bgColor: Pallet.secondaryColor,
                disableButton: cPropCtrl.createPropPageIndex.value < 1,
                text: 'Previous',
                onPressed: cPropCtrl.backToPrevious,
              ),
            )),
        const SizedBox(
          width: 10,
        ),
        Flexible(
          child: FormBorderButton(
            width: 120,
            bgColor: Colors.white,
            txtColor: Colors.black,
            text: 'Save as draft',
            onPressed: () {
              cPropCtrl.saveToDraft = true;
              nextFunction();
            },
          ),
        ),
        const SizedBox(width: 10),
        Obx(() => Flexible(
              child: FormButton(
                width: 100,
                text: (cPropCtrl.createPropPageIndex.value == 6) ? 'Finish' : 'Next',
                onPressed: nextFunction,
              ),
            )),
      ],
    ),
  );
}

Widget createPropertyDetails() {
  EditCtrl.reference.text = EditCtrl.reference.text == '' ? Utils.generateId() : EditCtrl.reference.text;
  return Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(
          text: 'Property Description',
          color: Colors.black,
          size: 18,
          weight: FontWeight.bold,
        ),
        const SizedBox(
          height: 16,
        ),
        SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Flexible(
                child: FormInput(
                  width: double.infinity,
                  controller: EditCtrl.title,
                  validate: Val.name,
                  error: EditCtrl.titleErr,
                  label: 'Title',
                  hint: 'Enter title of the List',
                ),
              ),
              // SizedBox(width: Get.width * 0.02),
              // Flexible(
              //   child: FormInput(
              //     width: double.infinity,
              //     controller: EditCtrl.reference,
              //     label: 'Property Id',
              //     isEnabled: true,
              //     hint: 'Enter property ID',
              //   ),
              // ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        FormInput(
          height: 100,
          maxLines: 8,
          width: double.infinity,
          controller: EditCtrl.description,
          validate: Val.name,
          error: EditCtrl.descriptionErr,
          label: 'Property Description',
          hint: 'Enter Description',
        ),
        const SizedBox(height: 24),
        const CustomText(
          text: 'Price',
          color: Colors.black,
          size: 16,
          weight: FontWeight.bold,
        ),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Flexible(
                child: FormInput(
                  inputType: TextInputType.number,
                  width: double.infinity,
                  controller: EditCtrl.price,
                  validate: Val.number,
                  error: EditCtrl.priceErr,
                  label: 'Property Price',
                  hint: 'Enter price',
                ),
              ),
              SizedBox(
                width: Get.width * 0.02,
              ),
              Flexible(
                child: DropDown(
                  label: 'Price Duration',
                  items: Lst.priceDurations,
                  controller: EditCtrl.priceDuration,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const CustomText(
          text: 'Category',
          color: Colors.black,
          size: 16,
          weight: FontWeight.bold,
        ),
        const SizedBox(
          height: 8,
        ),
        Visibility(
          visible: Get.width > 640 ? true : false,
          child: SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Flexible(
                  child: DropDown(
                    controller: EditCtrl.category,
                    label: 'Property Category',
                    items: Lst.propertyCategories,
                  ),
                ),
                SizedBox(
                  width: Get.width * 0.02,
                ),
                Flexible(
                  child: DropDown(
                    controller: EditCtrl.type,
                    label: 'Type',
                    items: Lst.propertyTypes,
                  ),
                ),
                SizedBox(
                  width: Get.width * 0.02,
                ),
                Flexible(
                  child: DropDown(
                    controller: EditCtrl.status,
                    label: 'New or Existing',
                    items: Lst.propertyStatus,
                  ),
                ),
              ],
            ),
          ),
        ),
        Visibility(
          visible: Get.width <= 640 ? true : false,
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                DropDown(
                  controller: EditCtrl.category,
                  label: 'Property Category',
                  items: Lst.propertyCategories,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Flexible(
                      child: DropDown(
                        controller: EditCtrl.type,
                        label: 'Type',
                        items: Lst.propertyTypes,
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.02,
                    ),
                    Flexible(
                      child: DropDown(
                        controller: EditCtrl.status,
                        label: 'New or Existing',
                        items: Lst.propertyStatus,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        buttonRow(cPropCtrl.submitPropertyDescription),
      ],
    ),
  );
}

Widget createPropertyMedia() {
  return Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(
          text: 'Media',
          color: Colors.black,
          size: 16,
          weight: FontWeight.bold,
        ),
        const SizedBox(height: 12),
        const CustomText(
          text: '      • Each picture must not exceed 5 Mb',
          color: Colors.black,
          size: 12,
          weight: FontWeight.w100,
        ),
        const SizedBox(height: 5),
        const CustomText(
          text: '      • Supported formats are *.jpg, *.gif, *png',
          color: Colors.black,
          size: 14,
          weight: FontWeight.w300,
        ),
        const SizedBox(height: 5),
        const CustomText(
          text: '      • Advert must contain from 2 to 20 images',
          color: Colors.black,
          size: 14,
          weight: FontWeight.w300,
        ),
        const SizedBox(height: 32),
        SizedBox(
          child: Obx(() => Wrap(children: [
                ...EditCtrl.image8Lists.value
                    .map(
                      (file) => Stack(
                        children: [
                          Container(
                            width: 95,
                            height: 95,
                            margin: const EdgeInsets.only(top: 8, right: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.black12,
                              image: DecorationImage(image: MemoryImage(file), fit: BoxFit.cover),
                            ),
                          ),
                          Positioned(
                            right: 2,
                            top: 2,
                            child: InkWell(
                              onTap: () => cPropCtrl.removeImage(file),
                              child: Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(12)),
                                child: const Icon(Icons.close, color: Colors.white, size: 10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList(),
                InkWell(
                  onTap: cPropCtrl.selectPropertyImages,
                  child: Container(
                    height: 95,
                    width: 198,
                    margin: const EdgeInsets.only(top: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color(0xFFDDDDDD),
                      boxShadow: const [BoxShadow(color: Colors.black38, spreadRadius: 1, blurRadius: 5, offset: Offset(0, 3))],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(Icons.add_a_photo, size: 24, color: Pallet.secondaryColor),
                        const SizedBox(height: 4),
                        Obx(() => Text(
                              EditCtrl.image8Lists.isEmpty ? 'Upload your mages' : 'Upload MORE images',
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontWeight: FontWeight.w600),
                            )),
                        const SizedBox(height: 4),
                        const Text(
                          'Browse images',
                          style: TextStyle(color: Pallet.secondaryColor, decoration: TextDecoration.underline),
                        ),
                      ],
                    ),
                  ),
                ),
              ])),
        ),
        const SizedBox(height: 24),
        const CustomText(
          text: 'Thumbnail or Title Image',
          color: Colors.black,
          size: 14,
          weight: FontWeight.w600,
        ),
        const SizedBox(height: 12),
        const CustomText(
          text: '      • Add at least two photos for this category',
          color: Colors.black,
          size: 14,
          weight: FontWeight.w300,
        ),
        const SizedBox(height: 5),
        const CustomText(
          text: '      • First picture is the Title picture. Grab and Drag to chage the order of photos',
          color: Colors.black,
          size: 14,
          weight: FontWeight.w300,
        ),
        const SizedBox(height: 15),
        const SizedBox(height: 16),
        buttonRow(cPropCtrl.submitPropertyMedia),
      ],
    ),
  );
}

Widget createPropertyLocation() {
  return Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(
          text: 'Details',
          color: Colors.black,
          size: 16,
          weight: FontWeight.bold,
        ),
        const SizedBox(
          height: 24,
        ),
        SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Flexible(
                child: FormInput(
                  width: double.infinity,
                  controller: EditCtrl.address,
                  validate: Val.name,
                  error: EditCtrl.addressErr,
                  label: 'Address',
                  hint: 'Enter address',
                ),
              ),
              SizedBox(width: Get.width * 0.02),
              Flexible(
                child: DropDown(
                  controller: EditCtrl.state,
                  label: 'State',
                  items: Lst.ngStates,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Flexible(
                child: Obx(
                  () => DropDown(
                    controller: EditCtrl.city,
                    label: 'City/Town',
                    items: Lst.ngLGA[EditCtrl.state.value.text] ?? [],
                  ),
                ),
              ),
              SizedBox(width: Get.width * 0.02),
              Flexible(
                child: DropDown(
                  controller: EditCtrl.landmarks,
                  label: 'Landmarks',
                  items: Lst.ngLGA[Lst.ngStates[0]] ?? [],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        // const CustomText(
        //   text: 'Google Map (Optional)',
        //   color: Colors.black,
        //   size: 16,
        //   weight: FontWeight.bold,
        // ),
        // const SizedBox(
        //   height: 20,
        // ),
        // SizedBox(
        //   width: double.infinity,
        //   child: Row(
        //     children: [
        //       Flexible(
        //         child: FormInput(
        //           width: double.infinity,
        //           controller: EditCtrl.latitude,
        //           label: 'Latitude',
        //           hint: 'Enter location Latitude',
        //         ),
        //       ),
        //       SizedBox(width: Get.width * 0.02),
        //       Flexible(
        //         child: FormInput(
        //           width: double.infinity,
        //           controller: EditCtrl.longitude,
        //           label: 'Longitude',
        //           hint: 'Enter location Longitude',
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        // const SizedBox(
        //   height: 32,
        // ),
        // Image.asset('assets/images/map.jpeg'),
        const SizedBox(height: 16),
        buttonRow(cPropCtrl.submitPropertyLocation),
      ],
    ),
  );
}

List? features;
Future getFeatures() async {
  features ??= [];
  if (features!.isEmpty && EditCtrl.category.value.text.isNotEmpty) {
    await Provider().postData("property/get-features/${EditCtrl.category.value.text}", Property.map()).then((value) => features = value);
  }
  return features;
}

Widget createPropertyMorDetails() {
  return Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(text: 'More Details', color: Colors.black, size: 16, weight: FontWeight.bold),
        const SizedBox(height: 40),
        SizedBox(
          width: double.infinity,
          child: FutureBuilder(
              future: getFeatures(),
              builder: (context, AsyncSnapshot snap) {
                var featuresData = snap.data ?? [];
                var features = {};
                featuresData.forEach((e) {
                  if (features[e['feature']] == null) {
                    features[e['feature']] = [e['feature_value'].toString()];
                  } else {
                    features[e['feature']].add(e['feature_value'].toString());
                  }
                });
                var initialList = [];
                if (featuresData.isNotEmpty) {
                  initialList = EditCtrl.ctrlList;
                  EditCtrl.ctrlList = [];
                }
                int i = -1;
                return Wrap(
                  children: [
                    ...features.entries.map((feature) {
                      EditCtrl.ctrlList.add(TextEditingController().obs);
                      EditCtrl.ctrlListKeys.add(TextEditingController(text: feature.key));
                      i++;
                      if ((feature.value[0] ?? '').isEmpty) {
                        return Container(
                          padding: EdgeInsets.only(right: Get.width * 0.01, bottom: 24),
                          width: Get.width < 480 ? double.infinity : Get.width * 0.31,
                          child: FormInput(
                            width: double.infinity,
                            controller: EditCtrl.ctrlList[i].value,
                            label: feature.key,
                            hint: 'Enter ${feature.key}',
                            value: initialList.isEmpty ? '' : initialList[i].value.text,
                          ),
                        );
                      } else {
                        return Container(
                          padding: EdgeInsets.only(right: Get.width * 0.01, bottom: 24),
                          width: Get.width < 480 ? double.infinity : Get.width * 0.31,
                          child: SizedBox(
                            child: DropDown(
                              initialValue: initialList.isEmpty ? '' : initialList[i].value.text,
                              controller: EditCtrl.ctrlList[i],
                              label: feature.key,
                              items: feature.value as List<String>,
                            ),
                          ),
                        );
                      }
                    }).toList(),
                  ],
                );
              }),
        ),
        buttonRow(cPropCtrl.submitPropertyMoreDetails),
        const SizedBox(
          height: 40,
        ),
      ],
    ),
  );
}

Widget createPropertyAmenities() {
  return Container(
    color: Colors.white,
    child: SizedBox(
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(text: 'Basic Amenities', color: Colors.black, size: 16, weight: FontWeight.bold),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: FutureBuilder(
                  future: cPropCtrl.getAmenities(),
                  builder: (context, AsyncSnapshot snap) {
                    var amenities = snap.data ?? [];

                    return GridView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(right: 24),
                        physics: const BouncingScrollPhysics(),
                        itemCount: amenities.length,
                        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                          mainAxisExtent: 54,
                          maxCrossAxisExtent: 260,
                        ),
                        itemBuilder: (_, i) {
                          var amenity = amenities[i]['amenity'];

                          return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                            Transform.scale(
                              scale: 0.7,
                              child: Obx(
                                () => Checkbox(
                                  activeColor: Pallet.secondaryColor,
                                  checkColor: Colors.white,
                                  side: const BorderSide(color: Colors.black54),
                                  value: EditCtrl.amenities.contains(amenity),
                                  onChanged: (state) {
                                    if (EditCtrl.amenities.contains(amenity)) {
                                      EditCtrl.amenities.remove(amenity);
                                    } else {
                                      EditCtrl.amenities.add(amenity);
                                      EditCtrl.amenities.refresh();
                                    }
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(child: Text(amenity, style: const TextStyle(fontSize: 16))),
                          ]);
                        });
                  }),
            ),
            buttonRow(cPropCtrl.submitPropertyAmenities),
          ],
        )),
  );
}

Widget createPropertyContact() {
  return Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(
          text: 'Contact Info',
          color: Colors.black,
          size: 16,
          weight: FontWeight.bold,
        ),
        const SizedBox(
          height: 40,
        ),
        SizedBox(
          child: FormInput(
            inputType: TextInputType.emailAddress,
            width: double.infinity,
            controller: EditCtrl.email,
            validate: Val.email,
            error: EditCtrl.emailErr,
            label: 'Email',
            hint: 'Enter email',
            value: user.emailAddress ?? '',
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Flexible(
                child: FormInput(
                  inputType: TextInputType.phone,
                  width: double.infinity,
                  controller: EditCtrl.whatsAppNumber,
                  validate: Val.phone,
                  error: EditCtrl.whatsAppPhoneErr,
                  label: 'WhatsApp number',
                  hint: 'WhatsApp number',
                  value: user.phoneNumber ?? '',
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              Flexible(
                child: FormInput(
                  inputType: TextInputType.phone,
                  width: double.infinity,
                  controller: EditCtrl.phone,
                  validate: Val.phone,
                  error: EditCtrl.phoneErr,
                  label: 'Phone number',
                  hint: 'Enter phone number',
                  value: user.phoneNumber ?? '',
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          child: FormInput(
            width: double.infinity,
            controller: EditCtrl.userAddress,
            label: 'Contact Address',
            hint: 'Enter contact address ',
            value: user.isAgent ?? false ? (user.agency!.address ?? '') : (user.premiumDetails != null ? user.premiumDetails!.address ?? '' : ''),
          ),
        ),
        buttonRow(cPropCtrl.submitPropertyContact),
      ],
    ),
  );
}

import 'package:brixmarket/config/theme/color.dart';
import 'package:brixmarket/controllers/edit_controller.dart';
import 'package:brixmarket/controllers/flag_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../widgets/custom_text.dart';
import '../widgets/drop_down.dart';
import '../widgets/form_button.dart';
import '../widgets/form_inputs.dart';

class FlagPage extends GetView<FlagController> {
  const FlagPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        backgroundColor: Pallet.homeBackground,
        body: (constraints.maxWidth <= 1136)
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
            : Align(
                alignment: Alignment.center,
                child: Container(
                    width: 35.w,
                    height: 2000,
                    margin: EdgeInsets.symmetric(horizontal: 0.h, vertical: 6.h),
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 22),
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const CustomText(
                                text: 'Reporting Listing',
                                size: 12,
                                color: Colors.black,
                                weight: FontWeight.w400,
                              ),
                              Row(
                                children: [
                                  const CustomText(
                                    text: 'REF ID-548765478',
                                    size: 11,
                                    color: Pallet.secondaryColor,
                                    weight: FontWeight.w400,
                                  ),
                                  const SizedBox(
                                    width: 50,
                                  ),
                                  Container(
                                      padding: const EdgeInsets.all(2),
                                      decoration: BoxDecoration(color: Colors.grey.shade100, shape: BoxShape.rectangle),
                                      child: const Icon(
                                        Icons.close,
                                        color: Colors.black54,
                                        size: 12,
                                      ))
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 50),
                          Obx(() {
                            return DropDown(
                              label: 'Report',
                              items: const ['Fraudlent activity', 'Property theft', 'Others '],
                              controller: EditCtrl.email,
                              //title: 'title',
                            );
                          }),
                          const SizedBox(height: 20),
                          FormInput(
                            width: double.infinity,
                            controller: TextEditingController(text: ''),
                            label: 'Name',
                            hint: 'Enter full Name',
                          ),
                          const SizedBox(height: 20),
                          FormInput(
                            width: double.infinity,
                            controller: TextEditingController(text: ''),
                            label: 'Email',
                            hint: 'Enter email address',
                          ),
                          const SizedBox(height: 30),
                          FormInput(
                            height: 100,
                            maxLines: 8,
                            width: double.infinity,
                            controller: TextEditingController(text: ''),
                            label: 'Comments',
                            hint: 'Enter message',
                          ),
                          const SizedBox(height: 20),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: FormIconButton(
                              width: 120,
                              height: 30,
                              onPressed: () {},
                              fontSize: 9,
                              text: 'Report Listing',
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
      );
    });
  }
}

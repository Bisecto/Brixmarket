import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/theme/color.dart';
import '../../controllers/instance.dart';
import '../../res/strings.dart';
import 'custom_text.dart';

class EditCreatNavbar extends StatelessWidget {
  const EditCreatNavbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.080,
      width: double.infinity,
      child: Material(
        elevation: 10,
        type: MaterialType.card,
        child: Padding(
          padding: EdgeInsets.only(left: 16.0, right: Get.width * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                InkWell(
                    splashColor: Colors.transparent,
                    onTap: () {
                      Get.toNamed(RouteStr.webHome);
                    },
                    child: Image.asset('assets/images/logo2.png')),
                const SizedBox(
                  width: 50,
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  onTap: () => Get.back(),
                  child: const Icon(
                    Icons.arrow_back_ios,
                    size: 14,
                    color: Colors.black54,
                  ),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  onTap: () => Get.back(),
                  child: const CustomText(
                    text: 'Back',
                    color: Color.fromARGB(255, 34, 33, 33),
                    size: 14,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const CustomText(
                  text: ' | ',
                  color: Colors.black,
                  weight: FontWeight.w100,
                  size: 14,
                ),
                const InkWell(
                  child: CustomText(
                    text: 'Board / ',
                    color: Color.fromARGB(255, 150, 150, 150),
                    size: 14,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const InkWell(
                  child: CustomText(
                    text: 'Create List',
                    size: 13,
                    color: Color.fromARGB(255, 24, 23, 23),
                  ),
                ),
              ]),
              Row(
                children: [
                  Stack(
                    children: [
                      const Icon(
                        Icons.notifications_active_outlined,
                        size: 24,
                      ),
                      Positioned(
                        top: 0,
                        right: 1,
                        child: Container(
                          height: 14,
                          width: 14,
                          decoration: const BoxDecoration(color: Pallet.secondaryColor, shape: BoxShape.circle),
                          child: const Center(
                            child: InkWell(
                              child: CustomText(
                                text: '5+',
                                textAlign: TextAlign.center,
                                weight: FontWeight.bold,
                                color: Colors.black,
                                size: 9,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 35,
                  ),
                  InkWell(
                    child: Container(
                      width: 32,
                      height: 32,
                      margin: const EdgeInsets.only(
                        right: 10,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(48),
                        child: const FadeInImage(
                          image: NetworkImage(
                            'https://cdn.pixabay.com/photo/2014/07/09/10/04/man-388104_960_720.jpg',
                          ),
                          placeholder: AssetImage('assets/images/person.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 0,
                  ),
                  CustomText(
                    text: 'Hello, ${homeCtrl.user.value.firstName}!',
                    color: Colors.black,
                    size: 16,
                    weight: FontWeight.w600,
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  const InkWell(
                    child: Icon(
                      Icons.arrow_drop_down,
                      size: 20,
                      color: Color.fromARGB(255, 37, 35, 35),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

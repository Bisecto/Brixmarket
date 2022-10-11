import 'package:brixmarket/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/theme/color.dart';
import '../../../controllers/edit_controller.dart';
import '../../../controllers/instance.dart';
import '../../../res/lists.dart';
import '../../../res/strings.dart';
import '../../../utils/validations.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/drop_down.dart';
import '../../widgets/form_button.dart';
import '../../widgets/form_inputs.dart';
import '../mobile/notifications_page.dart';
import '../mobile/privacy_security_page.dart';
import '../mobile/profiling_page.dart';

class AccountWidget extends StatelessWidget {
  final double? constraints;
  const AccountWidget({Key? key, this.constraints}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: Get.height * 0.85,
        width: double.infinity,
        margin: const EdgeInsets.only(top: 0),
        // padding: (constraints! <= 1108)
        //     ? const EdgeInsets.fromLTRB(30, 0, 50, 0)
        //     : const EdgeInsets.fromLTRB(30, 0, 150, 0),
        child: SizedBox(
          // controller: cPropCtrl.scrollController6,
          // isAlwaysShown: true,
          // interactive: true,
          child: Obx(() => IndexedStack(
                index: cPropCtrl.accountIndex.value,
                children: [
                  baseCard(const SizedBox()),
                  baseCard(personalInfo(), title: Lst.accountCards[1].title),
                  if (user.isUser == false) baseCard(agencyInfoWidget(), title: Lst.accountCards[2].title),
                  if (user.isUser == false) baseCard(legalDocumentInfo(), title: Lst.accountCards[3].title),
                  baseCard(locationInfo(), title: Lst.accountCards[4].title),
                  if (user.isUser == true) baseCard(identityInfo(), title: Lst.accountCards[5].title),
                  baseCard(notificationSettingsInfo(), title: Lst.accountCards[6].title),
                  baseCard(changePassword(), title: Lst.accountCards[7].title),
                  // baseCard(financialInfo(), title: Lst.accountCards[5].title),
                ],
              )),
        ));
  }
}

baseCard(Widget item, {String? title}) {
  accountCards = [
    accountCard(1, 1),
    if (user.isUser == false) accountCard(2, 2),
    if (user.isUser == false) accountCard(3, 3),
    accountCard(4, user.isUser == true ? 2 : 4),
    if (user.isUser == true) accountCard(5, 3),
    accountCard(6, user.isUser == true ? 4 : 5),
    accountCard(7, user.isUser == true ? 5 : 5),
  ];
  double dashPadding = Get.width * 0.033;
  return ListView(
    shrinkWrap: true,
    // controller: cPropCtrl.scrollController6a,
    padding: EdgeInsets.symmetric(horizontal: dashPadding),
    children: [
      const SizedBox(height: 24),
      Material(
        type: MaterialType.card,
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.all(dashPadding + 4),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            title == null
                ? Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: const CustomText(
                      text: 'Account settings',
                      color: Colors.black,
                      weight: FontWeight.bold,
                      size: 18,
                    ),
                  )
                : Row(
                    children: [
                      InkWell(
                        hoverColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () => cPropCtrl.accountIndex.value = 0,
                        radius: 30,
                        child: Container(
                          height: 28,
                          width: 28,
                          margin: const EdgeInsets.only(left: 20),
                          decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.black45, width: 0.5)),
                          child: const Icon(Icons.arrow_back_ios_new, color: Colors.black38, size: 15),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20),
                        child: CustomText(
                          text: title,
                          color: Colors.black,
                          weight: FontWeight.bold,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
            const SizedBox(height: 40),
            Container(margin: const EdgeInsets.symmetric(horizontal: 20), child: const Divider()),
            const SizedBox(height: 40),
            title == null
                ? GridView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(right: 2),
                    physics: const BouncingScrollPhysics(),
                    itemCount: accountCards.length,
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      mainAxisExtent: 120,
                      maxCrossAxisExtent: 560,
                    ),
                    itemBuilder: (_, index) {
                      return accountCards[index];
                    })
                : item
          ]),
        ),
      )
    ],
  );
}

var accountCards = [];
accountCard(int i, clickIndex) {
  return Padding(
    padding: const EdgeInsets.only(left: 8, right: 8, bottom: 16),
    child: InkWell(
      hoverColor: Colors.transparent,
      splashColor: Pallet.secondaryColor.withOpacity(0.2),
      focusColor: Colors.transparent,
      onTap: () => cPropCtrl.accountIndex.value = clickIndex,
      child: Container(
        height: 90,
        width: double.infinity,
        decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 0.2), borderRadius: BorderRadius.circular(6)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 45,
              width: 45,
              margin: const EdgeInsets.only(left: 20),
              decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Pallet.secondaryColor, width: 0.5)),
              child:  Icon(Lst.accountCards[i].icon, color: Colors.black, size: 35),
            ),
            const SizedBox(width: 12),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: Lst.accountCards[i].title,
                    color: Colors.black,
                    weight: FontWeight.bold,
                    size: 16,
                  ),
                  const SizedBox(height: 8),
                  // CustomText(
                  //   text: Lst.accountCards[i].subTitle,
                  //   color: Colors.black,
                  //   weight: FontWeight.w200,
                  //   size: 14,
                  //   maxLines: 3,
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

personalInfo() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(
          text: 'Personal details',
          color: Colors.black,
          weight: FontWeight.w200,
          size: 16,
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: FormInput(
                value: accountName(user: user, home: true),
                width: double.infinity,
                controller: EditCtrl.firstName,
                error: EditCtrl.firstNameErr,
                validate: Val.name,
                label: 'First name ',
                hint: 'First name',
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: FormInput(
                value: propCtrl.user.value.surname ?? '',
                width: double.infinity,
                controller: EditCtrl.surname,
                error: EditCtrl.surnameErr,
                validate: Val.name,
                label: 'Surname',
                hint: 'Surname',
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: FormInput(
                value: propCtrl.user.value.emailAddress ?? '',
                width: double.infinity,
                controller: EditCtrl.email,
                label: 'Email Address ',
                hint: 'Enter email address',
                isEnabled: false,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: FormInput(
                value: propCtrl.user.value.phoneNumber ?? '',
                width: double.infinity,
                inputType: TextInputType.phone,
                controller: EditCtrl.phone,
                error: EditCtrl.phoneErr,
                validate: Val.phone,
                label: 'Phone Number',
                hint: 'Enter phone number',
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
        propCtrl.isUser
            ? const SizedBox.shrink()
            : const CustomText(
                text: 'Location Details details',
                color: Colors.black,
                weight: FontWeight.w200,
                size: 16,
              ),
        propCtrl.isUser ? const SizedBox.shrink() : const SizedBox(height: 16),
        propCtrl.isUser
            ? const SizedBox.shrink()
            : Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: DropDown(
                      initialValue: propCtrl.user.value.premiumDetails!.state ?? propCtrl.user.value.agency!.state ?? '',
                      controller: EditCtrl.state,
                      label: 'State',
                      items: Lst.ngStates,
                    ),
                  ),
                  const SizedBox(width: 30),
                  Expanded(
                    child: DropDown(
                      controller: EditCtrl.city,
                      label: 'City/Town',
                      items: Lst.ngLGA[EditCtrl.state] ?? [],
                    ),
                  ),
                ],
              ),
        propCtrl.isUser ? const SizedBox.shrink() : const SizedBox(height: 30),
        propCtrl.isUser
            ? const SizedBox.shrink()
            : FormInput(
                height: 100,
                maxLines: 8,
                value: propCtrl.user.value.premiumDetails!.address ?? propCtrl.user.value.agency!.address ?? '',
                width: double.infinity,
                controller: EditCtrl.address,
                label: 'Residential Address',
                hint: 'Enter address',
              ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: FormBorderButton(
                width: 86,
                bgColor: Colors.white,
                txtColor: Colors.black,
                text: Str.cancel,
                onPressed: () => Utils.isMobileApp ? Get.back() : cPropCtrl.accountIndex.value = 0,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Flexible(
                flex: 1,
                child: FormButton(
                  width: 86,
                  text: Str.save,
                  disableButton: false,
                  onPressed: homeCtrl.submitUpdateProfile,
                ))
          ],
        ),
      ],
    ),
  );
}

privacySecurity() {
  return cPropCtrl.changePassword.value
      ? Container(
          margin: const EdgeInsets.symmetric(horizontal: 180),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText(
                text: 'Password Details',
                color: Colors.black,
                weight: FontWeight.w300,
                size: 16,
              ),
              const SizedBox(height: 30),
              FormInput(
                maxLines: 1,
                width: double.infinity,
                controller: EditCtrl.passwordOld,
                label: 'Old Password',
                hint: '...............',
              ),
              const SizedBox(height: 50),
              FormInput(
                maxLines: 1,
                width: double.infinity,
                controller: EditCtrl.password,
                label: 'New Password',
                hint: '...............',
              ),
              const SizedBox(height: 30),
              FormInput(
                maxLines: 1,
                width: double.infinity,
                controller: EditCtrl.password2,
                label: 'Confirm Password',
                hint: '...............',
              ),
              const SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () => cPropCtrl.changePassword.value = false,
                child: Container(
                  width: 60,
                  decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey, width: 1))),
                  child: Row(children: const [
                    Icon(Icons.arrow_back_ios, size: 14),
                    CustomText(
                      text: 'Back',
                      color: Pallet.secondaryColor,
                      weight: FontWeight.w500,
                      size: 14,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ]),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: FormBorderButton(
                      width: 120,
                      bgColor: Colors.white,
                      txtColor: Colors.black,
                      text: 'Cancel',
                      onPressed: () {
                        cPropCtrl.accountIndex.value = 0;
                        cPropCtrl.changePassword.value = false;
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                      flex: 1,
                      child: FormButton(
                        width: 100,
                        text: 'Update',
                        disableButton: false,
                        onPressed: homeCtrl.submitChangePassword,
                      ))
                ],
              ),
            ],
          ),
        )
      : Container(
          margin: const EdgeInsets.symmetric(horizontal: 180),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText(
                text: 'Password Details',
                color: Colors.black,
                weight: FontWeight.bold,
                size: 16,
              ),
              const SizedBox(height: 30),
              FormInput(
                isEnabled: false,
                maxLines: 1,
                width: double.infinity,
                controller: EditCtrl.passwordHide,
                label: 'Password',
                hint: '....................',
              ),
              const SizedBox(height: 50),
              InkWell(
                onTap: () => cPropCtrl.changePassword.value = true,
                child: Container(
                  width: 138,
                  decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey, width: 1))),
                  child: Row(children: const [
                    CustomText(
                      text: 'Change Password',
                      color: Pallet.secondaryColor,
                      weight: FontWeight.w500,
                      size: 14,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.arrow_forward_ios, size: 14),
                  ]),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        );
}

identificationDocument() {
  return propCtrl.isUser
      ? InkWell(
          onTap: () => cPropCtrl.sideNavIndex.value = 4,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
              Icon(Icons.arrow_circle_up_sharp, size: 20),
              SizedBox(width: 8),
              CustomText(
                text: 'Upgrade to premium',
                color: Pallet.secondaryColor,
                weight: FontWeight.w500,
                size: 16,
              ),
            ]),
          ),
        )
      : (propCtrl.user.value.isAgent ?? false)
          ? Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(
                    text: 'Means of identification',
                    color: Colors.black,
                    weight: FontWeight.w200,
                    size: 16,
                  ),
                  const SizedBox(height: 30),
                  const CustomText(
                    text: '(Drivers licence, International Passport, Voter\'s Card, National ID Card)',
                    color: Colors.grey,
                    weight: FontWeight.w200,
                    size: 14,
                  ),
                  const SizedBox(height: 30),
                  Container(
                      height: 160,
                      width: 260,
                      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 12),
                      decoration: BoxDecoration(color: const Color.fromARGB(255, 240, 234, 234), borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/upload.png',
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextStyles.richTexts(
                              onPress1: () {},
                              onPress2: () {},
                              decoration: TextDecoration.underline,
                              size: 14,
                              centerText: false,
                              color2: Pallet.secondaryColor,
                              text1: 'upload your document. ',
                              text2: ' Browse image',
                              text3: '',
                              text4: ''),
                        ],
                      )),
                  const SizedBox(height: 30),
                  FormInput(
                    value: propCtrl.user.value.premiumDetails!.idNumber ?? '',
                    width: 255,
                    controller: EditCtrl.title,
                    label: 'ID Card Number',
                    hint: '53653663789930038',
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () {
                      toggleIdentityPage();
                    },
                    child: Container(
                      width: 58,
                      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey, width: 1))),
                      child: Row(children: const [
                        Icon(Icons.arrow_back_ios, size: 14),
                        SizedBox(
                          width: 4,
                        ),
                        CustomText(
                          text: 'Back',
                          color: Pallet.secondaryColor,
                          weight: FontWeight.w500,
                          size: 14,
                        ),
                      ]),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: FormBorderButton(
                          width: 120,
                          bgColor: Colors.white,
                          txtColor: Colors.black,
                          text: 'Cancel',
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(width: 10),
                      Flexible(
                          flex: 1,
                          child: FormButton(
                            width: 100,
                            text: 'Update',
                            disableButton: false,
                            onPressed: () {},
                          ))
                    ],
                  ),
                ],
              ),
            )
          : Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(
                    text: 'Means of identification',
                    color: Colors.black,
                    weight: FontWeight.w200,
                    size: 16,
                  ),
                  const SizedBox(height: 30),
                  const CustomText(
                    text: '(Drivers licence, International Passport, Voter\'s Card, National ID Card)',
                    color: Colors.grey,
                    weight: FontWeight.w200,
                    size: 14,
                  ),
                  const SizedBox(height: 30),
                  InkWell(
                    onTap: () {
                      toggleIdentityPage();
                    },
                    child: Container(
                        height: 160,
                        width: 260,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(color: const Color.fromARGB(255, 240, 234, 234), borderRadius: BorderRadius.circular(8)),
                        child: Image.asset('assets/images/id.png', height: 100, width: 120)),
                  ),
                  const SizedBox(height: 30),
                  FormInput(
                    width: 255,
                    controller: EditCtrl.title,
                    label: 'ID Card Number',
                    hint: propCtrl.user.value.premiumDetails!.idNumber ?? '',
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Visibility(
                    visible: false,
                    child: InkWell(
                      onTap: () {
                        toggleIdentityPage();
                      },
                      child: Container(
                        width: 145,
                        decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey, width: 1))),
                        child: Row(children: const [
                          CustomText(
                            text: 'Change ID Card',
                            color: Pallet.secondaryColor,
                            weight: FontWeight.w500,
                            size: 14,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(Icons.arrow_forward_ios, size: 14),
                        ]),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            );
}

notificationSettings() {
  return Column(
    children: [
      Container(
        margin: const EdgeInsets.only(left: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const CustomText(
                    text: 'Request Order Alert',
                    color: Colors.black,
                    weight: FontWeight.bold,
                    size: 16,
                  ),
                  Transform.scale(
                    scale: 0.5,
                    child: CupertinoSwitch(value: true, activeColor: Colors.green, onChanged: (value) {}),
                  ),
                ],
              ),
              const CustomText(
                text: 'Nam dapibus finibus nisl, a pretium',
                color: Color.fromARGB(255, 167, 157, 157),
                weight: FontWeight.w200,
                size: 14,
              ),
            ]),
            const SizedBox(width: 50),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const CustomText(
                    text: 'Email Alert',
                    color: Colors.black,
                    weight: FontWeight.bold,
                    size: 16,
                  ),
                  Transform.scale(
                    scale: 0.5,
                    child: CupertinoSwitch(value: false, activeColor: Colors.green, onChanged: (value) {}),
                  ),
                ],
              ),
              const CustomText(
                text: 'Nam dapibus finibus nisl, a pretium',
                color: Color.fromARGB(255, 167, 157, 157),
                weight: FontWeight.w200,
                size: 14,
              ),
            ]),
          ],
        ),
      ),
      const SizedBox(height: 40),
      Container(
        margin: const EdgeInsets.only(left: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const CustomText(
                    text: 'Update Alert',
                    color: Colors.black,
                    weight: FontWeight.bold,
                    size: 16,
                  ),
                  Transform.scale(
                    scale: 0.5,
                    child: CupertinoSwitch(value: true, activeColor: Colors.green, onChanged: (value) {}),
                  ),
                ],
              ),
              const CustomText(
                text: 'Nam dapibus finibus nisl, a pretium',
                color: Color.fromARGB(255, 167, 157, 157),
                weight: FontWeight.w200,
                size: 14,
              ),
            ]),
            const SizedBox(width: 50),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const CustomText(
                    text: 'Finibus nisl Alert',
                    color: Colors.black,
                    weight: FontWeight.bold,
                    size: 16,
                  ),
                  Transform.scale(
                    scale: 0.5,
                    child: CupertinoSwitch(value: false, activeColor: Colors.green, onChanged: (value) {}),
                  ),
                ],
              ),
              const CustomText(
                text: 'Nam dapibus finibus nisl, a pretium',
                color: Color.fromARGB(255, 167, 157, 157),
                weight: FontWeight.w200,
                size: 14,
              ),
            ]),
          ],
        ),
      ),
      const SizedBox(height: 40),
      Container(
        margin: const EdgeInsets.only(left: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const CustomText(
                    text: 'In-App Alert',
                    color: Colors.black,
                    weight: FontWeight.bold,
                    size: 16,
                  ),
                  Transform.scale(
                    scale: 0.5,
                    child: CupertinoSwitch(value: true, activeColor: Colors.green, onChanged: (value) {}),
                  ),
                ],
              ),
              const CustomText(
                text: 'Nam dapibus finibus nisl, a pretium',
                color: Color.fromARGB(255, 167, 157, 157),
                weight: FontWeight.w200,
                size: 14,
              ),
            ]),
            const SizedBox(width: 50),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const CustomText(
                    text: 'Nam dapibus Alert',
                    color: Colors.black,
                    weight: FontWeight.bold,
                    size: 16,
                  ),
                  Transform.scale(
                    scale: 0.5,
                    child: CupertinoSwitch(value: false, activeColor: Colors.green, onChanged: (value) {}),
                  ),
                ],
              ),
              const CustomText(
                text: 'Nam dapibus finibus nisl, a pretium',
                color: Color.fromARGB(255, 167, 157, 157),
                weight: FontWeight.w200,
                size: 14,
              ),
            ]),
          ],
        ),
      ),
      const SizedBox(height: 40),
      Container(
        margin: const EdgeInsets.only(right: 50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: FormBorderButton(
                width: 120,
                bgColor: Colors.white,
                txtColor: Colors.black,
                text: 'Cancel',
                onPressed: () {},
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Flexible(
                flex: 1,
                child: FormButton(
                  width: 100,
                  text: 'Update',
                  disableButton: false,
                  onPressed: () {},
                ))
          ],
        ),
      )
    ],
  );
}

void togglePasswordPage() {
  if (cPropCtrl.isChange) {
    cPropCtrl.isChange = false;
  } else {
    cPropCtrl.isChange = true;
  }
}

void toggleIdentityPage() {
  if (cPropCtrl.isIdentity) {
    cPropCtrl.isIdentity = false;
  } else {
    cPropCtrl.isIdentity = true;
  }
}

notificationSettingsInfo() {
  return Wrap(children: [
    const SizedBox(height: 20),
    SizedBox(
      width: isTabletDown() ? double.infinity : Get.width * 0.29,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('NOTIFICATIONS', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Pallet.secondaryColor)),
          const SizedBox(height: 8),
          settingsItem('App Notifications', 'Nam sethe uopeid and oddoek', user.settings?.inAppAlert),
          settingsItem('Email Alert', 'Nam sethe uopeid and oddoek', user.settings?.emailAlert),
          settingsItem('SMS Alert', 'Nam sethe uopeid and oddoek', user.settings?.smsAlert),
        ],
      ),
    ),
    SizedBox(width: Get.width * 0.015),
    SizedBox(
      width: isTabletDown() ? double.infinity : Get.width * 0.29,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Text('UPDATES', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Pallet.secondaryColor)),
          const SizedBox(height: 8),
          settingsItem('Request Tour Alert', 'Nam sethe uopeid and oddoek', user.settings?.requestTourAlert),
          settingsItem('Newsletter Subscription', 'Nam sethe uopeid and oddoek', user.settings?.subNewsletter),
          settingsItem('News and Update', 'Nam sethe uopeid and oddoek', user.settings?.updateAlert),
        ],
      ),
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FormBorderButton(
          width: 86,
          bgColor: Colors.white,
          txtColor: Colors.black,
          text: Str.cancel,
          onPressed: () => Utils.isMobileApp ? Get.back() : cPropCtrl.accountIndex.value = 0,
        ),
        const SizedBox(width: 10),
        FormButton(
          width: 86,
          textSize: 14,
          weight: FontWeight.bold,
          text: Str.save,
          disableButton: false,
          onPressed: homeCtrl.updateSettings,
        ),
      ],
    ),
  ]);
}

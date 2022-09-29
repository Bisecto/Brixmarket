import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/theme/color.dart';
import '../../../controllers/edit_controller.dart';
import '../../../controllers/instance.dart';
import '../../../core/app.dart';
import '../../../res/lists.dart';
import '../../../res/states.dart';
import '../../../res/strings.dart';
import '../../../utils/utils.dart';
import '../../../utils/validations.dart';
import '../../widgets/appbar_menus.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/dash_border.dart';
import '../../widgets/drop_down.dart';
import '../../widgets/form_button.dart';
import '../../widgets/form_inputs.dart';
import '../../widgets/image_widgets.dart';
import '../dashboard/account_widgets.dart';

class ProfilingPage extends StatelessWidget {
  const ProfilingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallet.homeBackground,
      appBar: AppBar(
        backgroundColor: Pallet.secondaryColor,
        automaticallyImplyLeading: true,
        title: const CustomText(
          color: Colors.white,
          size: 18,
          text: 'My Profile',
        ),
        actions: const [AppBarMenu(logout: true, myAccount: true, propertyIDS: [],)],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
        ),
        children: [
          profileImgAndBasicInfo(0),
          Container(
            color: Pallet.secondaryColor,
            padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
            child: const CustomText(
              color: Pallet.whiteColor,
              size: 16,
              text: 'My Profile',
              weight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 20),
          buildListTile(
            onTap: () => Get.toNamed(RouteStr.mobilePersonalInfo),
            title: user.isUser == true ? 'Personal Information' : 'Basic Information',
            icon: Icons.account_box_outlined,
          ),
          user.isUser == true
              ? const SizedBox.shrink()
              : buildListTile(
                  onTap: () => Get.toNamed(RouteStr.mobileAgencyInfo),
                  title: 'Agency Information',
                  icon: Icons.document_scanner,
                ),
          // user.isUser == true
          //     ? const SizedBox.shrink()
          //     : buildListTile(
          //         onTap: () => Get.toNamed(RouteStr.mobileLegalDocumentInfo),
          //         title: 'Location Information',
          //         icon: Icons.location_on,
          //       ),
          user.isUser == false
              ? const SizedBox.shrink()
              : buildListTile(
                  onTap: () => Get.toNamed(RouteStr.mobileLocationInfo),
                  title: 'Legal Documentation',
                  icon: Icons.balance,
                ),
          user.isUser == false
              ? const SizedBox.shrink()
              : buildListTile(
                  onTap: () => Get.toNamed(RouteStr.mobileMobileIdInfo),
                  title: 'Identity Document',
                  icon: Icons.featured_video_outlined,
                ),buildListTile(
            onTap: () => homeCtrl.deleteAccount(),
            title: 'Delete Account',
            color: Colors.red,
            icon: Icons.delete_outline_outlined,
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  buildListTile({String title = '', IconData? icon, required Function onTap, Color? color}) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade300, width: 0.8))),
        child: ListTile(
          trailing: color != null ? const SizedBox.shrink() : Icon(
            Icons.arrow_forward_ios,
            color: Colors.blueGrey[500],
            size: 12,
          ),
          leading: Icon(icon ?? Icons.dashboard, size: 22, color: Pallet.secondaryColor),
          title: CustomText(
            color: color??Colors.black87,
            size: 16,
            text: title,
            weight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

class PersonalInformation extends StatelessWidget {
  const PersonalInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallet.homeBackground,
      appBar: AppBar(
        backgroundColor: Pallet.secondaryColor,
        automaticallyImplyLeading: true,
        title: const CustomText(
          color: Colors.white,
          size: 18,
          text: 'Personal Information',
        ),
        actions: const [AppBarMenu(logout: true, myAccount: true, propertyIDS: [],)],
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 60,
          ),
          SizedBox(
            child: Stack(
              alignment: Alignment.center, //MemoryImage(EditCtrl.image8Lists[0])
              children: [
                Obx(() => CircleAvatar(
                      radius: 45,
                      backgroundImage: EditCtrl.image8Lists.isNotEmpty
                          ? MemoryImage(EditCtrl.image8Lists[0])
                          : (user.image != null && user.image != '')
                              ? NetworkImage('$userImgPath${user.image}') as ImageProvider
                              : const AssetImage(ImgStr.avatarImg),
                    )),
                Positioned(
                  bottom: 12,
                  right: Get.width * 0.37,
                  child: InkWell(
                    onTap: homeCtrl.selectSingleImage,
                    child: Container(
                      height: 20,
                      width: 20,
                      decoration: const BoxDecoration(
                        color: Pallet.secondaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.edit, color: Colors.white, size: 10),
                    ),
                  ),
                ),
                const Icon(Icons.camera_enhance, color: Colors.white70, size: 36),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CustomText(
                color: Colors.black,
                size: 14,
                text: 'REF ID: ',
              ),
              CustomText(
                color: Pallet.secondaryColor,
                size: 14,
                text: user.refId,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const Divider(thickness: 1),
          const SizedBox(
            height: 10,
          ),
          personalInfo()
        ],
      ),
    );
  }
}

class AgencyInformation extends StatelessWidget {
  const AgencyInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallet.homeBackground,
      appBar: AppBar(
        backgroundColor: Pallet.secondaryColor,
        automaticallyImplyLeading: true,
        title: const CustomText(
          color: Colors.white,
          size: 18,
          text: 'Agency Information',
        ),
        actions: const [AppBarMenu(logout: true, myAccount: true, propertyIDS: [],)],
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 60,
          ),
          profileImgAndRefId(),
          const SizedBox(
            height: 20,
          ),
          const Divider(thickness: 1),
          const SizedBox(
            height: 10,
          ),
          agencyInfoWidget(),
        ],
      ),
    );
  }
}

agencyInfoWidget() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 14.0),
    child: Wrap(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormInput(
          value: user.agency?.name ?? '',
          controller: EditCtrl.agencyName,
          error: EditCtrl.agencyNameErr,
          validate: Val.name,
          label: '${Str.agent} / ${Str.agencyName}',
          hint: Str.agencyName,
          width: isMobile() ? double.infinity : Get.width * 0.3,
        ),
        SizedBox(
          width: isMobile() ? Get.width * 0.6 : 16,
          height: isMobile() ? 24 : 0,
        ),
        DropDown(
          initialValue: user.agency?.state ?? '',
          controller: EditCtrl.state,
          label: Str.state,
          items: ngnStates,
          width: isMobile() ? double.infinity : Get.width * 0.3,
        ),
        SizedBox(
          height: 24,
          width: Get.width * 0.6,
        ),
        Obx(() => DropDown(
              initialValue: user.agency?.city ?? '',
              controller: EditCtrl.city,
              label: Str.town,
              items: ngnLga[EditCtrl.state.value.text == '' ? user.agency?.city ?? '' : EditCtrl.state.value.text] ?? [],
              width: isMobile() ? double.infinity : Get.width * 0.3,
            )),
        SizedBox(
          width: isMobile() ? Get.width * 0.6 : 16,
          height: isMobile() ? 24 : 0,
        ),
        FormInput(
          value: user.agency?.address ?? '',
          controller: EditCtrl.address,
          error: EditCtrl.addressErr,
          validate: Val.name,
          label: Str.streetAddress,
          hint: Str.streetAddress,
          width: isMobile() ? double.infinity : Get.width * 0.3,
        ),
        SizedBox(
          height: 24,
          width: Get.width * 0.6,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
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
              onPressed: homeCtrl.updateAgencyDetails,
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    ),
  );
}

class LocationInfo extends StatelessWidget {
  const LocationInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallet.homeBackground,
      appBar: AppBar(
        backgroundColor: Pallet.secondaryColor,
        automaticallyImplyLeading: true,
        title: const CustomText(
          color: Colors.white,
          size: 18,
          text: 'Location Information',
        ),
        actions: const [AppBarMenu(logout: true, myAccount: true, propertyIDS: [],)],
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 60,
          ),
          profileImgAndRefId(),
          const SizedBox(
            height: 20,
          ),
          const Divider(thickness: 1),
          const SizedBox(
            height: 10,
          ),
          locationInfo(),
        ],
      ),
    );
  }
}

locationInfo() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 14.0),
    child: Wrap(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropDown(
          initialValue: user.premiumDetails?.state ?? '',
          controller: EditCtrl.state,
          label: Str.state,
          items: ngnStates,
          width: isMobile() ? double.infinity : Get.width * 0.3,
        ),
        SizedBox(
          width: isMobile() ? Get.width * 0.6 : 16,
          height: isMobile() ? 24 : 0,
        ),
        Obx(() => DropDown(
              initialValue: homeCtrl.user.value.premiumDetails?.city ?? '',
              controller: EditCtrl.city,
              label: Str.town,
              width: isMobile() ? double.infinity : Get.width * 0.3,
              items: ngnLga[EditCtrl.state.value.text == '' ? user.premiumDetails?.city ?? '' : EditCtrl.state.value.text] ?? [],
            )),
        SizedBox(
          height: 16,
          width: Get.width * 0.6,
        ),
        FormInput(
          value: user.premiumDetails?.address ?? '',
          controller: EditCtrl.address,
          error: EditCtrl.addressErr,
          validate: Val.name,
          label: Str.streetAddress,
          hint: Str.streetAddress,
          width: double.infinity,
        ),
        SizedBox(
          height: 16,
          width: Get.width * 0.6,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
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
              onPressed: () => homeCtrl.premiumUpgrade(updateLocation: true),
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    ),
  );
}

class LegalDocumentation extends StatelessWidget {
  const LegalDocumentation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallet.homeBackground,
      appBar: AppBar(
        backgroundColor: Pallet.secondaryColor,
        automaticallyImplyLeading: true,
        title: const CustomText(
          color: Colors.white,
          size: 18,
          text: 'Legal Documentation',
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: Icon(
              Icons.more_vert,
              color: Colors.white,
              size: 30,
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 60,
          ),
          profileImgAndRefId(),
          const SizedBox(
            height: 20,
          ),
          const Divider(thickness: 1),
          const SizedBox(
            height: 10,
          ),
          legalDocumentInfo(),
        ],
      ),
    );
  }
}

legalDocumentInfo() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 14.0),
    child: Wrap(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormInput(
          value: user.agency?.document?.legalName ?? '',
          controller: EditCtrl.legalName,
          error: EditCtrl.legalNameErr,
          validate: Val.name,
          label: '${Str.registeredName} (${Str.legalName})',
          hint: Str.registeredName,
          isEnabled: homeCtrl.user.value.agency?.isVerified == false,
          width: isMobile() ? double.infinity : Get.width * 0.3,
        ),
        SizedBox(
          width: isMobile() ? Get.width * 0.6 : 16,
          height: isMobile() ? 24 : 0,
        ),
        FormInput(
          value: user.agency?.document?.rcNumber ?? '',
          inputType: TextInputType.number,
          controller: EditCtrl.rcNumber,
          error: EditCtrl.rcNumberErr,
          validate: Val.number,
          label: 'RC number',
          hint: 'RC number',
          maxLength: 12,
          isEnabled: homeCtrl.user.value.agency?.isVerified == false,
          width: isMobile() ? double.infinity : Get.width * 0.3,
        ),
        SizedBox(
          height: 30,
          width: Get.width * 0.7,
        ),
        const CustomText(
          color: Colors.black,
          size: 16,
          text: Str.cacCert,
          weight: FontWeight.w600,
        ),
        SizedBox(
          height: 10,
          width: Get.width * 0.7,
        ),
        Obx(() => homeCtrl.user.value.agency?.isVerified == true
            ? Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black26),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Image.network('$cacImgPath${user.agency?.document?.certPhoto}'),
              )
            : SizedBox(
                width: double.infinity,
                height: 360,
                child: Stack(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 340,
                      child: InkWell(
                        onTap: homeCtrl.selectSingleImage,
                        child: DashedBorder(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 280,
                                  child: Obx(
                                    () => EditCtrl.image8Lists.isNotEmpty
                                        ? Image.memory(
                                            EditCtrl.image8Lists[0],
                                            fit: BoxFit.contain,
                                          )
                                        : user.agency?.document?.certPhoto != null && user.agency?.document?.certPhoto != ''
                                            ? Image.network('$cacImgPath${user.agency?.document?.certPhoto}')
                                            : Image.asset(
                                                ImgStr.certImg,
                                                height: 180,
                                                color: Colors.black12,
                                              ),
                                  ),
                                ),
                                // const Spacer(),
                                const Text(Str.changeCACCert, style: TextStyle(color: Pallet.secondaryColor)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 6,
                      bottom: 0,
                      child: InkWell(
                        onTap: homeCtrl.selectSingleImage,
                        child: CircleAvatar(
                          radius: 21,
                          child: Icon(Icons.add_a_photo, color: Pallet.whiteColor, size: 18),
                          backgroundColor: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
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
              onPressed: homeCtrl.updateAgencyDocument,
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    ),
  );
}

class IdentityDocument extends StatelessWidget {
  const IdentityDocument({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallet.homeBackground,
      appBar: AppBar(
        backgroundColor: Pallet.secondaryColor,
        automaticallyImplyLeading: true,
        title: const CustomText(
          color: Colors.white,
          size: 18,
          text: 'Identity Document',
        ),
        actions: const [AppBarMenu(logout: true, myAccount: true, propertyIDS: [],)],
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 60,
          ),
          profileImgAndRefId(),
          const SizedBox(
            height: 20,
          ),
          const Divider(thickness: 1),
          const SizedBox(
            height: 10,
          ),
          identityInfo(),
        ],
      ),
    );
  }
}

identityInfo() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 14.0),
    child: Wrap(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropDown(
          initialValue: user.premiumDetails?.idType,
          controller: EditCtrl.idType,
          label: 'ID Type',
          items: Lst.idTypes,
          width: isMobile() ? double.infinity : Get.width * 0.3,
        ),
        const SizedBox(
          height: 20,
          width: 16,
        ),
        FormInput(
          value: user.premiumDetails?.idNumber,
          controller: EditCtrl.idNumber,
          error: EditCtrl.rcNumberErr,
          validate: Val.name,
          label: Str.idNumber,
          hint: Str.idNumber,
          width: isMobile() ? double.infinity : Get.width * 0.27,
          maxLength: 12,
        ),
        const SizedBox(
          height: 30,
          width: double.infinity,
        ),
        const CustomText(
          color: Colors.black,
          size: 16,
          text: Str.idImage,
          weight: FontWeight.w600,
        ),
        const SizedBox(
          height: 10,
          width: double.infinity,
        ),
        Obx(() => homeCtrl.user.value.premiumDetails?.isVerified == true
            ? Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black26),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Image.network('$idImgPath${user.premiumDetails?.idPhoto}'),
              )
            : SizedBox(
                width: double.infinity,
                height: 360,
                child: Stack(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 340,
                      child: InkWell(
                        onTap: homeCtrl.selectSingleImage,
                        child: DashedBorder(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 280,
                                  child: Obx(
                                    () => EditCtrl.image8Lists.isNotEmpty
                                        ? Image.memory(
                                            EditCtrl.image8Lists[0],
                                            fit: BoxFit.contain,
                                          )
                                        : user.premiumDetails?.idPhoto != null && user.premiumDetails?.idPhoto != ''
                                            ? Image.network('$idImgPath${user.premiumDetails?.idPhoto}')
                                            : Image.asset(
                                                ImgStr.idImg2,
                                                height: 240,
                                                fit: BoxFit.fitWidth,
                                                color: Colors.black12,
                                              ),
                                  ),
                                ),
                                // const Spacer(),
                                const Text(Str.changeId, style: TextStyle(color: Pallet.secondaryColor)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 6,
                      bottom: 0,
                      child: InkWell(
                        onTap: homeCtrl.selectSingleImage,
                        child: const CircleAvatar(
                          radius: 21,
                          child: Icon(Icons.add_a_photo, color: Pallet.whiteColor, size: 18),
                          backgroundColor: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
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
              onPressed: () => homeCtrl.premiumUpgrade(updateId: true),
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    ),
  );
}

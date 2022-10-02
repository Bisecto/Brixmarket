import 'package:brixmarket/controllers/instance.dart';
import 'package:brixmarket/res/strings.dart';
import 'package:brixmarket/utils/validations.dart';
import 'package:brixmarket/view/widgets/app_social_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../config/theme/color.dart';
import '../../../controllers/edit_controller.dart';
import '../../../controllers/home_controller.dart';
import '../../widgets/appbar_menus.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/form_button.dart';
import '../../widgets/form_inputs.dart';
import '../web_terms.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
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
            text: 'Help',
          ),
          actions: const [AppBarMenu(logout: true, myAccount: true, propertyIDS: [],)],
        ),
        body: ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            children: [
              const SizedBox(
                height: 40,
              ),
              const SizedBox(
                height: 20,
              ),
              buildListTile(onTap: () => Get.toNamed(RouteStr.mobileFAQ), title: 'FAQ'),
              buildListTile(onTap: () => Get.to(() => const ContactPage()), title: 'Contact Us'),
              buildListTile(onTap: () => Get.toNamed(RouteStr.mobileTerms), title: 'Terms and Conditions'),
              // buildListTile( onTap: () => Get.toNamed(RouteStr.mobilePolicy), title: 'Privacy Policy'),
              buildListTile(onTap: () => Get.toNamed(RouteStr.mobileAbout), title: 'About Us'),
              const SizedBox(
                height: 80,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(child: Container(height: 0.5, width: 150, color: Colors.grey)),
                  const SizedBox(
                    width: 10,
                  ),
                  const CustomText(
                    text: 'Find us on',
                    size: 14,
                    color: Colors.black54,
                    weight: FontWeight.bold,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(child: Container(height: 0.5, width: 150, color: Colors.grey)),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              const Center(
                child: AppSocialIcons(iconSize: 24, space: 30, iconColor: Pallet.secondaryColor),
              ),
              const SizedBox(
                height: 40,
              ),
            ]));
  }

  buildListTile({String title = '', required Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade300, width: 0.8))),
        child: ListTile(
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: Colors.blueGrey[500],
            size: 20,
          ),
          leading: CustomText(
            color: Colors.blueGrey[500],
            size: 16,
            text: title,
            weight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

class FAQPage extends StatefulWidget {
  const FAQPage({Key? key}) : super(key: key);

  @override
  State<FAQPage> createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  int selectedIndex = 0;

  void isSelected({int? index}) {
    setState(() {
      selectedIndex = index!;
    });
  }

  Set active = {};

  void _handleTap(index) {
    setState(() {
      active.contains(index) ? active.remove(index) : active.add(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallet.primaryBackgroundLight,
      appBar: AppBar(
        backgroundColor: Pallet.secondaryColor,
        automaticallyImplyLeading: true,
        title: const CustomText(
          color: Colors.white,
          size: 18,
          text: 'FAQs',
        ),
        actions: const [AppBarMenu(logout: true, myAccount: true, propertyIDS: [],)],
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Container(color: Colors.white, height: 120, child: Center(child: Image.asset(ImgStr.logo1, width: 140))),
          const SizedBox(height: 16.0),
          _buildStep(
            leadingTitle: "",
            title: "FAQ".toUpperCase(),
            content: '',
          ),
          faqContainer(body: '', title: ''),
          const SizedBox(height: 48.0),
          // Container(
          //   height: 64,
          //   width: double.infinity,
          //   color: Pallet.primaryBackgroundLight,
          //   padding: const EdgeInsets.symmetric(horizontal: 8),
          //   child: ListView(
          //     shrinkWrap: true,
          //     scrollDirection: Axis.horizontal,
          //     children: [
          //       buttonContainer(text: 'General', index: 0),
          //       buttonContainer(text: 'Login', index: 1),
          //       buttonContainer(text: 'Account', index: 2),
          //       buttonContainer(text: 'Tips', index: 3),
          //     ],
          //   ),
          // ),
          // SizedBox(
          //   height: Get.height * 0.85,
          //   child: IndexedStack(
          //     index: selectedIndex,
          //     children: [
          //       faqContainer(body: '', title: ''),
          //       faqContainer(body: '', title: ''),
          //       faqContainer(body: '', title: ''),
          //       faqContainer(body: '', title: ''),
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }

  faqContainer({String? title, String? body}) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: homeCtrl.faqs.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: ((context, index) {
            return Card(
              margin: const EdgeInsets.all(6),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: (() {
                        setState(() {
                          _handleTap(index);
                        });
                      }),
                      child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(color: Colors.white, border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: CustomText(
                                  text: homeCtrl.faqs[index].question,
                                  size: 16,
                                  color: Colors.black,
                                ),
                              ),
                              active.contains(index)
                                  ? const Icon(
                                      Icons.remove,
                                      color: Pallet.secondaryColor,
                                      size: 24,
                                    )
                                  : const Icon(
                                      Icons.add,
                                      color: Pallet.secondaryColor,
                                      size: 24,
                                    )
                            ],
                          )),
                    ),
                    Visibility(
                      visible: active.contains(index) ? true : false,
                      child: AnimatedContainer(
                        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                        width: double.infinity,
                        duration: const Duration(seconds: 1),
                        child: Text(homeCtrl.faqs[index].answer),
                      ),
                    ),
                  ],
                ),
              ),
            );
          })),
    );
  }

  buttonContainer({String? text, int? index}) {
    return GestureDetector(
      onTap: () {
        isSelected(index: index);
      },
      child: Align(
        child: SizedBox(
          height: 40,
          child: Container(
            width: Get.width * 0.30,
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: selectedIndex == index ? Pallet.secondaryColor : Colors.white,
                border: Border.all(
                  color: Pallet.secondaryColor,
                  width: 1,
                )),
            child: Center(
              child: CustomText(
                color: selectedIndex == index ? Colors.white : Pallet.secondaryColor,
                size: 14,
                text: text!,
                weight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ContactPage extends StatelessWidget {
  final bool web;
  const ContactPage({Key? key, this.web = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallet.homeBackground,
      appBar: AppBar(
        backgroundColor: web ? Colors.white : Pallet.secondaryColor,
        foregroundColor: !web ? Colors.white : Pallet.secondaryColor,
        elevation: 0,
        automaticallyImplyLeading: true,
        title: CustomText(
          color: !web ? Colors.white : Pallet.secondaryColor,
          size: 18,
          weight: FontWeight.bold,
          text: 'Contact Us',
        ),
        actions: [web ? const SizedBox.shrink() : const AppBarMenu(logout: true, myAccount: true, propertyIDS: [],)],
      ),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        children: [
          const CustomText(
            color: Colors.blueGrey,
            size: 18,
            weight: FontWeight.w600,
            text: 'Mail a request or Complaints',
          ),
          const SizedBox(height: 20),
          FormInput(
            value: isLogin ? accountName(user: user) : '',
            width: double.infinity,
            controller: EditCtrl.name,
            error: EditCtrl.nameErr,
            validate: Val.name,
            label: 'Name',
            hint: 'Enter full Name',
          ),
          const SizedBox(height: 20),
          FormInput(
            value: isLogin ? user.emailAddress : '',
            width: double.infinity,
            controller: EditCtrl.email,
            error: EditCtrl.emailErr,
            validate: Val.email,
            label: 'Email',
            hint: 'Enter Email',
          ),
          const SizedBox(height: 20),
          FormInput(
            value: isLogin && user.phoneNumber != null && user.phoneNumber != '' ? user.phoneNumber : '',
            controller: EditCtrl.phone,
            error: EditCtrl.phoneErr,
            validate: Val.phone,
            width: double.infinity,
            label: 'Phone number(optional)',
            hint: 'Enter Phone number',
          ),
          const SizedBox(
            height: 20,
          ),
          FormInput(
            controller: EditCtrl.subject,
            error: EditCtrl.subjectErr,
            validate: Val.name,
            width: double.infinity,
            label: 'Subject',
            hint: 'Enter the subject',
          ),
          const SizedBox(height: 20),
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
          const SizedBox(height: 8),
          FormIconButton(
            width: Get.width,
            height: 42,
            onPressed: homeCtrl.contactUs,
            fontSize: 16,
            text: 'Send message',
          ),
          const SizedBox(height: 36),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Flexible(child: Container(height: 0.5, width: 150, color: Colors.grey)),
            const SizedBox(
              width: 10,
            ),
            const CustomText(
              text: 'You can also reach out on',
              size: 14,
              color: Colors.grey,
              weight: FontWeight.w600,
            ),
            const Flexible(
              child: SizedBox(
                width: 10,
              ),
            ),
            Expanded(child: Container(height: 0.5, width: 150, color: Colors.grey)),
          ]),
          const SizedBox(height: 16),
          const Center(child: AppSocialIcons(iconColor: Pallet.secondaryColor, iconSize: 24, space: 30)),
          const SizedBox(height: 24),
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    CustomText(
                      textAlign: TextAlign.start,
                      text: 'Email',
                      size: 16,
                      color: Pallet.secondaryColor,
                      weight: FontWeight.bold,
                    ),
                    SizedBox(height: 8),
                    CustomText(
                      text: Str.contactEmail1,
                      size: 16,
                      color: Colors.black54,
                      weight: FontWeight.w500,
                    ),
                    SizedBox(height: 8),
                    CustomText(
                      text: Str.contactEmail2,
                      size: 16,
                      color: Colors.black54,
                      weight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    CustomText(
                      text: 'Hotline',
                      size: 16,
                      color: Pallet.secondaryColor,
                      weight: FontWeight.bold,
                    ),
                    SizedBox(height: 8),
                    CustomText(
                      text: Str.contactPhone1,
                      size: 16,
                      color: Colors.black54,
                      weight: FontWeight.w500,
                    ),
                    SizedBox(height: 8),
                    CustomText(
                      text: Str.contactPhone2,
                      size: 16,
                      color: Colors.black54,
                      weight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    CustomText(
                      text: 'HQ Address',
                      size: 16,
                      color: Pallet.secondaryColor,
                      weight: FontWeight.bold,
                    ),
                    SizedBox(height: 8),
                    CustomText(
                      text: 'Abuja, Nigeria',
                      size: 16,
                      color: Colors.black87,
                      weight: FontWeight.w600,
                    ),
                    SizedBox(height: 8),
                    CustomText(
                      text: 'No 9B Seguela Street, Wuse Zone 2, British Village, Off IBB Boulevard',
                      size: 16,
                      color: Colors.black54,
                      weight: FontWeight.w500,
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 8.0),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.end,
              //     children: const [
              //       CustomText(
              //         text: 'Address',
              //         size: 16,
              //         color: Pallet.secondaryColor,
              //         weight: FontWeight.bold,
              //       ),
              //       CustomText(
              //         text: 'Lagos, Nigeria',
              //         size: 16,
              //         color: Colors.black87,
              //         weight: FontWeight.w600,
              //       ),
              //       CustomText(
              //         textAlign: TextAlign.end,
              //         maxLines: 2,
              //         text: 'Victoria Island',
              //         size: 16,
              //         color: Colors.black54,
              //         weight: FontWeight.w500,
              //       ),
              //     ],
              //   ),
              // )
            ],
          )
        ],
      ),
    );
  }
}

class TermsPage extends StatelessWidget {
  const TermsPage({Key? key}) : super(key: key);

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
          text: 'Terms and Conditions',
        ),
        actions: [HomeController.isLogin.value ? const AppBarMenu(logout: true, myAccount: true, propertyIDS: [],) : const SizedBox.shrink()],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(10.0),
              children: <Widget>[
                const SizedBox(
                  height: 20.0,
                ),
                _buildStep(leadingTitle: "01", title: "OverView".toUpperCase(), content: ''),
                termsContent(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildStep({String? leadingTitle, String? title, String? content}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        color: Pallet.secondaryColor,
        child: Container(
          padding: const EdgeInsets.all(5.0),
          child: Text(leadingTitle!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18.0)),
        ),
      ),
      const SizedBox(
        width: 16.0,
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.blueGrey[900],
                )),
            const SizedBox(
              height: 10.0,
            ),
            Text(content!, style: const TextStyle(color: Pallet.blueGray, fontSize: 14.0)),
          ],
        ),
      )
    ],
  );
}

class PolicyPage extends StatelessWidget {
  const PolicyPage({Key? key}) : super(key: key);

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
          text: 'Privacy Policy',
        ),
        actions: const [AppBarMenu(logout: true, myAccount: true, propertyIDS: [],)],
      ),
      body: Column(
        children: <Widget>[
          // Expanded(
          //   child: ListView(
          //     padding: const EdgeInsets.all(10.0),
          //     children: <Widget>[
          //       const SizedBox(
          //         height: 20.0,
          //       ),
          //       _buildStep(
          //           leadingTitle: "01",
          //           title: "Data Collection".toUpperCase(),
          //           content:
          //               "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent lacinia, odio ut placerat finibus, ipsum risus consectetur ligula, non mattis mi neque ac mi. Vivamus quis tellus sed erat eleifend pharetra ac non diam. Integer vitae ipsum congue, vestibulum eros quis, interdum tellus. Nunc vel dictum elit. Curabitur suscipit scelerisque."),
          //       const SizedBox(
          //         height: 30.0,
          //       ),
          //       _buildStep(
          //           leadingTitle: "02",
          //           title: "Personal Data Encryption".toUpperCase(),
          //           content:
          //               "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent lacinia, odio ut placerat finibus, ipsum risus consectetur ligula, non mattis mi neque ac mi. Vivamus quis tellus sed erat eleifend pharetra ac non diam. Integer vitae ipsum congue, vestibulum eros quis, interdum tellus. Nunc vel dictum elit. Curabitur suscipit scelerisque."),
          //       const SizedBox(
          //         height: 30.0,
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key? key}) : super(key: key);

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
          text: 'About Us',
        ),
        actions: const [AppBarMenu(logout: true, myAccount: true, propertyIDS: [],)],
      ),
      body: ListView(
        children: [
          SizedBox(height: 160, child: Center(child: Image.asset(ImgStr.logo1, width: 140))),
          _buildStep(
              leadingTitle: "",
              title: "Company Description:".toUpperCase(),
              content:
                  "Brixmarket is an online marketplace for real-estate in Nigeria. Brixmarket aim to bring the best real-estate deals to both buyers and sellers. We are making every type of real-estate property from commercial buildings, homes, and estates to parking lots and shop shelf space available for sale, lease, or rent"),
          const SizedBox(
            height: 30.0,
          ),
          _buildStep(leadingTitle: "", title: "Our Mission".toUpperCase(), content: "To connect landlords and property seekers in a safe space. "),
          const SizedBox(
            height: 30.0,
          ),
          _buildStep(leadingTitle: "", title: "Our Vision".toUpperCase(), content: "To become Africa’s leading real-estate Marketplace."),
          const SizedBox(
            height: 20,
          ),
          TextStyles.richTexts(
            centerText: true,
            color: Colors.blueGrey,
            decoration: TextDecoration.underline,
            onPress1: () => launchUrl(Uri.parse('https://company.brixmarket.com/about/')),
            onPress2: () {
              launchUrlString('https://company.brixmarket.com/about/');
            },
            size: 16,
            text1: 'For more information visit\n',
            text2: 'Company.brixmarket.com',
          )
        ],
      ),
    );
  }
}
// Facebook
// Brixmarkethq
// Brixmarketplace
//
// Instagram
// Brixmarkethq
//
// Twitter
// Brixmarket

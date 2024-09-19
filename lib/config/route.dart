import 'package:brixmarket/view/screens/mobile/account_page.dart';
import 'package:brixmarket/view/screens/mobile/add_property_page.dart';
import 'package:brixmarket/view/screens/mobile/chat_details_page.dart';
import 'package:brixmarket/view/screens/mobile/chat_page.dart';
import 'package:brixmarket/view/screens/mobile/explore_filter_page.dart';
import 'package:brixmarket/view/screens/mobile/explore_page.dart';
import 'package:brixmarket/view/screens/mobile/help_page.dart';
import 'package:brixmarket/view/screens/mobile/home_page.dart';
import 'package:brixmarket/view/screens/mobile/my_ads_page.dart';
import 'package:brixmarket/view/screens/mobile/notifications_page.dart';
import 'package:brixmarket/view/screens/mobile/privacy_security_page.dart';
import 'package:brixmarket/view/screens/mobile/profiling_page.dart';
import 'package:brixmarket/view/screens/mobile/statistic_page.dart';
import 'package:brixmarket/view/screens/mobile/subscription_page.dart';
import 'package:get/get.dart';

import '../controllers/edit_controller.dart';
import '../res/strings.dart';
import '../view/screens/about.dart';
import '../view/screens/accept_location_usage.dart';
import '../view/screens/auth/login_page.dart';
import '../view/screens/authentication_pages/login.dart';
import '../view/screens/authentication_pages/reg_agency.dart';
import '../view/screens/authentication_pages/reg_basic_info.dart';
import '../view/screens/authentication_pages/register.dart';
import '../view/screens/authentication_pages/signup_homepage.dart';
import '../view/screens/authentication_pages/verify_reg_otp_page.dart';
import '../view/screens/dashboard_page.dart';
import '../view/screens/hom_page_web.dart';
import '../view/screens/homepage.dart';
import '../view/screens/mobile/landing_page.dart';
import '../view/screens/mobile/onboard_page.dart';
import '../view/screens/mobile/property_details_page.dart';
import '../view/screens/mobile/single_property_page.dart';
import '../view/screens/mobile/splash_screen.dart';
import '../view/screens/no_internet.dart';
import '../view/screens/properties_page_web.dart';
import '../view/screens/property_page_web.dart';
import '../view/screens/reset_password_pages/create_new_password.dart';
import '../view/screens/reset_password_pages/forgot_password.dart';
import '../view/screens/reset_password_pages/password_otp_page.dart';
import '../view/screens/web_policy.dart';
import '../view/screens/web_terms.dart';
import 'package:brixmarket/view/screens/filter_web_page.dart';

//Authentication Pages
List<GetPage<dynamic>> authPages = [
  GetPage(
      name: RouteStr.login,
      page: () => Login(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      name: RouteStr.registerHome,
      page: () => const SignUpHomePage(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      name: RouteStr.register,
      page: () => const RegisterPage(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      name: RouteStr.verityOtp,
      page: () => VerifyOtpPage(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      name: RouteStr.regBasic,
      page: () => const RegBasicInfoPage(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      name: RouteStr.regAgency,
      page: () => RegAgencyPage(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      name: RouteStr.recoverPassword,
      page: () => const ForgotPassword(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      name: RouteStr.verifyPasswordOTP,
      page: () => PasswordOtpPage(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      name: RouteStr.createNewPassword,
      page: () => const CreateNewPassword(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
];

//Web Pages
List<GetPage<dynamic>> webPages = [
  GetPage(
      name: RouteStr.webHome,
      page: () => HomePageWeb(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      name: RouteStr.webProperties,
      page: () => PropertiesPage(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      name: RouteStr.webfilter,
      page: () => Filter_web(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      name: RouteStr.webProperty,
      page: () => const PropertyPageWeb(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      name: RouteStr.webDashboard,
      page: () => DashboardPage(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      name: RouteStr.webAboutUs,
      page: () => AboutUsWeb(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      name: RouteStr.webContactUs,
      page: () => DashboardPage(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      name: RouteStr.webTerms,
      page: () => TermsWeb(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      name: RouteStr.webPolicy,
      page: () => PolicyWeb(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
];

//Mobile Landing Pages
List<GetPage<dynamic>> mobileLandingPages = [
  GetPage(
      name: RouteStr.mobileLanding,
      page: () => const MobileLandingPage(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      name: RouteStr.mobileSplashscreen,
      page: () => const SplashScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
  //GetPage(name: RouteStr.mobileAcceptLocationUsage, page: () => const AcceptLocationUsage(), transition: Transition.fadeIn, transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
    name: RouteStr.mobileOnboard,
    page: () => const OnBoardingPage(),
    transition: Transition.leftToRightWithFade,
  ),
];

//Mobile Home Pages
List<GetPage<dynamic>> mobileHomePages = [
  GetPage(
      name: RouteStr.mobileHome,
      page: () => HomePage(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      name: RouteStr.propertySinglePage,
      page: () => Single_Property(property_id: EditCtrl.propertyId.text, property_tiitle: 'Brixmarket',),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      name: RouteStr.mobileNotification,
      page: () => const HomeNotificationsPage(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      name: RouteStr.mobileHomeSearch,
      page: () => const HomeSearchPage(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      name: RouteStr.mobileExplore,
      page: () => const ExplorePage(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      name: RouteStr.mobileExploreFilter,
      page: () => const FilterExplorePage(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      name: RouteStr.mobileDashboard,
      page: () => const AccountPage(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
  //GetPage(name: RouteStr.mobileProperty, page: () =>  PropertyPageMobile(), transition: Transition.fadeIn, transitionDuration: const Duration(milliseconds: 500)),
];

//Mobile Dashboard Pages
List<GetPage<dynamic>> mobileDashboardPages = [
  GetPage(
      name: RouteStr.mobileCreateProperty,
      page: () => AddPropertyPage(
            isEdit: true,
          ),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      name: RouteStr.mobileChatHistory,
      page: () => const ChatPage(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      name: RouteStr.chat,
      page: () => const ChatDetailPage(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      name: RouteStr.mobileMyProperties,
      page: () => const MyAdsPage(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      name: RouteStr.mobileStatistic,
      page: () => const StatisticPage(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      name: RouteStr.mobileSubscription,
      page: () => SubScriptionPage(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      name: RouteStr.mobileProfileHome,
      page: () => const ProfilingPage(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
    name: RouteStr.mobileSecurityHome,
    page: () => const PrivacySecurityPage(),
  ),
  GetPage(
      name: RouteStr.mobileNotificationSettings,
      page: () => const Notifications(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      name: RouteStr.mobileHelpHome,
      page: () => const HelpPage(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
];

//Mobile Profile pages
List<GetPage<dynamic>> mobileProfilePages = [
  GetPage(
      name: RouteStr.mobilePersonalInfo,
      page: () => const PersonalInformation(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      name: RouteStr.mobileAgencyInfo,
      page: () => const AgencyInformation(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      name: RouteStr.mobileLegalDocumentInfo,
      page: () => const LocationInfo(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      name: RouteStr.mobileLocationInfo,
      page: () => const LegalDocumentation(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      name: RouteStr.mobileMobileIdInfo,
      page: () => const IdentityDocument(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      name: RouteStr.mobileChangePassword,
      page: () => const ChangePasswordPage(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
];

//Mobile support and utility pages
List<GetPage<dynamic>> supportPages = [
  GetPage(
      name: RouteStr.mobileNoInternet,
      page: () => NoInternet(callBack: () => Get.back()),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      name: RouteStr.mobileAbout,
      page: () => const AboutUsPage(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      name: RouteStr.mobileFAQ,
      page: () => const FAQPage(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      name: RouteStr.mobilePolicy,
      page: () => const PolicyPage(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      name: RouteStr.mobileTerms,
      page: () => const TermsPage(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      name: RouteStr.mobileContact,
      page: () => const ContactPage(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
  GetPage(
      name: RouteStr.mobileSubPayment,
      page: () => SubScriptionPage(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500)),
];

List<GetPage<dynamic>> mobileRoutes = [
  ...authPages,
  ...mobileHomePages,
  ...mobileLandingPages,
  ...mobileDashboardPages,
  ...supportPages,
  ...mobileProfilePages,
];

List<GetPage<dynamic>> webRoutes = [
  ...authPages,
  ...webPages,
];

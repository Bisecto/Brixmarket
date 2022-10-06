const String paystackPublicKey = 'pk_test_9a1befcef6741639660d3028bb8414b2216c8f04';

mixin RouteStr {
  //Authentication Routes
  static const String registerHome = '/get-started';
  static const String register = '/sign-up';
  static const String login = '/sign-in';
  static const String verityOtp = '/verify-email';
  static const String regBasic = '/account-basic';
  static const String regAgency = '/business-account';
  static const String recoverPassword = '/recover-password';
  static const String verifyPasswordOTP = '/verify-account';
  static const String createNewPassword = '/create-new-password';

  //Web Routes
  static const String webHome = '/';
  static const String webProperties = '/properties';
  static const String webProperty = '/property';
  static const String webDashboard = '/dashboard';
  static const String webSubPayment = 'sub-payment';
  static const String webAboutUs = '/about-us';
  static const String webContactUs = '/contact-us';
  static const String webTerms = '/terms';

  //Mobile Landing Routes
  static const String mobileSplashscreen = '/splash';
  static const String mobileAcceptLocationUsage = '/accept-location-usage';
  static const String mobileOnboard = '/onboard';
  static const String mobileLanding = '/';

  //Mobile Home Routes
  static const String mobileHome = '/home';
  static const String mobileNotification = '/notifications';
  static const String mobileHomeSearch = '/home-search';
  static const String mobileExplore = '/explore';
  static const String mobileExploreFilter = '/explore';
  static const String mobileDashboard = '/dashboard';
  static const String mobileProperty = '/property';

  //Mobile Dashboard Routes
  static const String mobileCreateProperty = '/create-property';
  static const String mobileChatHistory = '/chat-history';
  static const String chat = '/chat';
  static const String mobileMyProperties = '/my-properties';
  static const String mobileStatistic = '/statistic';
  static const String mobileSubscription = '/subscription';
  static const String mobileProfileHome = '/profile-home';
  static const String mobileSecurityHome = '/security-home';
  static const String mobileNotificationSettings = '/notifications-settings';
  static const String mobileHelpHome = '/help-home';

  //Profile and Settings Routes
  static const String mobilePersonalInfo = '/personal-info';
  static const String mobileAgencyInfo = '/agency-info';
  static const String mobileLegalDocumentInfo = '/legal-document-info';
  static const String mobileLocationInfo = '/location-info';
  static const String mobileMobileIdInfo = '/identity-info';
  static const String mobileChangePassword = '/change-password';

  //Mobile Support and Utility routes
  static const String mobileNoInternet = '/no-internet';
  static const String mobileAbout = '/about_us_page';
  static const String mobileFAQ = '/faq_page';
  static const String mobilePolicy = '/contact';
  static const String mobileTerms = '/terms_page';
  static const String mobileContact = '/contact';
  static const String mobileSubPayment = '/sub-payment';
}

mixin ImgStr {
//Images
  static const String logo = 'assets/images/brix-logo.png';
  static const String logoLight = 'assets/images/brix-logo-light.png';
  static const String logoDark = 'assets/images/brix-logo-dark.png';
  static const String logoLightLight = 'assets/images/brix-logo-light-light.png';
  static const String logoDarkLight = 'assets/images/brix-logo-dark-light.png';
  static const String logoDarkLight2 = 'assets/images/brix-logo-light2.png';
  static const String logo1 = 'assets/images/brixmarketlogo.jpg';
  static const String logo2 = "assets/images/brixlogo2.png";
  static const String avatarImg = "assets/images/avatar.jpg";
  static const String certImg = "assets/images/cert.png";
  static const String idImg = "assets/images/id-image.png";
  static const String idImg2 = "assets/images/id-photo.png";
  static const String loadingImg = "assets/images/load.gif";
  static const String loadingLove1 = "assets/images/love1.gif";
  static const String loadingLove2 = "assets/images/love2.gif";
  static const String loadingLove3 = "assets/images/love3.gif";
  static const String chatBg = "assets/images/chat-bg.jpg";
  static const String loadingRedBalls = "assets/images/loading-red.gif";
  static const String loadingBalls = "assets/images/loading.gif";
  static const String notificationBell="assets/images/notification-bell.gif";
}

class Str with RouteStr, ImgStr {
  static const String appName = 'Brixmarket';

  static const String signIn = 'Sign In';
  static const String createNewPassword = 'Create New Password';
  static const String resetPassword = 'Reset Password';
  static const String signUp = 'Sign Up';
  static const String accountBasic = 'Account Basic Info';
  static const String uploadProfileLogo = 'Upload your Logo';
  static const String uploadProfileImage = 'Upload Profile image';
  static const String editProfileLogo = 'Edit your Logo';
  static const String editProfileImage = 'Edit Profile image';
  static const String signUpAs = 'Sign up as';
  static const String password = 'Password';
  static const String oldPassword = 'Old Password';
  static const String newPassword = 'New Password';
  static const String repeatPassword = 'Repeat Password';
  static const String confirmNewPassword = 'Confirm New Password';
  static const String surname = 'Surname';
  static const String firstName = 'First name';
  static const String phoneNumber = 'Phone number';
  static const String email = 'Email';
  static const String emailAddress = 'Email Address';
  static const String reset = 'Reset';
  static const String cancel = 'Cancel';
  static const String submit = 'Submit';
  static const String save = 'Save';
  static const String update = 'Update';
  static const String forgotPassword = 'Forgot Password';
  static const String forgotPasswordQ = 'Forgot Password?';
  static const String haveAccountQ = 'Already have an account? ';
  static const String donTHaveAccountQ = 'Don\'t have have an account? ';
  static const String rememberedYourPasswordQ = 'Remembered your password? ';
  static const String required = '* required';
  static const String invalidEmail = 'Invalid email address';
  static const String invalidPhone = 'Invalid phone number';
  static const String invalidNumber = 'Invalid number';
  static const String invalidName = ' ';
  static const String passwordToShot = 'Password is too shot';
  static const String wait = 'Please wait...';
  static const String individual = 'INDIVIDUAL';
  static const String realTorAgent = 'REALTOR / AGENT';
  static const String developerAgency = 'ESTATE DEVELOPER / AGENCY';
  static const String user = 'User';
  static const String agent = 'Agent';
  static const String agency = 'Agency';
  static const String agencyName = 'Agency name';
  static const String streetAddress = 'Street address';
  static const String town = 'Town';
  static const String state = 'State';
  static const String registeredName = 'Registered name';
  static const String legalName = 'Legal name';
  static const String rcNumber = 'RC number';
  static const String idNumber = 'ID number';
  static const String registeredWithCAC = 'Registered with CAC';
  static const String uploadCACCert = 'Upload CAC Certificate';
  static const String uploadId = 'Upload Id';
  static const String cacCert = 'CAC Certificate';
  static const String idImage = 'ID Image';
  static const String changeCACCert = 'Change CAC Certificate';
  static const String changeId = 'Change ID';
  static const String refIdPrefix = 'REF ID: ';
  static const String noText = '';

  static const String tersAndCon = 'Terms and Conditions';
  static const String youAgree = 'By signing up, you agree to our';
  static const String notAcceptedOurTerms = 'You have not accepted our terms and conditions';
  static const String agreeProfileImage = 'I agree that my profile image will be visible to other users ';
  static const String agreeProfileContact = 'I agree that my phone number will be visible to other users ';

  static const String contactEmail1 = 'info@brixmarket.com';
  static const String contactEmail2 = 'brixmarkethq@gmail.com';

  // static const String contactPhone1 = '+234 906 949 6990';
  static const String contactPhone1 = '+234 913 938 2069';
  static const String contactPhone2 = '+234 913 938 2068';
  static const String contactAddress = 'No 9B Seguela Street, Wuse Zone 2, Abuja';
  static const String instagramLink = 'https://www.instagram.com/brixmarkethq/';
  static const String WhatsappLink = 'https://wa.me/message/MEGXIZ2KIAKPL1';
  static const String linkedInLink = 'https://www.linkedin.com/company/brixmarketplace/';
  static const String facebookLink = 'https://www.facebook.com/BRIXMARKET';
  static const String downloadIOSLink = 'https://apps.apple.com/app/brixmarket/id1645681904';
  static const String downloadAndroidLink = 'https://play.google.com/store/apps/details?id=com.brixx.brixmarket';

  static const String buy = 'Buy';
  static const String rent = 'Rent';
  static const String newHome = 'New Homes';
  static const String shortStay = 'Short Stay';
  static const String commercial = 'Commercial';
  static const String premiumRealtors = 'Premium Realtors';

  static const String downloadOurAppDescription =
      'Customize your search so that you can find the property of your choice in no time. Download our mobile application to customize your experience and see properties best suited for you';
}

const String SLIDER_HEADING_1_SUB = "All-in-one marketplace";
const String SLIDER_HEADING_1 = "To discover Nearby Homes";
const String SLIDER_HEADING_2_SUB = "A secured way to";
const String SLIDER_HEADING_2 = "Place properties on Sale";
const String SLIDER_HEADING_3_SUB = "Earn cool cash by";
const String SLIDER_HEADING_3 = "Renting out our properties";
const String SLIDER_DESC1 = "A Hassel free way to Buy, sell and rent out properties across all cities";
const String SLIDER_DESC2 = "A Hassel free way to Buy, sell and rent out properties across all cities";
const String SLIDER_DESC3 = "A Hassel free way to Buy, sell and rent out properties across all cities";
const SKIP = 'Skip';

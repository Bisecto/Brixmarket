import 'package:brixmarket/controllers/home_controller.dart';

import 'agency_model.dart';
import 'premium_model.dart';
import 'setting_model.dart';

class User {
  String? surname;
  String? firstName;
  String? phoneNumber;
  String? whatsAppNumber;
  String? emailAddress;
  String? password;
  String? refId;
  String? image;
  String? location;
  String? longitude;
  String? latitude;
  String? city;
  String? state;
  String? country;
  String? address;
  bool? isAdmin;
  bool? isActive;
  bool? isAgent;
  bool? isAgency;
  bool? isUser;
  bool? isVerified;
  bool? verifiedAgent;
  bool? isPremium;
  bool? isBlocked;
  int? level;
  String? otp;
  String? id;
  String? createdAt;
  String? updatedAt;
  PremiumDetail? premiumDetails;
  Agency? agency;
  Setting? settings;
  List<String>? savedProperties;
  String? token;

  set savedProperty(List<String> value) {
    savedProperties = value;
  }

  static const array = <String>[];
  User({
    this.surname,
    this.firstName,
    this.phoneNumber,
    this.whatsAppNumber,
    this.emailAddress,
    this.refId,
    this.image,
    this.location,
    this.password,
    this.isAdmin,
    this.isActive,
    this.isAgency,
    this.isAgent,
    this.isUser,
    this.level,
    this.address,
    this.city,
    this.state,
    this.country,
    this.isVerified,
    this.verifiedAgent,
    this.isPremium,
    this.isBlocked,
    this.otp,
    this.token,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.premiumDetails,
    this.agency,
    this.settings,
    this.savedProperties,
  });

  User.fromJson(json) {
    surname = json['surname'];
    firstName = json['first_name'];
    phoneNumber = json['phone_number'];
    whatsAppNumber = json['whatsapp_number'];
    emailAddress = json['email_address'];
    image = json['image'];
    refId = json['ref_id'];
    location = json['location'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    password = json['password'];
    isAdmin = json['is_admin'].toString() == '1';
    isActive = json['is_active'].toString() == '1';
    isAgency = json['is_agency'].toString() == '1';
    isAgent = json['is_agent'].toString() == '1';
    isUser = json['is_user'].toString() == '1';
    isVerified = json['is_verified'].toString() == '1';
    verifiedAgent = json['verified_agent'].toString() == '1';
    isPremium = json['is_premium'].toString() == '1';
    isBlocked = json['is_blocked'].toString() == '1';
    otp = json['otp'];
    token = json['token'];
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    premiumDetails = json['premium_details'] != null
        ? PremiumDetail.fromJson(json['premium_details'])
        : PremiumDetail();
    agency =
        json['agency'] != null ? Agency.fromJson(json['agency']) : Agency();
    settings = json['settings'] != null
        ? Setting.fromJson(json['settings'])
        : Setting();
    savedProperties = json['saved_properties'] != null
        ? (json['saved_properties'] as List)
            .map((e) => e['property'] as String)
            .toList()
        : [];
  }

  static Map<String, dynamic> map({
    userId,
    surname,
    firstName,
    phone,
    whatsAppNumber,
    email,
    refId,
    image,
    location,
    longitude,
    latitude,
    password,
    password2,
    passwordOld,
    isAdmin,
    isAgent,
    isAgency,
    isUser,
    level,
    isVerified,
    isPremium,
    isBlocked,
    otp,
    legalName,
    rcNumber,
    certPhoto,
    agencyName,
    address,
    city,
    state,
    country,
    legalStatus,
    idType,
    idNumber,
    idPhoto,
    requestTourAlert,
    inAppAlert,
    emailAlert,
    updateAlert,
    subNewsletter,
    subject,
    message,
    token,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (otp != null) data['otp'] = otp;
    if (token != null) data['token'] = token;
    if (userId != null || HomeController.userId.isNotEmpty) {
      data['userId'] = userId ?? HomeController.userId;
    }

    if (isPremium != null) data['is_premium'] = isPremium;
    if (isUser != null) data['is_user'] = isUser;
    if (isAgent != null) data['is_agent'] = isAgent;
    if (isAgency != null) data['is_agency'] = isAgency;
    if (isAdmin != null) data['is_admin'] = isAdmin;
    if (level != null) data['is_admin'] = level;

    if (surname != null) data['surname'] = surname;
    if (firstName != null) data['first_name'] = firstName;
    if (email != null) data['email_address'] = email;
    if (refId != null) data['refId'] = refId;
    if (image != null) data['image'] = image;
    if (location != null) data['location'] = location;
    if (longitude != null) data['longitude'] = longitude.toString();
    if (latitude != null) data['latitude'] = latitude.toString();
    if (whatsAppNumber != null) data['whatsapp_number'] = whatsAppNumber;
    if (phone != null) data['phone_number'] = phone;
    if (password != null) data['password'] = password;
    if (password2 != null) data['password_repeat'] = password2;
    if (passwordOld != null) data['password_old'] = passwordOld;

    if (legalName != null) data['legal_name'] = legalName;
    if (rcNumber != null) data['rc_number'] = rcNumber;
    if (certPhoto != null) data['cert_photo'] = certPhoto;

    if (agencyName != null) data['name'] = agencyName;
    if (address != null) data['address'] = address;
    if (city != null) data['city'] = city;
    if (state != null) data['state'] = state;
    if (country != null) data['country'] = country;
    if (legalStatus != null) data['legal_status'] = legalStatus;

    if (idType != null) data['id_type'] = idType;
    if (idNumber != null) data['id_number'] = idNumber;
    if (idPhoto != null) data['id_photo'] = idPhoto;

    if (requestTourAlert != null) data['request_tour_alert'] = requestTourAlert;
    if (updateAlert != null) data['update_alert'] = updateAlert;
    if (inAppAlert != null) data['in_app_alert'] = inAppAlert;
    if (emailAlert != null) data['email_alert'] = emailAlert;
    if (subNewsletter != null) data['sub_newsletter'] = subNewsletter;
    if (subject != null) data['subject'] = subject;
    if (message != null) data['message'] = message;
    return data;
  }

  static Map<String, dynamic> authMap(
      {emailAddress, password, isPremium, isAgent, isUser}) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email_address'] = emailAddress;
    data['password'] = password;
    if (isPremium != null) {
      data['is_premium'] = isPremium;
    }
    if (isUser != null) {
      data['is_user'] = isUser;
    }
    if (isAgent != null) {
      data['is_agent'] = isAgent;
    }
    return data;
  }

  static Map<String, dynamic> idMap({userId}) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    return data;
  }

  static Map<String, dynamic> otpMap({userId, otp}) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['otp'] = otp;
    return data;
  }
}

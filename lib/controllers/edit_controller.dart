import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/utils.dart';
import '../view/screens/create_property/create_property_widges.dart';

class EditCtrl extends GetxController {
  static var selectedIndex = 0.obs;

  onSelected(int index) {
    selectedIndex.value = index;
    selectedIndex.refresh();
  }

  static var chatMessage = TextEditingController();
  static var isEdits = false.obs;

  static var userAddress = TextEditingController();
  static var userAddressErr = ''.obs;
  static var newsLetterEmail = TextEditingController();
  static var newsLetterEmailErr = ''.obs;
  static var email = TextEditingController();
  static var emailErr = ''.obs;
  static var phone = TextEditingController();
  static var phoneErr = ''.obs;
  static var whatsAppNumber = TextEditingController();
  static var whatsAppPhoneErr = ''.obs;
  static var password = TextEditingController();
  static var passwordErr = ''.obs;
  static var password2 = TextEditingController();
  static var password2Err = ''.obs;
  static var passwordHide = TextEditingController(text: '.....................');
  static var passwordOld = TextEditingController();
  static var passwordOldErr = ''.obs;
  static var name = TextEditingController();
  static var nameErr = ''.obs;
  static var surname = TextEditingController();
  static var surnameErr = ''.obs;
  static var firstName = TextEditingController();
  static var firstNameErr = ''.obs;
  static var name2 = TextEditingController();
  static var name2Err = ''.obs;
  static var otp = TextEditingController();
  static var otpErr = ''.obs;
  static var legalName = TextEditingController();
  static var legalNameErr = ''.obs;
  static var rcNumber = TextEditingController();
  static var rcNumberErr = ''.obs;
  static var idType = TextEditingController().obs;
  static var idTypeErr = ''.obs;
  static var idPhoto = TextEditingController();
  static var idPhotoErr = ''.obs;
  static var agencyName = TextEditingController();
  static var agencyNameErr = ''.obs;
  static var address = TextEditingController();
  static var addressErr = ''.obs;
  static var city = TextEditingController().obs;
  static var cityErr = ''.obs;
  static var state = TextEditingController().obs;
  static var country=TextEditingController().obs;
  static var stateErr = ''.obs;
  static var idNumber = TextEditingController();
  static var idNumberErr = ''.obs;
  static var agencyCacCert = TextEditingController();
  static var agencyCacCertErr = ''.obs;

  static var amount = TextEditingController();
  static var amountErr = ''.obs;

  static var priceDuration = TextEditingController().obs;
  static var priceDurationErr = ''.obs;
  static var price = TextEditingController();
  static var priceErr = ''.obs;
  static var title = TextEditingController();
  static var titleErr = ''.obs;
  static var description = TextEditingController();
  static var descriptionErr = ''.obs;
  static var reference = TextEditingController();
  static var referenceErr = ''.obs;
  static var category = TextEditingController().obs;
  static var categoryErr = ''.obs;
  static var type = TextEditingController().obs;
  static var typeErr = ''.obs;
  static var status = TextEditingController().obs;
  static var statusErr = ''.obs;
  static var landmarks = TextEditingController().obs;
  static var landmarksErr = ''.obs;
  static var longitude = TextEditingController();
  static var longitudeErr = ''.obs;
  static var latitude = TextEditingController();
  static var latitudeErr = ''.obs;
  static var upgradeAmount = TextEditingController();
  static var upgradeAmountErr = ''.obs;
  static var subject = TextEditingController();
  static var subjectErr = ''.obs;
  static var message = TextEditingController();
  static var messageTour = TextEditingController();
  static var messageReview = TextEditingController();
  static var messageFeedback = TextEditingController();
  static var messageErr = ''.obs;
  static var rating = TextEditingController();
  static var ratingErr = ''.obs;

  static var homeSearch = TextEditingController();
  static var homeSearchErr = ''.obs;
  static var exploreSearch = TextEditingController();
  static var exploreSearchErr = ''.obs;

  static var filterState = TextEditingController().obs;
  static var filterCity = TextEditingController().obs;
  static var filterLandMark = TextEditingController().obs;
  static var priceMin = TextEditingController().obs;
  static var priceMax = TextEditingController().obs;
  static var roomMin = TextEditingController().obs;
  static var roomMax = TextEditingController().obs;
  static var bathsMin = TextEditingController().obs;
  static var bathsMax = TextEditingController().obs;
  static var webSearchKeyWord = TextEditingController();
  static var filterCategoriesWeb = TextEditingController().obs;
  static var filterCategories = ['Any'].obs;
  static var filterTypes = ['Any'].obs;
  static var filterStatus = ['Any'].obs;
  static var filterAmenities = ['Any'].obs;

  //static var ctrlList = [];
  //static var ctrlListKeys = [];
  static var amenities = [].obs;
  static var features=[].obs;

  static var userType = ''.obs;

  static var acceptTerms = false.obs;
  static var acceptPhone = false.obs;
  static var isRegisterAgency = false.obs;

  static File? imageFile;
  static var showUploadedImage = false.obs;
  static RxList<File> imageFiles = <File>[].obs;
  static RxList<Uint8List> image8Lists = <Uint8List>[].obs;

  static void disposeControllers() {
    try {
      chatMessage.text = '';
      isEdits.value=false;
      userAddress.text = '';
      userAddressErr.value = '';
      email.text = '';
      emailErr.value = '';
      phone.text = '';
      phoneErr.value = '';
      whatsAppNumber.text = '';
      whatsAppPhoneErr.value = '';
      password.text = '';
      passwordErr.value = '';
      password2.text = '';
      password2Err.value = '';
      passwordHide.text = '';
      passwordOld.text = '';
      passwordOldErr.value = '';
      name.text = '';
      nameErr.value = '';
      surname.text = '';
      surnameErr.value = '';
      firstName.text = '';
      firstNameErr.value = '';
      name2.text = '';
      name2Err.value = '';
      otp.text = '';
      otpErr.value = '';
      legalName.text = '';
      legalNameErr.value = '';
      rcNumber.text = '';
      rcNumberErr.value = '';
      idType.value.text = '';
      idTypeErr.value = '';
      idPhoto.text = '';
      idPhotoErr.value = '';
      agencyName.text = '';
      agencyNameErr.value = '';
      address.text = '';
      addressErr.value = '';
      city.value.text = '';
      cityErr.value = '';
      state.value.text = '';
      stateErr.value = '';
      idNumber.text = '';
      idNumberErr.value = '';
      agencyCacCert.text = '';
      agencyCacCertErr.value = '';

      amount.text = '';
      amountErr.value = '';

      priceDuration.value.text = '';
      priceDurationErr.value = '';
      price.text = '';
      priceErr.value = '';
      title.text = '';
      titleErr.value = '';
      description.text = '';
      descriptionErr.value = '';
      reference.text = '';
      referenceErr.value = '';
      category.value.text = '';
      categoryErr.value = '';
      type.value.text = '';
      typeErr.value = '';
      status.value.text = '';
      statusErr.value = '';
      landmarks.value.text = '';
      landmarksErr.value = '';
      longitude.text = '';
      longitudeErr.value = '';
      latitude.text = '';
      latitudeErr.value = '';
      upgradeAmount.text = '';
      upgradeAmountErr.value = '';
      subject.text = '';
      subjectErr.value = '';
      message.text = '';
      messageErr.value = '';
      rating.text = '';
      ratingErr.value = '';

      homeSearch.text = '';
      homeSearchErr.value = '';
      exploreSearch.text = '';
      exploreSearchErr.value = '';

      filterState.value.text = '';
      filterCity.value.text = '';
      filterLandMark.value.text = '';
      priceMin.value.text = '';
      priceMax.value.text = '';
      roomMin.value.text = '';
      roomMax.value.text = '';
      bathsMin.value.text = '';
      bathsMax.value.text = '';
      webSearchKeyWord.text = '';
      filterCategoriesWeb.value.text = '';
      features.value=[];
      // ctrlList = [];
      // ctrlListKeys = [];
      amenities.value = [];

      acceptTerms.value = false;

      imageFiles.value = <File>[];
      image8Lists.value = <Uint8List>[];
    } catch (e, t) {
      dnd(e);
    }
  }
}

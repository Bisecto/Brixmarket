import 'package:brixmarket/controllers/edit_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/instance.dart';
import '../utils/utils.dart';
import '../view/screens/mobile/account_page.dart';
import '../view/screens/mobile/explore_page.dart';
import '../view/screens/mobile/home_page.dart';
import '../view/screens/mobile/saved_page.dart';
import 'states.dart';

class Lst {
  static final priceDurations = ['Outright', 'Per Year', 'Per Month', 'Per Week', 'Per Day'];
  static final propertyTypes = ['Sale', 'Rent', 'Short stay','Lease'];
  static final propertyStatus = ['New', 'Existing', 'Renovated'];
  static final propertyCategories = ['House', 'Land', 'Commercial', 'Student Hostel', 'New Home'];
  static final Map<String, RxList> filterMap = {'category': EditCtrl.filterCategories, 'type': EditCtrl.filterTypes, 'status': EditCtrl.filterStatus};
  static final genders = ['Male', 'Female', 'Others'];
  static final idTypes = ['National id', 'International passport', 'Voter card'];

  static const List<String> propertyDetailTitle = ['Property Details', 'Amenities', 'Reviews'];

  static final ngLGA = ngnLga;
  static final ngStates = ngnStates;

  static final List<Step> stepItems = [
    Step(Icons.description, 'Description'),
    Step(Icons.image, 'Media'),
    Step(Icons.location_on, 'Location'),
    Step(Icons.movie_creation, 'More Details'),
    Step(Icons.perm_device_information, 'Amenities'),
    Step(Icons.description, 'Description'),
    Step(Icons.contact_phone_outlined, 'Contact'),
  ];

  static List<AccountCard> accountCards = [
    const AccountCard(Icons.person, "Personal Information", 'Some random string to be shown here'),
    AccountCard(Icons.account_box_outlined, user.isUser == true ? 'Personal Information' : 'Basic Information', 'Some random string to be shown here'),
    const AccountCard(Icons.document_scanner, "Agency Information", 'Some random string to be shown here'),
    const AccountCard(Icons.balance, "Legal Documentation", 'Some random string to be shown here'),
    const AccountCard(Icons.location_on, "Location Information", 'Some random string to be shown here'),
    const AccountCard(Icons.featured_video_outlined, "Identity Document", 'Some random string to be shown here'),
    const AccountCard(Icons.app_settings_alt, "Notifications Settings", 'Some random string to be shown here'),
    const AccountCard(Icons.security_outlined, "Change Password", 'Some random string to be shown here'),
  ];

  static List pricing = [
    UpgradePlans('Free', 0, 'This plan is good for a start', ['Property upload 5', 'Duration', 'Feature listing 0']),
    UpgradePlans('Pro', 15000, 'This plan is good for a start. choose this plan if you want more', ['Property upload 5', 'Duration', 'Feature listing 0']),
    UpgradePlans('Premium', 75000, 'This plan is good for a start', ['Property upload 5', 'Duration', 'Feature listing 0']),
  ];

  static final List<Tab> myPropertyTabs = [
    const Tab(child: Padding(padding: EdgeInsets.only(top: 12.0), child: SizedBox(width: 100, child: Center(child: Text(PublishedState.all))))),
    const Tab(child: Padding(padding: EdgeInsets.only(top: 12.0), child: SizedBox(width: 100, child: Center(child: Text(PublishedState.publish))))),
    const Tab(child: Padding(padding: EdgeInsets.only(top: 12.0), child: SizedBox(width: 100, child: Center(child: Text(PublishedState.draft))))),
    const Tab(child: Padding(padding: EdgeInsets.only(top: 12.0), child: SizedBox(width: 100, child: Center(child: Text(PublishedState.sold))))),
    const Tab(child: Padding(padding: EdgeInsets.only(top: 12.0), child: SizedBox(width: 100, child: Center(child: Text(PublishedState.suspended))))),
  ];

  static final List<Tab> myPropertyIconTabs = [
    const Tab(child: Padding(padding: EdgeInsets.only(top: 12.0, left: 8, right: 8), child: Text(PublishedState.all))),
    const Tab(child: Padding(padding: EdgeInsets.only(top: 12.0, left: 8, right: 8), child: Icon(Icons.published_with_changes, size: 18, color: Colors.blueGrey))),
    const Tab(child: Padding(padding: EdgeInsets.only(top: 12.0, left: 8, right: 8), child: Icon(Icons.mode_edit_outline_outlined, size: 18, color: Colors.blueGrey))),
    const Tab(child: Padding(padding: EdgeInsets.only(top: 12.0, left: 8, right: 8), child: Icon(Icons.sell_outlined, size: 18, color: Colors.blueGrey))),
    const Tab(child: Padding(padding: EdgeInsets.only(top: 12.0, left: 8, right: 8), child: Icon(Icons.contact_support_sharp, size: 18, color: Colors.blueGrey))),
  ];

  static List<String> minFilterPrices = [
    Utils.amount(0),
    Utils.amount(10000),
    Utils.amount(50000),
    Utils.amount(100000),
    Utils.amount(500000),
    Utils.amount(1000000),
    Utils.amount(2000000),
    Utils.amount(3000000),
    Utils.amount(5000000),
    Utils.amount(10000000),
  ];

  static List<String> maxFilterPrices = [
    Utils.amount(10000),
    Utils.amount(50000),
    Utils.amount(100000),
    Utils.amount(500000),
    Utils.amount(1000000),
    Utils.amount(2000000),
    Utils.amount(3000000),
    Utils.amount(5000000),
    Utils.amount(10000000),
    Utils.amount(20000000),
    Utils.amount(30000000),
    Utils.amount(50000000),
    Utils.amount(900000000) + '+',
  ];

  static final List<Widget> mobileHomeWidgets = <Widget>[
    const MobileHomePage(),
    const ExplorePage(),
    SavedPages(),
    const AccountPage(),
  ];

  static var faqs = [
    FAQ('How can I buy a property with ease', 'Click the "Explore" button and select from our extensive list of properties (for sale).'),
    FAQ('Do I need an account to explore',
        'No you do not, you can brows through our list of properties without signing up, but you would need an account to buy, sell, rent etc.'),
    FAQ('How do I reset my password', 'Click the "Forgot password" link and follow the steps to reset your password.'),
    FAQ('How many properties can I save in my list', 'You can save as many properties as you want on your saved list'),
    FAQ('How many accounts can I have', 'One, you only need one account to access all app features.'),
    FAQ('How do I change my profile picture',
        'Click the "My Accounts" button on the bottom right of the app, and navigate to my profile, then go to personal information.'),
    FAQ('How do I change my phone number', 'Click the "My Accounts" button on the bottom right of the app, and navigate to my profile, then go to personal information.'),
    FAQ('How do I turn on/off notifications', 'Click "My Accounts" button on the bottom right of the app, and navigate to notifications'),
    FAQ('How many ads can I place at a time', 'You can place as many ads as you want.'),
    FAQ('How do I log out', 'Navigate to "My Accounts" scroll down to log out'),
    FAQ('How can I change my profile name', 'Navigate to "My Accounts" button on the bottom right of the app, select my profile, then go to personal information'),
  ];
}

class PublishedState {
  static const String all = 'All';
  static const String publish = 'Published';
  static const String draft = 'Draft';
  static const String sold = 'Sold';
  static const String suspended = 'Suspended';
  static const String delete = 'Deleted';
  static const Map<String, Color> colors = {
    all: Colors.transparent,
    publish: Colors.green,
    draft: Colors.black26,
    sold: Colors.blueAccent,
    suspended: Colors.red,
    delete: Colors.red
  };
}

class Step {
  final IconData icon;
  final String label;

  Step(this.icon, this.label);
}

class AccountCard {
  final IconData icon;
  final String title;
  final String subTitle;

  const AccountCard(this.icon, this.title, this.subTitle);
}

class UpgradePlans {
  final String title;
  final int amount;
  final String description;
  final List<String> features;

  UpgradePlans(this.title, this.amount, this.description, this.features);
}

class FAQ {
  String? question;
  String? answer;

  FAQ(this.question, this.answer);

  FAQ.fromJson(json) {
    question = json['question'] ?? '';
    answer = json['answer'] ?? '';
  }
}

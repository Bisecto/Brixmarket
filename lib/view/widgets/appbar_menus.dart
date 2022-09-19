import 'package:brixmarket/core/preloader.dart';
import 'package:brixmarket/res/strings.dart';
import 'package:brixmarket/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/instance.dart';
import '../../models/property_model.dart';
import '../../res/lists.dart';

class AppBarMenu extends StatelessWidget {
  final bool login;
  final bool logout;
  final bool myAccount;
  final bool clearSave;
  final bool saveDraft;
  final Widget? child;
  const AppBarMenu({Key? key, this.login = false, this.logout = true, this.myAccount = true, this.clearSave = false, this.saveDraft = false, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        child: child,
        itemBuilder: (context) {
          var menuItems = <PopupMenuItem>[];
          if (saveDraft) {
            menuItems.add(const PopupMenuItem<int>(value: 0, child: Text("Save as Draft")));
          }
          if (clearSave) {
            menuItems.add(const PopupMenuItem<int>(value: 1, child: Text("Clear Saved")));
          }
          if (myAccount) {
            menuItems.add(const PopupMenuItem<int>(value: 2, child: Text("My Account")));
          }
          if (login) {
            menuItems.add(const PopupMenuItem<int>(value: 3, child: Text("Sign In")));
          }
          if (logout) {
            menuItems.add(const PopupMenuItem<int>(value: 4, child: Text("Logout")));
          }
          return menuItems;
        },
        onSelected: (value) {
          if (value == 0) {
            Preloader.show();
            Future.delayed(const Duration(seconds: 1)).whenComplete(() {
              cPropCtrl.saveToDraft = true;
              cPropCtrl.createPropPageIndex.value = 0;
              Preloader.hide();
              Get.back();
            });
          } else if (value == 1) {
            //Todo: Clear save items
            print("My account menu is selected.");
          } else if (value == 2) {
            Utils.isMobileApp ? Get.offAndToNamed(RouteStr.mobileLanding) : Get.toNamed(RouteStr.webDashboard);
          } else if (value == 3) {
            homeCtrl.loginRequest(request: () {});
          } else if (value == 4) {
            homeCtrl.logout();
          }
        });
  }
}

class MyPropertyMenu extends StatelessWidget {
  final bool markSold;
  final bool republish;
  final bool edit;
  final bool delete;
  final Property property;
  const MyPropertyMenu({Key? key, this.markSold = false, this.republish = false, this.edit = false, this.delete = false, required this.property}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(itemBuilder: (context) {
      var menuItems = <PopupMenuItem>[];
      if (markSold) {
        menuItems.add(PopupMenuItem<int>(
            value: 0,
            child: Row(
              children: const [
                Icon(Icons.sell_outlined),
                SizedBox(width: 8),
                Text("Mark as Sold"),
              ],
            )));
      }
      if (republish) {
        menuItems.add(PopupMenuItem<int>(
            value: 1,
            child: Row(
              children: const [
                Icon(Icons.published_with_changes),
                SizedBox(width: 8),
                Text("Republish"),
              ],
            )));
      }
      if (edit) {
        menuItems.add(PopupMenuItem<int>(
            value: 2,
            child: Row(
              children: const [
                Icon(Icons.mode_edit_outline_outlined),
                SizedBox(width: 8),
                Text("Edit"),
              ],
            )));
      }
      if (delete) {
        menuItems.add(PopupMenuItem<int>(
            value: 3,
            child: Row(
              children: const [
                Icon(Icons.delete_outline),
                SizedBox(width: 8),
                Text("Delete"),
              ],
            )));
      }
      return menuItems;
    }, onSelected: (value) {
      if (value == 0) {
        cPropCtrl.changePublishState(property: property, state: PublishedState.sold);
      } else if (value == 1) {
        cPropCtrl.changePublishState(property: property, state: PublishedState.publish);
      } else if (value == 2) {
        cPropCtrl.completeDraftProperty(property);
      } else if (value == 3) {
        cPropCtrl.changePublishState(property: property, state: PublishedState.delete);
      }
    });
  }
}

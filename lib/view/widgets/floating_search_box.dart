import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'material_search_bar/src/floating_search_bar.dart';
import 'material_search_bar/src/floating_search_bar_transition.dart';

Widget buildFloatingSearchBar() {
  final _scrollController = ScrollController();
  return FloatingSearchBar(
    hint: 'Country, City, Town or Area',
    scrollPadding: const EdgeInsets.only(top: 0, bottom: 56),
    transitionDuration: const Duration(milliseconds: 0),
    transitionCurve: Curves.slowMiddle,
    borderRadius: BorderRadius.circular(4),
    automaticallyImplyBackButton: false,
    automaticallyImplyDrawerHamburger: false,
    physics: const BouncingScrollPhysics(),
    axisAlignment: 0.0,
    openAxisAlignment: 0.0,
    width: Get.width,
    height: 42,
    backdropColor: Colors.transparent,
    debounceDelay: const Duration(milliseconds: 500),
    onSubmitted: (value) {
      // printError(info: 'i have submitted you');
    },
    onQueryChanged: (query) {
      //Todo: Get search text to query
    },
    transition: CircularFloatingSearchBarTransition(),
    builder: (context, transition) {
      return ClipRRect(
        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
        child: Material(
            color: Colors.white,
            elevation: 8.0,
            shadowColor: Colors.black54,
            type: MaterialType.card,
            child: SizedBox(
              height: 170,
              child: Scrollbar(
                controller: _scrollController,
                isAlwaysShown: true,
                interactive: true,
                thickness: 10,
                radius: const Radius.circular(12),
                child: ListView.builder(
                    controller: _scrollController,
                    shrinkWrap: true,
                    // itemCount: mainData.length,
                    itemBuilder: (_, int i) {
                      return Container(
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.blueGrey, width: 0.2))),
                        // child: Text(mainData[i])
                      );
                    }),
              ),
            )),
      );
    },
  );
}

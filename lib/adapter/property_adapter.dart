import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:brixmarket/models/filter_property_model.dart';
import 'package:brixmarket/controllers/edit_controller.dart';
class PropertyApi {

  final StreamController<FilterModel> getfilterProperty = StreamController();
  Future<void> getProperty(int page,{String searchValue='',String location=''}) async {
    if(location.length>0){
    EditCtrl.filterState.value.text=location;}
    var Url = Uri.parse('https://api.brixmarket.com/property/filter-properties?page=$page');
    var body={
      'search_term': searchValue==''?EditCtrl.webSearchKeyWord.value.text:searchValue,
      'min_price': EditCtrl.priceMin.value.text,
      'max_price': EditCtrl.priceMax.value.text,
      'min_room': EditCtrl.roomMin.value.text,
      'max_room': EditCtrl.roomMax.value.text,
      'min_bath': EditCtrl.bathsMin.value.text,
      'max_bath': EditCtrl.bathsMax.value.text,
      'state': EditCtrl.filterState.value.text,
      'city': EditCtrl.filterCity.value.text,
      'landmark': EditCtrl.filterLandMark.value.text,
      'category[0]': EditCtrl.filterCategories[0],
      'type[0]': EditCtrl.filterTypes[0],
      'status[0]': EditCtrl.filterStatus[0],
      'amenity[0]': EditCtrl.filterAmenities[0],
      'nav_item': '0'
    };
    var headers = {
      'Authorization': 'Bearer kOoT3jVQAK73GAsRrftjnnXzXS6o7lfLi9iMENmJOx1nYbDPgaiqk7vs5lEpfXg4LMF+wFZWWommwTf1CrqTU1ZZz/my4WZxuReq/uDdBIs=dodroosos',
      'Cookie': 'PHPSESSID=efe427461bf8353458f882c0d7143ce3'
    };
    final res =
    await http.post(Url,headers: headers,body: body);
    final dataBody = await jsonDecode(res.body);
    FilterModel filterModel = FilterModel.fromJson(dataBody);
    getfilterProperty.add(filterModel);
  }

}
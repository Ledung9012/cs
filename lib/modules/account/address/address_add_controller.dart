import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mobile/instance/templace_instance.dart';
import 'package:mobile/instance/user_instance.dart';
import 'package:mobile/models/address.dart';
import 'package:mobile/modules/account/address/address_provider.dart';

enum AddressAddType {
  NONE,
  CREATE,
  UPDATE,
}

class AddressAddController extends GetxController {
  AddressItem _province = AddressItem.empty();
  AddressItem _district = AddressItem.empty();
  AddressItem _ward = AddressItem.empty();
  AddressItem _street = AddressItem.empty();
  String _description = "";

  TextEditingController nameEdit = TextEditingController();
  TextEditingController phoneEdit = TextEditingController();
  TextEditingController provinceEdit = TextEditingController();
  TextEditingController districtEdit = TextEditingController();
  TextEditingController wartEdit = TextEditingController();
  TextEditingController descriptionEdit = TextEditingController();

  Address _address = Address();

  Address get address => _address;

  set address(Address value) {
    _address = value;
    province = value.province();
    district = value.district();
    ward = value.ward();
    descriptionEdit.text = value.description;
    phoneEdit.text = value.phone;
    nameEdit.text = value.name;
  }

  get province => _province;

  set province(value) {
    _province = value;
    provinceEdit.text = value.name;
  }

  get district => _district;

  set district(value) {
    _district = value;
    districtEdit.text = value.name;
  }

  get ward => _ward;

  set ward(value) {
    _ward = value;
    wartEdit.text = value.name;
  }

  get street => _street;

  set street(value) {
    _street = value;
  }

  get description => _description;

  set description(value) {
    _description = value;
    descriptionEdit.text = value;
  }

  void accept(
      {required AddressAddType addType,
      required Function(Address) onSuccess,
      required Function(String) onError}) {
    if (nameEdit.text.isEmpty) {
      onError("Vui l??ng nh???p t??n ng?????i nh???n.");
      return;
    }

    if (phoneEdit.text.isEmpty) {
      onError("Vui l??ng nh???p s??? ??i???n tho???i.");
      return;
    }

    if (_province.isEmpty) {
      onError("Vui l??ng ch???n t???nh th??nh.");
      return;
    }

    if (_district.isEmpty) {
      onError("Vui l??ng ch???n qu???n/huy???n.");
      return;
    }

    if (_ward.isEmpty) {
      onError("Vui l??ng ch???n ph?????ng/ x??.");
      return;
    }

    if (descriptionEdit.text.isEmpty) {
      onError("Vui l??ng nh???p s??? nh??, ???????ng.");
      return;
    }

    var request = Address();
    request.userId = userInstance.userId;

    request.provinceId = _province.id;
    request.districtId = _district.id;
    request.wardId = _ward.id;
    request.name = nameEdit.text;
    request.phone = phoneEdit.text;
    request.description = descriptionEdit.text;



    request.display = _description +
        ", " +
        _ward.display() +
        ", " +
        _district.display() +
        ", " +
        _province.display();

    if (addType == AddressAddType.NONE) {



      request.wardName = _ward.display() ;
      request.districtName = _district.display();
      request.provinceName = _province.display() ;


      onSuccess(request);
      Get.back();
    }

    if (addType == AddressAddType.CREATE) {
      AddressProvider.add(
          request: request,
          success: () {
            Template.dialogInfoAction("Th??m m???i ?????a ch??? th??nh c??ng", () {
              Get.back();
              onSuccess(request);
            });
          },
          onError: (error) {});
    }

    if (addType == AddressAddType.UPDATE) {
      request.id = address.id;
      AddressProvider.update(
          request: request,
          success: () {
            Template.dialogInfoAction("C???p nh???t ?????a ch??? th??nh c??ng", () {
              Get.back();
              onSuccess(request);
            });
          },
          onError: (error) {});
    }
  }

  void clear() {}

  void delete({required int id, required Function onSuccess}) {
    AddressProvider.deleteItem(
        id: id,
        success: () {
          onSuccess();
        },
        onError: (error) {});
  }
}

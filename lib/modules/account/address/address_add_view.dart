import 'package:diacritic/diacritic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/instance/templace_instance.dart';
import 'package:mobile/models/address.dart';
import 'package:mobile/modules/account/address/address_add_controller.dart';
import 'package:mobile/modules/account/address/address_provider.dart';
import 'package:mobile/services/services.dart';

class AddressAddView extends GetView<AddressAddController> {
  AddressAddType? addState = AddressAddType.NONE;
  Address? item;
  Function(Address) onComplete;

  AddressAddView({required this.onComplete, this.addState, this.item});

  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Template.primaryColor),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: Template.appBar(getTitlte(), child: [
          deleteUI(),
        ]),
        body: content(),
      ),
    );
  }

  Widget deleteUI() {
    if (addState == AddressAddType.UPDATE) {
      return GestureDetector(
          onTap: () {
            controller.delete(
                id: item!.id,
                onSuccess: () {
                  Template.dialogInfoAction("Xoá thành công", () {
                    Get.back();
                    onComplete(item!);
                  });
                });
          },
          child: Container(
              width: 40,
              height: 40,
              child: Icon(
                Icons.delete_outline_outlined,
                size: 24,
              )));
    }
    return Container();
  }

  Widget content() {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(left: 16, right: 16, top: 24),
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.only(bottom: 12),
                child: TextField(
                  enableSuggestions: false,
                  keyboardType: TextInputType.visiblePassword,
                  autocorrect: false,
                  controller: controller.nameEdit,
                  decoration: inputDeco("Tên người nhận"),
                )),
            Container(
                margin: EdgeInsets.only(bottom: 12),
                child: TextField(
                  controller: controller.phoneEdit,
                  decoration: inputDeco("Số điện thoại"),
                )),
            Container(
                margin: EdgeInsets.only(bottom: 12),
                child: TextField(
                  showCursor: true,
                  readOnly: true,
                  controller: controller.provinceEdit,
                  onTap: () {
                    Get.bottomSheet(
                      SelectItemView(
                        id: -1,
                        function: APIFunction.ADDRESS_PROVINCE,
                        complete: (item) {
                          controller.province = item;
                        },
                      ),
                      isScrollControlled: true,
                      ignoreSafeArea: false,
                    );
                  },
                  decoration: inputDeco("Tỉnh thành"),
                )),
            Container(
              margin: EdgeInsets.only(bottom: 12),
              child: TextField(
                showCursor: true,
                readOnly: true,
                controller: controller.districtEdit,
                onTap: () {
                  Get.bottomSheet(
                    SelectItemView(
                      id: controller.province.id,
                      function: APIFunction.ADDRESS_DISTRICT,
                      complete: (item) {
                        controller.district = item;
                      },
                    ),
                    isScrollControlled: true,
                    ignoreSafeArea: false,
                  );
                },
                decoration: inputDeco("Quận / Huyện"),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 12),
              child: TextField(
                showCursor: true,
                readOnly: true,
                controller: controller.wartEdit,
                onTap: () {
                  Get.bottomSheet(
                    SelectItemView(
                      id: controller.district.id,
                      function: APIFunction.ADDRESS_WARD,
                      complete: (item) {
                        controller.ward = item;
                      },
                    ),
                    isScrollControlled: true,
                    ignoreSafeArea: false,
                  );
                },
                decoration: inputDeco("Phường / Xã"),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 12),
              child: TextField(
                onChanged: (value) {},
                controller: controller.descriptionEdit,
                decoration: inputDeco("Số nhà, đường"),
              ),
            ),
            acceptView()
          ],
        ),
      ),
    );
  }

  String getTitlte() {
    if (addState! == AddressAddType.NONE) {
      return "Địa chỉ Giao hàng";
    } else if (addState! == AddressAddType.CREATE) {
      return "Tạo Mới Địa chỉ ";
    } else if (addState! == AddressAddType.UPDATE) {
      return "Cập nhật địa chỉ";
    }
    return "";
  }

  Widget acceptView() {
    return Container(
      height: 48,
      width: double.infinity,
      child: TextButton(
        child: Text("Xác Nhận"),
        onPressed: () {
          controller.accept(
              addType: this.addState!,
              onSuccess: (value) {
                onComplete(value);
              },
              onError: (error) {
                Template.dialogError(error);
              });
        },
        style: Template.primaryButtonStyle,
      ),
    );
  }

  InputDecoration inputDeco(String label) {
    return InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(4.0),
          ),
        ),
        filled: true,
        labelText: label,
        hintStyle: TextStyle(color: Colors.grey[800]),
        fillColor: Colors.white70);
  }
}

class SelectItemView extends StatefulWidget {
  APIFunction function = APIFunction.ADDRESS_PROVINCE;
  int id = -1;

  SelectItemView(
      {required this.id, required this.function, required this.complete});

  Function(AddressItem) complete;

  @override
  _SelectItemViewState createState() => _SelectItemViewState();
}

class _SelectItemViewState extends State<SelectItemView> {
  @override
  void initState() {
    loadData();
    super.initState();
  }

  var product = [];

  var searchs = [];

  void loadData() {
    AddressProvider.item(
        id: widget.id,
        func: widget.function,
        success: (value) {
          product.addAll(value);
          searchs.addAll(value);

          setState(() {});
        },
        onError: (error) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blue.withOpacity(0),
      body: Column(
        children: [
          Container(
            height: 240,
          ),
          Expanded(
              child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8), topRight: Radius.circular(8)),
            child: Container(
              color: Colors.white,
              child: Column(
                children: [searchView(), Expanded(child: listView())],
              ),
            ),
          ))
        ],
      ),
    );
  }

  Widget listView() {
    return ListView.builder(
        itemCount: searchs.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              widget.complete(searchs[index]);
              Get.back();
            },
            child: Container(
              padding: EdgeInsets.only(left: 16, bottom: 12, top: 12),
              child: Text(
                searchs[index].display(),
                style: TextStyle(fontSize: 16),
              ),
            ),
          );
        });
  }

  Widget searchView() {
    if (widget.function == APIFunction.ADDRESS_PROVINCE) {
      return Container(
        color: Colors.white,
        child: Container(
          margin: EdgeInsets.only(left: 16, right: 16, top: 16),
          child: Row(
            children: [
              Flexible(
                child: Container(
                  height: 48,
                  child: TextField(
                    onChanged: (text) {
                      String input =
                          removeDiacritics(text.toLowerCase()).trim();
                      searchs = product
                          .where((f) =>
                              removeDiacritics(f.name.toString().toLowerCase())
                                  .contains(input))
                          .toList();

                      setState(() {});
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.redAccent, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(
                              color: Colors.black.withOpacity(0.2), width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(
                            color: Colors.black.withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                        contentPadding: EdgeInsets.only(bottom: 0, top: 0),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[800]),
                        hintText: "Nhập tên tỉnh thành.",
                        prefixIcon: Icon(Icons.search),
                        fillColor: Colors.white70),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return Container();
  }
}

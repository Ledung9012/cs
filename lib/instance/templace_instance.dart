import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

const PrimaryColor = Color(0xFF0DB34C);

class Template {
  static final headerStyle =
      TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold);

  static final testImage =
      "https://quatangphuthinh.com/wp-content/uploads/2020/02/z2240219810884_860a8abb7abc788e71a147d9dbaba257.jpg";

  static final backButtonStyle = ElevatedButton.styleFrom(
      shadowColor: Colors.black54,
      primary: Colors.black26, //
      onPrimary: Colors.white);

  static final primaryButtonStyle = ElevatedButton.styleFrom(
    primary: HexColor.fromHex("0DB34C"), //
    onPrimary: Colors.white, // foreground
  );

  static final primaryButtonSimpleStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.black, // foreground
  );

  static final lineButtonStyle = ElevatedButton.styleFrom(
    primary: HexColor.fromHex("0DB34C"), //
    onPrimary: Colors.white, // foreground
  );

  static final subButtonStyle = ElevatedButton.styleFrom(
    primary: Colors.black26, //
    onPrimary: Colors.white, // foreground
  );

  //------------------------------------------------------Color
  static Color primaryColor = HexColor.fromHex("0DB34C"); //
  static Color primaryTextColor = HexColor.fromHex("119442"); //

  static Color backgroundColor = HexColor.fromHex("F3F3F3"); // Màu nền

  static Color errorColor = Colors.red;
  static Color disableColor = Colors.black26;
  static Color subColor = Colors.black54; // Màu chữ phụ

  //------------------------------------------------------Content
  final Color subTextColor = Colors.black54; // Màu chữ phụ
  final Color priceColor = Colors.redAccent; // Màu giá sản phẩm

  //------------------------------------------------------Snack Bar
  static void snackError(String messsage) {
    snackSuccessDuration(messsage, 3, errorColor);
  }

  static AppBar appBar(String title, {List<Widget>? child}) {
    List<Widget> items = [];

    items.addAll([
      GestureDetector(
          onTap: () => Get.back(), child: Icon(Icons.arrow_back_ios_rounded)),
      SizedBox(
        width: 12,
      ),
      Expanded(child: Text(title.capitalize!))
    ]);

    if (child != null) {
      items.addAll(child);
    }
    return AppBar(
      elevation: 0,
      centerTitle: false,
      title: Row(
        children: items,
      ),
    );
  }

  static Widget sliderAppBar(
      {required String title,
      required List<String> items,
      required List<Widget> menu}) {
    print("tabar item tesst : ${items.length}");

    List<Widget> internalHeader = [];
    Icon icon = Icon(Icons.post_add);
    Widget expand = Expanded(child: Container());
    internalHeader.add(Text(title.toUpperCase()));
    internalHeader.add(expand);
    internalHeader.addAll(menu);
    return SliverAppBar(
      elevation: 0,
      centerTitle: false,
      title: Row(
        children: internalHeader,
      ),
      floating: true,
      pinned: true,
      snap: true,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(36),
        child: Align(
          alignment: Alignment.centerLeft,
          child: TabBar(
            indicatorPadding: EdgeInsets.only(bottom: 4),
            labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            unselectedLabelStyle:
                TextStyle(fontSize: 16, fontWeight: FontWeight.normal),

            isScrollable: true,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Colors.white,
            tabs: items
                .map((item) => Container(
                    margin: EdgeInsets.only(bottom: 12), child: Text(item)))
                .toList(), // <-- total of 2 tabs
          ),
        ),
      ),
    );
  }

  static void snackSuccess(String messsage) {
    snackSuccessDuration(messsage, 3, primaryColor);
  }

  static void dialogError(String messsage) {
    dialog("LỖI", messsage, Colors.red, () {});
  }

  static void dialogErrorAction(String messsage, Function complete) {
    dialog("LỖI", messsage, Colors.red, complete);
  }

  static void dialogInfo(String messsage) {
    dialog("THÔNG BÁO", messsage, Template.primaryColor, () {});
  }

  static void dialogInfoAction(String messsage, Function complete) {
    dialog("THÔNG BÁO", messsage, Template.primaryColor, complete);
  }

  static void dialogInfoList(
      String messsage, List<String> action, Function(int) complete) {
    dialog2("THÔNG BÁO", messsage, Template.primaryColor, action, complete);
  }

  static void dialog2(String title, String messsage, Color color,
      List<String> action, Function(int) complete) {
    List<Widget> widgetList = [];
    for (var i = 0; i < action.length; i++) {
      widgetList.add(Expanded(
        child: TextButton(
          style: Template.primaryButtonSimpleStyle,
          onPressed: () {
            Get.back();

            complete(i);
          },
          child: Text(action[i]),
        ),
      ));

      if (i < (action.length - 1)) {
        widgetList.add(Container(
          height: 54,
          width: 1,
          color: Colors.black.withOpacity(0.1),
        ));
      }
    }

    var info = Container(
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.2)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              color: Colors.white,
              width: 320,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 60,
                    color: color,
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        title,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(
                        top: 36, left: 12, bottom: 36, right: 12),
                    child: Text(
                      messsage,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(
                                color: Colors.black.withOpacity(0.1)))),
                    height: 54,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: widgetList,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
    Get.dialog(info);
  }

  static void dialog(
      String title, String messsage, Color color, Function complete) {
    var info = Container(
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.2)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              color: Colors.white,
              width: 320,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 60,
                    color: color,
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        title,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(
                        top: 36, left: 12, bottom: 36, right: 12),
                    child: Text(
                      messsage,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(
                                color: Colors.black.withOpacity(0.1)))),
                    height: 54,
                    width: double.infinity,
                    child: TextButton(
                      style: Template.primaryButtonSimpleStyle,
                      onPressed: () {
                        Get.back();
                        complete();
                        print("Close Dialog");
                      },
                      child: Text("Đóng"),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
    Get.dialog(info);
  }

  static void snackSuccessDuration(
      String messsage, int durationSecond, Color bgColor) {
    Get.snackbar("Thông báo", messsage,
        backgroundColor: bgColor,
        colorText: Colors.white,
        margin: EdgeInsets.only(top: 0, left: 0, right: 0),
        barBlur: 0.5,
        borderRadius: 0,
        animationDuration: Duration(seconds: 0),
        snackStyle: SnackStyle.FLOATING,
        duration: Duration(seconds: durationSecond));
  }
}

extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

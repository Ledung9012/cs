import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/instance/templace_instance.dart';
import 'package:mobile/modules/stores/store_detail/store_detail_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class StoreDetailView extends GetView<StoreDetailController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build


    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
            width: double.infinity,
            color: Template.primaryColor,
            child: SafeArea(child: buildWebView())),
      ),
    );
  }

  Widget buildWebView() {






    print("StoreDetailView ---------${controller}");
    return Column(
      children: [
        Expanded(
            child: Container(
              child: WebView(
                initialUrl: controller.item.url,
                javascriptMode: JavascriptMode.unrestricted,
                onPageFinished: (value ){

                },
                onPageStarted: (value){

                },

                onProgress: (value){

                },
                onWebViewCreated: (value){

                },
                onWebResourceError: (error){

                },
              ),
            )),
        Container(
          height: 48,
          color: Template.primaryColor,
          child: Row(
            children: [
              GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 0),
                    child: TextButton(
                      onPressed: (){
                        Get.back();
                      },
                      child: Icon(
                        Icons.home,
                        color: Colors.white,
                      ),
                    ),
                  )),
              Expanded(child: SizedBox()),
              TextButton(onPressed: (){

                controller.info();

              }, child: Icon(Icons.info_outline_rounded,color: Colors.white,))
            ],
          ),
        )
      ],
    );
  }
}

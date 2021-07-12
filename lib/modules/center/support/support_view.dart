import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/instance/templace_instance.dart';
import 'package:mobile/modules/center/support/support_controller.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class SupportView extends GetView<SupportController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false, // set it to false
      body: buildContent(),
    );
  }

  Widget buildContent() {
    return Container(
      child: Obx(() {
        return Container(
          child: ListView.builder(
              itemCount: controller.userLength,
              itemBuilder: (context, index) {
                return item(index);
              }),
        );
      }),
    );
  }

  Future callNumber(String number) async{
    bool? res = await FlutterPhoneDirectCaller.callNumber("0971568901");
    return res ;
  }

  Widget item(int index) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Container(
            height: 48,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {

                callNumber(controller.item(index).phone).then((value) {

                  print("call in");
                }).onError((error, stackTrace){
                  print("call in error  $error");

                });

              },
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 16, right: 16),
                    width: 48,
                    height: 48,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: CachedNetworkImage(
                          imageUrl: controller.item(index).avatar,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                        child: Text(
                          controller.item(index).name ,
                          style: TextStyle(fontSize: 18),
                        )),
                  ),

                  Container(padding: EdgeInsets.only(right: 24),child:  Icon(Icons.phone_forwarded_rounded,color: Template.subColor.withOpacity(0.5),),)

                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 16, right: 16),
            child: Divider(
              color: Template.subColor.withOpacity(0.2),
              height: 30,
            ),
          )
        ],
      ),
    );
  }
}

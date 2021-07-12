import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/instance/templace_instance.dart';
import 'package:mobile/modules/center/contact/contact_controller.dart';

class ContactView extends GetView<ContactController> {
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
      padding: EdgeInsets.all(16),
      child: Column(
        children: [

          item(Icon(
            Icons.home_rounded,
            color: Template.primaryColor,
          ), "Công ty trách nhiệm hữu hạn Cuốc Sống Tươi Đẹp, số 4/37 Văn Chung, phường 13, quận Tân Bình, Hồ Chí Minh"),
          item(Icon(
            Icons.perm_phone_msg,
            color: Template.primaryColor,
          ), "(+84) 971568901"),
          item(Icon(
            Icons.email,
            color: Template.primaryColor,
          ), "Cuocsongtuoidep@gmail.com")


        ],
      ),
    );
  }

  Widget item(Icon icon, String des){

   return  Container(
     margin: EdgeInsets.only(top: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container( child: icon,),
          Flexible(
              child: Container(
                margin: EdgeInsets.only(left: 12),
                child: Text(des,style: TextStyle(fontSize: 16),),
              ))
        ],
      ),
    );
  }
}

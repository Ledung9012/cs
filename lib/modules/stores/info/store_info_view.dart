import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/instance/templace_instance.dart';
import 'package:mobile/models/store.dart';
import 'package:mobile/modules/stores/info/store_info_controller.dart';

class StoreInfoView extends GetView<StoreInfoController> {

  Store store ;


  StoreInfoView({required this.store});

  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8), topRight: Radius.circular(8)),
      child: Container(
        height: 480,
        color: Colors.white,
        child: Column(children: [


          logoView(),

        ],),
      ),
    );
  }


  Widget logoView(){
    return Container(
      child: Row(children: [
        Container(
          width:  120,height: 120 ,
          padding: EdgeInsets.all(16),
          child: CachedNetworkImage(imageUrl: store.imageURL(),) ,
        ),

        Column(children: [
          
          Text(store.name,style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.black.withOpacity(0.8)),),
          
        ],)
      ],),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/instance/templace_instance.dart';
import 'package:mobile/instance/user_instance.dart';

class LigalView extends StatefulWidget {
  @override
  _LigalViewState createState() => _LigalViewState();
}

class _LigalViewState extends State<LigalView> {
  @override
  Widget build(BuildContext context) {
    return contentView(acceptBlock: () {}, cancelBlock: () {});
  }

  Widget contentView(
      {required Function acceptBlock, required Function cancelBlock}) {
    return Container(
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
                    color: Template.primaryColor,
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        "ĐIỀU KHOẢN ĐĂNG BÀI",
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
                        top: 16, left: 16, bottom: 36, right: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        rowText(
                            "1. Thành viên không tạo bài mới có nội dung trùng lặp với bài đã có."),
                        rowText(
                            "2. Không chứa nội dung chế giễu, công kích, dùng từ ngữ thô tục gây xúc phạm và ảnh hưởng đến hình ảnh của cá nhân / tập thể với bất kỳ hình thức nào"),
                        rowText(
                            "3. Nội dung hình ảnh không chứa ngôn từ thô tục, không phù hợp."),
                        rowText(
                            "4. Nội dung phải tương đồng với hình ảnh / sản phẩm đăng tải."),
                        rowText(
                            "5. Không  ăng các sản phẩm vi phạm Pháp luật Việt Nam hoặc bị hạn chế."),
                        acceptView(),
                      ],
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
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextButton(
                          style: Template.primaryButtonSimpleStyle,
                          onPressed: () {
                            Get.back();
                            Get.back();
                          },
                          child: Text(
                            "Đóng",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                        ),
                        TextButton(
                          style: Template.primaryButtonSimpleStyle,
                          onPressed: () {
                            if (userInstance.acceptLigal) {
                              Get.back();
                            }
                          },
                          child: Text(
                            "Đồng Ý",
                            style: TextStyle(
                                color: getColor(),
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color getColor() {
    if (userInstance.acceptLigal) {
      return Colors.black;
    }
    return Colors.black.withOpacity(0.4);
  }

  Icon getIcon() {
    if (!userInstance.acceptLigal) {
      return Icon(Icons.check_box_outline_blank);
    }
    return Icon(
      Icons.check_box_outlined,
      color: Template.primaryColor,
    );
  }

  Widget acceptView() {
    return GestureDetector(
      onTap: () {
        userInstance.acceptLigal = !userInstance.acceptLigal;
        setState(() {});
      },
      child: Container(
        margin: EdgeInsets.only(top: 24),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: 8),
              child: getIcon(),
            ),
            Text(
              "Chấp nhận điều khoản",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }

  static Widget rowText(String value) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      child: Text(
        value,
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}

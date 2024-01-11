import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pijak_app/chat/modules/chat_text/views/widgets/text_card.dart';
import 'package:pijak_app/constants.dart';

import '../../../common/headers.dart';
import '../../../common/search_text_field_widget.dart';
import '../controllers/chat_text_controller.dart';

class ChatTextView extends GetView<ChatTextController> {
  ChatTextView({Key? key}) : super(key: key);
  final ChatTextController controller =
      Get.put(ChatTextController()); // Memasukkan ChatTextController ke GetX

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text(
          'PIJAK AI',
          style: TextStyle(
              color: Colors.white,
              fontFamily: "Poppins",
              fontWeight: FontWeight.bold),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: Obx(() => Column(children: [
            Expanded(
              child: ListView.builder(
                reverse: true,
                itemCount: controller.messages.length,
                itemBuilder: (BuildContext context, int index) {
                  final textData = controller.messages[index];
                  return textData.index == -999999
                      ? MyTextCard(textData: textData)
                      : TextCard(textData: textData);
                },
              ),
            ),
            controller.state.value == ApiState.loading
                ? const Center(child: CircularProgressIndicator())
                : const SizedBox(),
            const SizedBox(height: 12),
            SearchTextFieldWidget(
                color: kPrimaryColor,
                textEditingController: controller.searchTextController,
                onTap: () {
                  controller
                      .getTextCompletion(controller.searchTextController.text);
                }),
            const SizedBox(height: 20),
          ])),
    );
  }
}

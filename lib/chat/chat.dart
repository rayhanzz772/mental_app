import 'package:flutter/material.dart';
import 'package:pijak_app/chat/global_members.dart';
import 'package:pijak_app/constants.dart';
import 'widgets/chat_list_view.dart';
import 'message_data_modal.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  TextEditingController textEditingController = TextEditingController();
  late String senderMessage, receiverMessage;
  ScrollController scrollController = ScrollController();

  Future<void> scrollAnimation() async {
    return await Future.delayed(
      const Duration(milliseconds: 100),
      () => scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.linear,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        leadingWidth: 50.0,
        titleSpacing: -8.0,
        leading: IconButton(
          onPressed: () {
            // Fungsi untuk kembali ke menu home
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back), // Ikon kembali (back icon)
          color: Colors.black, // Warna ikon kembali
        ),
        title: const ListTile(
          title: Text(
            'Anonim',
            style: TextStyle(
              color: Colors.black, // Ganti dengan warna teks yang diinginkan
            ),
          ),
          subtitle: Text(
            'online',
            style: TextStyle(
              color: Colors.black, // Ganti dengan warna teks yang diinginkan
            ),
          ),
        ),
        actions: const [
          Icon(Icons.videocam),
          Padding(
            padding: EdgeInsets.only(right: 20.0, left: 20.0),
            child: Icon(Icons.call),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(child: ChatListView(scrollController: scrollController)),
          Container(
            // height: 50,
            margin: const EdgeInsets.all(8.0),
            decoration: const BoxDecoration(
                shape: BoxShape.rectangle,
                color: Color(0xFF333D56),
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                      left: 8.0, right: 8.0, bottom: 12.0),
                  child: Transform.rotate(
                      angle: 45,
                      child: const Icon(
                        Icons.attach_file_sharp,
                        color: Colors.white,
                      )),
                ),
                Expanded(
                  child: TextFormField(
                    controller: textEditingController,
                    cursorColor: const Color.fromARGB(255, 0, 0, 0),
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 6,
                    style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    decoration: const InputDecoration(
                      hintText: 'Type your message...',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                      left: 8.0, right: 8.0, bottom: 11.0),
                  child: Transform.rotate(
                    angle: -3.14 / 5,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            messageList.add(
                                MessageData(textEditingController.text, true));
                            textEditingController.clear();
                            scrollAnimation();
                          });
                        },
                        onLongPress: () {
                          setState(() {
                            messageList.add(
                                MessageData(textEditingController.text, false));
                            textEditingController.clear();
                            scrollAnimation();
                          });
                        },
                        child: const Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

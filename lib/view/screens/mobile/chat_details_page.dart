import 'package:brixmarket/config/theme/color.dart';
import 'package:brixmarket/core/app.dart';
import 'package:brixmarket/res/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../controllers/edit_controller.dart';
import '../../../controllers/instance.dart';
import '../../../models/chat_message.dart';

class ChatDetailPage extends StatefulWidget {
  const ChatDetailPage({Key? key}) : super(key: key);

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  @override
  void initState() {
    homeCtrl.fetchChatMessages();
    EditCtrl.chatMessage.clear();
    super.initState();
  }
  String quote='"';
  String quote2="'";
  @override
  void dispose() {
    homeCtrl.messageTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // primary: true,
        toolbarHeight: 68,
        elevation: 2,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Pallet.secondaryColor,
                  ),
                ),
                const SizedBox(
                  width: 2,
                ),
                CircleAvatar(
                  backgroundImage:
                      homeCtrl.otherUserImage == '' ? const AssetImage(ImgStr.avatarImg) as ImageProvider : NetworkImage(userImgPath + homeCtrl.otherUserImage),
                  maxRadius: 26,
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        homeCtrl.otherUserName,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      // const SizedBox(
                      //   height: 3,
                      // ),
                      // Text(
                      //   "Online",
                      //   style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                      // ),
                    ],
                  ),
                ),
                // const Icon(
                //   Icons.more_vert_outlined,
                //   color: Pallet.secondaryColor,
                // ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(ImgStr.chatBg), fit: BoxFit.cover)),
        child: Container(
          color: Colors.white.withOpacity(0.7),
          child: Container(
            color: Colors.redAccent.withOpacity(0.15),
            child: Stack(
              children: <Widget>[
                StreamBuilder<List<ChatMessage>?>(
                    stream: homeCtrl.chatMessagesStream,
                    builder: (context, AsyncSnapshot snapshot) {
                      List<ChatMessage> messages = snapshot.data ?? [];
                      return ListView.builder(
                        itemCount: messages.length,
                        controller: homeCtrl.scrollController,
                        shrinkWrap: true,
                        reverse: true,
                        padding: const EdgeInsets.only(top: 8, bottom: 72),
                        itemBuilder: (context, index) {
                          // if (homeCtrl.scroll) {
                          //   //   homeCtrl.scrollController.jumpTo(homeCtrl.scrollController.position.maxScrollExtent);
                          //   homeCtrl.scroll = false;
                          //   // }
                          //   WidgetsBinding.instance?.addPostFrameCallback((_) {
                          //     if (homeCtrl.scrollController.hasClients) {
                          //       homeCtrl.scrollController.jumpTo(homeCtrl.scrollController.position.maxScrollExtent);
                          //     } else {
                          //       setState(() => null);
                          //     }
                          //   });
                          // }
                          return Container(
                              padding: const EdgeInsets.only(left: 14, right: 14, top: 8, bottom: 4),
                              margin: EdgeInsets.only(left: messages[index].fromMe ? 48 : 0, right: messages[index].fromMe ? 0 : 48),
                              child: Align(
                                alignment: messages[index].fromMe ? Alignment.topRight : Alignment.topLeft,
                                child: Container(
                                  constraints: BoxConstraints(minHeight: 48),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: const Radius.circular(16),
                                        topRight: const Radius.circular(16),
                                        bottomRight: Radius.circular(messages[index].fromMe ? 0 : 16),
                                        bottomLeft: Radius.circular(messages[index].fromMe ? 16 : 0),
                                      ),
                                      color: messages[index].fromMe ? Pallet.secondaryColor : Colors.white,
                                      boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 1, spreadRadius: 1)]),
                                  padding: const EdgeInsets.only(top: 16, bottom: 8, left: 12, right: 0),
                                  child: Wrap(
                                    alignment: WrapAlignment.end,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(right: 12.0, bottom: 0),
                                        child: Text(
                                          messages[index].message,
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: messages[index].fromMe ? Pallet.whiteColor : Colors.black87,
                                          ),
                                        ),
                                      ),
                                      // const SizedBox(width: 36),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 2, bottom: 0, right: 12),
                                        child: Text(
                                          messages[index].time,
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: messages[index].fromMe ? Colors.white70 : Colors.black45,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ));
                        },
                      );
                    }),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    padding: const EdgeInsets.only(left: 8, bottom: 8, top: 8),
                    constraints: const BoxConstraints(maxHeight: 280),
                    width: double.infinity,
                    color: Colors.white,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            autocorrect: true,
                            controller: EditCtrl.chatMessage,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            //inputFormatters: <TextInputFormatter> [FilteringTextInputFormatter.deny(RegExp(r'[/<>£¥€&\$]'))],
                            decoration: InputDecoration(
                              hintText: "Write message...",
                              hintStyle: const TextStyle(color: Colors.black54),
                              border: InputBorder.none,
                              filled: true,
                              fillColor: Colors.black12,
                              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide(color: Colors.grey.shade100)),
                              contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide(color: Colors.grey.shade100)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 42,
                          child: FloatingActionButton(
                            onPressed: homeCtrl.sendMessage,
                            child: const Icon(
                              Icons.send,
                              color: Colors.white,
                              size: 18,
                            ),
                            backgroundColor: Pallet.secondaryColor,
                            elevation: 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

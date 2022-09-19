import 'package:brixmarket/core/preloader.dart';
import 'package:brixmarket/models/chat_user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/instance.dart';
import '../../../core/app.dart';
import 'conversation_lists.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    homeCtrl.fetchChatUsers();
    super.initState();
  }

  @override
  void dispose() {
    homeCtrl.userTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text(
          "Chat History",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // SafeArea(
            //   child: Padding(
            //     padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         IconButton(
            //           onPressed: () {
            //             Get.back();
            //           },
            //           icon: const Icon(
            //             Icons.arrow_back,
            //             color: Pallet.secondaryColor,
            //           ),
            //         ),
            //         const Text(
            //           "Chats",
            //           style:
            //               TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            //         ),
            //         IconButton(
            //           onPressed: () {
            //             Get.back();
            //           },
            //           icon: const Icon(
            //             Icons.more_vert_outlined,
            //             color: Pallet.secondaryColor,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
            //   child: TextField(
            //     decoration: InputDecoration(
            //       hintText: "Search...",
            //       hintStyle: TextStyle(color: Colors.grey.shade600),
            //       prefixIcon: Icon(
            //         Icons.search,
            //         color: Colors.grey.shade600,
            //         size: 20,
            //       ),
            //       filled: true,
            //       fillColor: Colors.black12,
            //       contentPadding: const EdgeInsets.all(8),
            //       enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: Colors.grey.shade100)),
            //     ),
            //   ),
            // ),
            StreamBuilder<List<ChatUser>?>(
                stream: homeCtrl.chatUserStream,
                builder: (context, snapshot) {
                  List<ChatUser> users = snapshot.data ?? [];
                  return snapshot.connectionState == ConnectionState.waiting
                      ? SizedBox(height: Get.height, child: Center(child: Preloader.loadingWidget()))
                      : users.isEmpty
                          ? SizedBox(
                              height: Get.height,
                              child: const Center(
                                  child: Text(
                                'Your chat history is empty',
                                style: TextStyle(color: Colors.black45, fontSize: 18),
                              )))
                          : ListView.builder(
                              itemCount: users.length,
                              shrinkWrap: true,
                              padding: const EdgeInsets.only(top: 16),
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () => homeCtrl.chatFromUserList(users[index]),
                                  child: ConversationList(
                                    name: users[index].name,
                                    messageText: users[index].lastMessage,
                                    imageUrl: userImgPath + users[index].image,
                                    time: users[index].lastMessageTime,
                                    seen: users[index].seen,
                                    fromMe: users[index].fromMe,
                                  ),
                                );
                              },
                            );
                }),
          ],
        ),
      ),
    );
  }
}

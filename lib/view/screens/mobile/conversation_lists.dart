import 'package:flutter/material.dart';

class ConversationList extends StatelessWidget {
  final String name;
  final String messageText;
  final String imageUrl;
  final String time;
  final bool seen;
  final bool fromMe;

  const ConversationList({required this.name, required this.messageText, required this.imageUrl, required this.time, required this.seen, required this.fromMe});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(
        bottom: BorderSide(color: Colors.black26, width: 0.6),
      )),
      padding: const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage(imageUrl),
                  maxRadius: 28,
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Container(
                    color: Colors.transparent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          name,
                          style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          messageText,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 13,
                              color: !seen && !fromMe ? Colors.grey.shade700 : Colors.grey.shade500,
                              fontWeight: !seen && !fromMe ? FontWeight.w700 : FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            // width: 54,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  time,
                  style: TextStyle(fontSize: 12, fontWeight: !seen && !fromMe ? FontWeight.bold : FontWeight.normal),
                ),
                fromMe
                    ? SizedBox(
                        width: 22,
                        height: 14,
                        child: Stack(
                          children: [
                            seen ? const Icon(Icons.check, size: 14) : const SizedBox.shrink(),
                            const Positioned(top: 1, right: 0, child: Icon(Icons.check, size: 14)),
                          ],
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

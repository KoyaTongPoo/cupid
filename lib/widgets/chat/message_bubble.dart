import 'package:flutter/material.dart';

// import 'package:gallery/studies/rally/authentication.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble(
    this.message,
    this.userName,
    //this.userImage,
    this.isMe, {
    required this.key,
  });

  @override
  final Key key;
  final String message;
  final String userName;
  //final String userImage;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Stack(
      // overflow: Overflow.visible,
      children: [
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: isMe ? Colors.grey[300] : Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(12),
                  topRight: const Radius.circular(12),
                  bottomLeft: !isMe ? const Radius.circular(0) : const Radius.circular(12),
                  bottomRight: isMe ? const Radius.circular(0) : const Radius.circular(12),
                ),
              ),
              width: 180,
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 12,
              ),
              margin: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 8,
              ),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    userName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isMe
                          ? Colors.black
                          : Theme.of(context).textTheme.headline6!.color,
                    ),
                  ),
                  Text(
                    message,
                    style: TextStyle(
                      color: isMe
                          ? Colors.black
                          : Theme.of(context).textTheme.headline6!.color,
                    ),
                    textAlign: isMe ? TextAlign.end : TextAlign.start,
                  ),
                ],
              ),
            ),
          ],
        ),
        // Positioned(
        //   top: 0,
        //   left: isMe ? null : 120,
        //   right: isMe ? 120 : null,
        //   child: CircleAvatar(
        //     backgroundImage: NetworkImage(
        //       userImage,
        //     ),
        //   ),
        // ),
      ],
    );
  }
}

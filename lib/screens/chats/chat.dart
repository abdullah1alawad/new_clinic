import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _BasicState();
}

class _BasicState extends State<ChatScreen> {
  ChatUser user = ChatUser(
    id: '1',
    firstName: 'Charles',
    lastName: 'Leclerc',
  );

  List<ChatMessage> messages = <ChatMessage>[
    ChatMessage(
      text: 'مرحبا !',
      user: ChatUser(id: '2'),
      createdAt: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('دعبووول', style: Theme.of(context).textTheme.titleSmall),
        centerTitle: false,
      ),
      body: DashChat(
        currentUser: user,
        onSend: (ChatMessage m) {
          setState(() {
            messages.insert(0, m);
            messages.insert(
              0,
              ChatMessage(
                text: 'مرحبا !',
                user: ChatUser(id: '2'),
                createdAt: DateTime.now(),
              ),
            );
          });
        },
        messages: messages,
        inputOptions: inputOptions(),
        messageOptions: messageOptions(),
        messageListOptions: messageListOptions(),
        scrollToBottomOptions: scrollToBottomOptions(),
      ),
    );
  }

  ScrollToBottomOptions scrollToBottomOptions() {
    return ScrollToBottomOptions(
      scrollToBottomBuilder: (scrollController) => DefaultScrollToBottom(
        scrollController: scrollController,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
      ),
    );
  }

  MessageListOptions messageListOptions() {
    return MessageListOptions(
      dateSeparatorBuilder: (date) => DefaultDateSeparator(
        date: date,
        textStyle: const TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }

  MessageOptions messageOptions() {
    return MessageOptions(
      currentUserContainerColor: Colors.white,
      currentUserTextColor: Colors.black,
      showCurrentUserAvatar: true,
      showTime: true,
      messageDecorationBuilder: (
        ChatMessage message,
        ChatMessage? previousMessage,
        ChatMessage? nextMessage,
      ) {
        bool isCurrentUser = message.user.id == user.id;
        bool isDefUser = nextMessage?.user.id != message.user.id;
        return defaultMessageDecoration(
          color: Colors.white,
          borderTopLeft: 18,
          borderTopRight: 18,
          borderBottomLeft: isCurrentUser && isDefUser ? 0 : 18,
          borderBottomRight: !isCurrentUser && isDefUser ? 0 : 18,
        );
      },
    );
  }

  InputOptions inputOptions() {
    return InputOptions(
      inputTextDirection: TextDirection.rtl,
      alwaysShowSend: true,
      inputDecoration: InputDecoration(
        hintText: "اكتب هنا ...",
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
      ),
      sendButtonBuilder: (void Function() onSend) {
        return IconButton(
          icon: const Icon(
            Icons.send,
            color: Colors.black,
            textDirection: TextDirection.rtl,
          ),
          onPressed: onSend,
        );
      },
    );
  }
}

import 'dart:convert';

import '../../core/enum/connection_enum.dart';
import '../../core/utils/laravel_echo.dart';
import '../../model/chat/chat_model.dart';
import '../../model/chat/message_model.dart';
import '../../provider/chat/create_message_provider.dart';
import '../../provider/chat/get_chat_messages_provider.dart';
import '../../widgets/show_messages/show_error_message.dart';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pusher_client/pusher_client.dart';

class ChatScreen extends StatefulWidget {
  final ChatUser chatUser;
  const ChatScreen({super.key, required this.chatUser});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late GetChatMessagesProvider _chatProvider;

  @override
  void initState() {
    super.initState();
    _chatProvider =
        Provider.of<GetChatMessagesProvider>(context, listen: false);
  }

  void listenChatChannel(ChatModel chat) {
    LaravelEcho.instance.private('chat.${chat.id}').listen('.message.sent',
        (e) {
      if (e is PusherEvent) {
        if (e.data != null) {
          _handleNewMessage(jsonDecode(e.data!));
        }
      }
    }).error((err) {
      print(err);
    });
  }

  void leaveChatChannel(ChatModel chat) {
    try {
      LaravelEcho.instance.leave('chat.${chat.id}');
    } catch (err) {
      print(err);
    }
  }

  void _handleNewMessage(Map<String, dynamic> data) {
    final selectedChat = _chatProvider.chat!;
    if (selectedChat.id == data['chat_id']) {
      final chatMessage = MessageModel.fromJson(data['message']);
      _chatProvider.addMessage(chatMessage);
    }
  }

  @override
  void dispose() {
    leaveChatChannel(_chatProvider.chat!);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final messageProvider = Provider.of<CreateMessageProvider>(context);
    ChatUser chatUser = widget.chatUser;

    listenChatChannel(_chatProvider.chat!);

    return Scaffold(
      appBar: AppBar(
        title: Text(_chatProvider.chat!.otherUser.name,
            style: Theme.of(context).textTheme.titleSmall),
        centerTitle: false,
      ),
      body: Consumer<GetChatMessagesProvider>(
        builder: (context, provider, child) {
          if (provider.connection == ConnectionEnum.connected) {
            return DashChat(
              currentUser: chatUser,
              onSend: (ChatMessage m) async {
                await messageProvider.createMessage(
                  provider.chat!.id,
                  m.text,
                  LaravelEcho.socketId,
                );

                if (messageProvider.connection == ConnectionEnum.connected) {
                  provider.addMessage(messageProvider.message!);
                } else if (messageProvider.connection ==
                    ConnectionEnum.failed) {
                  if (context.mounted) {
                    ShowErrorMessage.showMessage(
                        context, messageProvider.errorMessage!);
                  }
                }
              },
              messages: provider.uiMessages,
              inputOptions: inputOptions(),
              messageOptions: messageOptions(chatUser.id),
              messageListOptions: messageListOptions(),
              scrollToBottomOptions: scrollToBottomOptions(),
            );
          } else if (provider.connection == ConnectionEnum.failed) {
            return Center(child: Text(provider.errorMessage ?? 'Error'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
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

  MessageOptions messageOptions(String userId) {
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
        bool isCurrentUser = message.user.id == userId;
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

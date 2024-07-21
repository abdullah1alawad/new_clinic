import 'package:clinic_test_app/core/enum/connection_enum.dart';
import 'package:clinic_test_app/provider/chat/create_message_provider.dart';
import 'package:clinic_test_app/provider/chat/get_chat_messages_provider.dart';
import 'package:clinic_test_app/provider/five_screen_provider.dart';
import 'package:clinic_test_app/widgets/show_messages/show_error_message.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<GetChatMessagesProvider>(context);
    final messageProvider = Provider.of<CreateMessageProvider>(context);
    ChatUser chatUser = Provider.of<FiveScreenProvider>(context, listen: false)
        .user!
        .toChatUser;

    return Scaffold(
      appBar: AppBar(
        title: Text(chatProvider.chat!.otherUser.name,
            style: Theme.of(context).textTheme.titleSmall),
        centerTitle: false,
      ),
      body: Consumer<GetChatMessagesProvider>(
        builder: (context, provider, child) {
          if (provider.connection == ConnectionEnum.connected) {
            return DashChat(
              currentUser: chatUser,
              onSend: (ChatMessage m) async {
                await messageProvider.createMessage(provider.chat!.id, m.text);

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

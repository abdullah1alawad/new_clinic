import 'package:dash_chat_2/dash_chat_2.dart';

import '../../core/enum/connection_enum.dart';
import '../../core/utils/app_constants.dart';
import '../../core/utils/app_services.dart';
import '../../core/utils/laravel_echo.dart';
import '../../model/user_model.dart';
import '../../provider/chat/create_chat_provider.dart';
import '../../provider/chat/get_chat_messages_provider.dart';
import '../../provider/chat/get_many_chats_provider.dart';
import '../../widgets/back_ground_container.dart';
import '../../widgets/cards/chat_card.dart';
import '../../widgets/custom_bottom_app_bar.dart';
import '../../widgets/show_messages/show_error_message.dart';
import '../../provider/get_all_users_provider.dart';
import '../../screens/chats/chat.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_page/search_page.dart';

class ChatsListScreen extends StatelessWidget {
  final ChatUser chatUser;
  const ChatsListScreen({super.key, required this.chatUser});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('الدردشات'),
        bottom: const CustomBottonAppBar(),
        actions: [
          IconButton(
            onPressed: () {
              _showSearch(context);
            },
            icon: const Icon(
              Icons.search,
              color: Colors.white,
              size: 35,
            ),
          ),
        ],
      ),
      body: BackGroundContainer(
        child: Consumer<GetManyChatsProvider>(
          builder: (context, provider, child) {
            if (provider.connection == ConnectionEnum.connected) {
              if (provider.chats!.isEmpty) {
                return SizedBox(
                  height: screenSize.height,
                  width: screenSize.width,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.chat_sharp,
                        size: 50,
                      ),
                      Text(
                        "لاتوجد محادثات حتى الان",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'ElMessiri',
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                );
              }

              return ListView.separated(
                itemCount: provider.chats!.length,
                itemBuilder: (context, index) {
                  final chat = provider.chats![index];
                  final imageProvider = chat.otherUser.photo != null
                      ? NetworkImage('$kIMAGEBASEURL${chat.otherUser.photo}')
                          as ImageProvider<Object>
                      : const AssetImage('assets/images/avatar.png')
                          as ImageProvider<Object>;

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ChatCard(
                      name: chat.otherUser.name,
                      lastMessage: chat.lastMessage!.message,
                      date: utcToLocal(chat.lastMessage!.updatedAt),
                      backgroundImage: imageProvider,
                      onTap: () {
                        final chatMessadesProvider =
                            Provider.of<GetChatMessagesProvider>(context,
                                listen: false);
                        if (chatMessadesProvider.chat == null ||
                            chatMessadesProvider.chat != chat) {
                          chatMessadesProvider.reset(chat);

                          chatMessadesProvider.getChatMessages();
                        }

                        navigator(ChatScreen(chatUser: chatUser), context);
                      },
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(
                  color: Colors.blue,
                  indent: 30,
                  endIndent: 30,
                ),
              );
            } else if (provider.connection == ConnectionEnum.failed) {
              return Center(child: Text(provider.errorMessage ?? 'Error'));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  void _showSearch(BuildContext context) {
    showSearch(
      context: context,
      delegate: SearchPage<UserModel>(
        items: Provider.of<GetAllUsersProvider>(context, listen: false).users,
        searchLabel: 'إبحث عن شخص ....',
        suggestion: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'إبحث بواسطة اسم الشخص',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.black54),
              ),
              const Icon(
                Icons.search,
                size: 25.0,
                color: Colors.black54,
              ),
            ],
          ),
        ),
        failure: const Center(
          child: Text(
            'No person found :(',
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w400,
                color: Colors.black54),
          ),
        ),
        filter: (user) => [user.name],
        builder: (user) => ListTile(
          leading: user.photo == null
              ? const Icon(Icons.account_circle, size: 50.0)
              : CircleAvatar(
                  backgroundImage: NetworkImage('$kIMAGEBASEURL${user.photo}'),
                  radius: 23,
                ),
          title: Text(user.username),
          subtitle: Text(user.email),
          onTap: () async {
            final chatProvider =
                Provider.of<CreateChatProvider>(context, listen: false);
            await chatProvider.createChat(user.id);

            if (chatProvider.connection == ConnectionEnum.connected) {
              if (context.mounted) {
                final chatMessadesProvider =
                    Provider.of<GetChatMessagesProvider>(context,
                        listen: false);
                if (chatMessadesProvider.chat == null ||
                    chatMessadesProvider.chat != chatProvider.chat) {
                  chatMessadesProvider.reset(chatProvider.chat!);

                  chatMessadesProvider.getChatMessages();
                }

                navigator(ChatScreen(chatUser: user.toChatUser), context);
              }
            } else if (chatProvider.connection == ConnectionEnum.failed) {
              if (context.mounted) {
                ShowErrorMessage.showMessage(
                    context, chatProvider.errorMessage!);
              }
            }
          },
        ),
        searchStyle: const TextStyle(color: Colors.black),
      ),
    );
  }
}

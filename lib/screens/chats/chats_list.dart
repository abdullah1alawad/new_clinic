import 'package:clinic_test_app/core/enum/connection_enum.dart';
import 'package:clinic_test_app/core/utils/app_constants.dart';
import 'package:clinic_test_app/core/utils/app_services.dart';
import 'package:clinic_test_app/model/user_model.dart';
import 'package:clinic_test_app/provider/chat/create_chat_provider.dart';
import 'package:clinic_test_app/provider/chat/get_chat_messages_provider.dart';
import 'package:clinic_test_app/provider/chat/get_many_chats_provider.dart';
import 'package:clinic_test_app/provider/get_all_users_provider.dart';
import 'package:clinic_test_app/screens/chats/chat.dart';
import 'package:clinic_test_app/widgets/back_ground_container.dart';
import 'package:clinic_test_app/widgets/cards/chat_card.dart';
import 'package:clinic_test_app/widgets/custom_bottom_app_bar.dart';
import 'package:clinic_test_app/widgets/show_messages/show_error_message.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_page/search_page.dart';

class ChatsListScreen extends StatelessWidget {
  const ChatsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // List<UserModel> users = [
    //   UserModel(
    //     id: 1,
    //     email: "example@gmail.com",
    //     username: "username",
    //     name: "Mohammed",
    //     gender: "Male",
    //     phone: "009877",
    //     photo: null,
    //     nationalId: "0998877",
    //   ),
    //   UserModel(
    //     id: 2,
    //     email: "example@gmail.com",
    //     username: "username",
    //     name: "Ahmad",
    //     gender: "Male",
    //     phone: "009877",
    //     photo: null,
    //     nationalId: "0998877",
    //   ),
    //   UserModel(
    //     id: 3,
    //     email: "example@gmail.com",
    //     username: "username",
    //     name: "Da3bool",
    //     gender: "Male",
    //     phone: "009877",
    //     photo: null,
    //     nationalId: "0998877",
    //   ),
    // ];

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
                return const Center(
                  child: Column(
                    children: [
                      Icon(Icons.chat_sharp),
                      Text("لايوجد محادثات حتى الان"),
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

                        navigator(const ChatScreen(), context);
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

                navigator(const ChatScreen(), context);
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

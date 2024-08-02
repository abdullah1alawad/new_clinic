<?php

namespace App\Http\Controllers;

use App\Events\NewMessageSent;
use App\Http\Requests\GetMessageRequest;
use App\Http\Requests\StoreMessageRequest;
use App\Models\Chat;
use App\Models\ChatMessage;
use App\Models\User;
use App\traits\GeneralTrait;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class ChatMessageController extends Controller
{
    use GeneralTrait;

    /**
     * Gets chat message
     *
     * @param GetMessageRequest $request
     * @return JsonResponse
     */
    public function index(GetMessageRequest $request)
    {
        $data = $request->validated();
        $chatId = $data['chat_id'];
        $currentPage = $data['page'];
        $pageSize = isset($data['page_size']) ? $data['page_size'] : 15;

        $messages = ChatMessage::where('chat_id', $chatId)
            ->with('user')
            ->latest('created_at')
            ->simplePaginate(
                $pageSize,
                ['*'],
                'page',
                $currentPage
            );

        return $this->apiResponse($messages->getCollection(), true, 'messages.');
    }

    /**
     * Create a chat message
     *
     * @param StoreMessageRequest $request
     * @return JsonResponse
     */
    public function store(StoreMessageRequest $request)
    {
        $data = $request->validated();
        $data['user_id'] = auth('sanctum')->user()->id;
        $userId = $data['user_id'];

        $chat = Chat::where('id', $request->chat_id)
            ->with(['participants' => function ($query) use ($userId) {
                $query->where('user_id', '!=', $userId);
            }])
            ->first();

        if ($chat) {
            // Update the status of other participants to 1
            $chat->participants->each(function ($participant) {
                $participant->update(['status' => 0]);
            });
        }

        // Create the chat message
        $chatMessage = ChatMessage::create($data);
        $chatMessage->load('user');

        // Load the chat with its relationships
        $chat = $chatMessage->chat()->with('lastMessage.user', 'participants.user')->first();


        $chat->status = $chat->participants()
            ->where('user_id', $userId)
            ->value('status');

        // Add other participants to the chat object
        $chat->otherParticipants = $chat->participants->filter(function ($participant) use ($userId) {
            return $participant->user_id !== $userId;
        })->values();

        unset($chat->participants);

        // Attach the chat to the chatMessage
//        $chatMessage->chat = $chat;
//        $chatMessage->save();

        $response = [
            'chat_id' => $chatMessage->chat_id,
            'message' => $chatMessage->message,
            'user_id' => $chatMessage->user_id,
            'updated_at' => $chatMessage->updated_at,
            'created_at' => $chatMessage->created_at,
            'id' => $chatMessage->id,
            'chat' => $chat,
            'user' => $chatMessage->user
        ];

        /// TODO send broadcast event to pusher and send notification to onesignal services
        $this->sendNotificationToOther($chatMessage,$response);

        return $this->apiResponse($response, true, 'Message has been sent successfully.');
    }

    /**
     * Send notification to other users
     *
     * @param ChatMessage $chatMessage
     */
    private function sendNotificationToOther(ChatMessage $chatMessage,$response)
    {

        // TODO move this event broadcast to observer
        broadcast(new NewMessageSent($chatMessage,$response))->toOthers();

        $user = auth('sanctum')->user();
        $userId = $user->id;

        $chat = Chat::where('id', $chatMessage->chat_id)
            ->with(['participants' => function ($query) use ($userId) {
                $query->where('user_id', '!=', $userId);
            }])
            ->first();

        $chat->status = $chat->participants()
            ->where('user_id', $userId)
            ->value('status');

        if (count($chat->participants) > 0) {
            $otherUserId = $chat->participants[0]->user_id;

            $otherUser = User::where('id', $otherUserId)->first();
            $otherUser->sendNewMessageNotification([
                'messageData' => [
                    'senderName' => $user->username,
                    'message' => $chatMessage->message,
                    'chatId' => $chatMessage->chat_id
                ]
            ]);
        }
    }

}

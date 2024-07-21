<?php

namespace App\Http\Controllers;

use App\Http\Requests\GetChatRequest;
use App\Http\Requests\StoreChatRequest;
use App\Http\Resources\ChatResource;
use App\Models\Chat;
use App\traits\GeneralTrait;
use Illuminate\Http\JsonResponse;

class ChatController extends Controller
{
    use GeneralTrait;

    /**
     * Gets chats
     *
     * @param GetChatRequest $request
     * @return JsonResponse
     */
    public function index(GetChatRequest $request)
    {
        $data = $request->validated();

        $isPrivate = 1;
        if ($request->has('is_private')) {
            $isPrivate = (int)$data['is_private'];
        }

        $chats = Chat::where('is_private', $isPrivate)
            ->hasParticipant(auth('sanctum')->user()->id)
            ->whereHas('messages')
            ->with('lastMessage.user', 'participants.user')
            ->latest('updated_at')
            ->get();

//        return $chats[0]->participants;

        $userId = auth('sanctum')->user()->id;

        $chats = $chats->map(function ($chat) use ($userId) {
            $chat->otherParticipants = $chat->participants->filter(function ($participant) use ($userId) {
                return $participant->user_id !== $userId;
            })->values();
            return $chat;
        });

//        return $chats;
        $chats = ChatResource::collection($chats);

        return $this->apiResponse($chats, true, 'chats here.');
    }


    /**
     * Stores a new chat
     *
     * @param StoreChatRequest $request
     * @return JsonResponse
     */
    public function store(StoreChatRequest $request)
    {
        $userId = auth('sanctum')->user()->id;

        $data = $this->prepareStoreData($request);
        if ($data['userId'] === $data['otherUserId']) {
            return $this->apiResponse(null, false,
                'You can not create a chat with your own', 422);
        }

        $previousChat = $this->getPreviousChat($data['otherUserId']);

        if ($previousChat === null) {

            $chat = Chat::create($data['data']);
            $chat->participants()->createMany([
                [
                    'user_id' => $data['userId']
                ],
                [
                    'user_id' => $data['otherUserId']
                ]
            ]);

            $chat->refresh()->load('lastMessage.user', 'participants.user');

            $chat->otherParticipants = $chat->participants->filter(function ($participant) use ($userId) {
                return $participant->user_id !== $userId;
            })->values();

            $chat = ChatResource::make($chat);
            return $this->apiResponse($chat, true, 'chat here.');
        }

        $previousChat->load('lastMessage.user', 'participants.user');

        $previousChat->otherParticipants = $previousChat->participants->filter(function ($participant) use ($userId) {
            return $participant->user_id !== $userId;
        })->values();

        $previousChat = ChatResource::make($previousChat);

        return $this->apiResponse($previousChat, true, 'okay');
    }

    /**
     * Check if user and other user has previous chat or not
     *
     * @param int $otherUserId
     * @return mixed
     */
    private function getPreviousChat($otherUserId)
    {
        $userId = auth('sanctum')->user()->id;

        return Chat::where('is_private', 1)
            ->whereHas('participants', function ($query) use ($userId) {
                $query->where('user_id', $userId);
            })
            ->whereHas('participants', function ($query) use ($otherUserId) {
                $query->where('user_id', $otherUserId);
            })
            ->first();
    }


    /**
     * Prepares data for store a chat
     *
     * @param StoreChatRequest $request
     * @return array
     */
    private function prepareStoreData(StoreChatRequest $request)
    {
        $data = $request->validated();
        $otherUserId = (int)$data['user_id'];
        unset($data['user_id']);
        $data['created_by'] = auth('sanctum')->user()->id;

        return [
            'otherUserId' => $otherUserId,
            'userId' => auth('sanctum')->user()->id,
            'data' => $data,
        ];
    }


    /**
     * Gets a single chat
     *
     * @param Chat $chat
     * @return JsonResponse
     */
    public function show(Chat $chat)
    {
        $chat->load('lastMessage.user', 'participants.user');

        $userId = auth('sanctum')->user()->id;

        // Filter participants to exclude the authenticated user
        $chat->otherParticipants = $chat->participants->filter(function ($participant) use ($userId) {
            return $participant->user_id !== $userId;
        })->values();

        $chatResource = new ChatResource($chat);

        return $this->apiResponse($chatResource, true, 'chat');
    }

}

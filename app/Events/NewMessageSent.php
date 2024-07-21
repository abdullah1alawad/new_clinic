<?php

namespace App\Events;

use App\Models\ChatMessage;
use Illuminate\Broadcasting\Channel;
use Illuminate\Broadcasting\InteractsWithSockets;
use Illuminate\Broadcasting\PresenceChannel;
use Illuminate\Broadcasting\PrivateChannel;
use Illuminate\Contracts\Broadcasting\ShouldBroadcast;
use Illuminate\Foundation\Events\Dispatchable;
use Illuminate\Queue\SerializesModels;

class NewMessageSent implements ShouldBroadcast
{
    use Dispatchable, InteractsWithSockets, SerializesModels;

    private $chatMessage;

    /**
     * NewMessageSent constructor.
     *
     * @param ChatMessage $chatMessage
     */
    public function __construct(ChatMessage $chatMessage)
    {
        $this->chatMessage = $chatMessage;
    }

    /**
     * Get the channels the event should broadcast on.
     *
     * @return \Illuminate\Broadcasting\Channel|array
     */
    public function broadcastOn()
    {
        return new PrivateChannel('chat.' . $this->chatMessage->chat_id);
    }

    /**
     * Broadcast's event name
     *
     * @return string
     */
    public function broadcastAs(): string
    {
        return 'message.sent';
    }

    /**
     * Data sending back to client
     *
     * @return array
     */
    public function broadcastWith(): array
    {
        return [
            'chat_id' => $this->chatMessage->chat_id,
            'message' => $this->chatMessage->toArray(),
        ];
    }
}

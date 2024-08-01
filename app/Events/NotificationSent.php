<?php

namespace App\Events;

use App\Http\Resources\NotificationResource;
use App\Http\Resources\UserResource;
use Illuminate\Broadcasting\Channel;
use Illuminate\Broadcasting\InteractsWithSockets;
use Illuminate\Broadcasting\PresenceChannel;
use Illuminate\Broadcasting\PrivateChannel;
use Illuminate\Contracts\Broadcasting\ShouldBroadcast;
use Illuminate\Foundation\Events\Dispatchable;
use Illuminate\Queue\SerializesModels;

class NotificationSent implements ShouldBroadcast
{
    use Dispatchable, InteractsWithSockets, SerializesModels;

    protected $notification, $user_id;

    public function __construct($user_id, $notification)
    {
        $this->notification = $notification;
        $this->user_id = $user_id;
    }

    public function broadcastOn()
    {
        return new PrivateChannel('App.User.' . $this->user_id);
    }


    public function broadcastAs(): string
    {
        return 'notification.sent';
    }

    public function broadcastWith()
    {
        return NotificationResource::make($this->notification)->toArray(request());
    }
}

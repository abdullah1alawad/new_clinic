<?php

namespace App\Events;

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

    protected $process, $user;

    public function __construct($process, $user)
    {
        $this->process = $process;
        $this->user = $user;
    }

    public function broadcastOn()
    {
        return new PrivateChannel('App.User.' . $this->user->id);
    }


    public function broadcastAs(): string
    {
        return 'notification.sent';
    }

    public function broadcastWith()
    {
        return [
            'process_id' => $this->process->id,
            'user' => $this->user->toArray(),
        ];
    }
}

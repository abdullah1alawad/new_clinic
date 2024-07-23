<?php

namespace App\Events;

use Illuminate\Broadcasting\Channel;
use Illuminate\Broadcasting\InteractsWithSockets;
use Illuminate\Broadcasting\PresenceChannel;
use Illuminate\Broadcasting\PrivateChannel;
use Illuminate\Contracts\Broadcasting\ShouldBroadcast;
use Illuminate\Foundation\Events\Dispatchable;
use Illuminate\Queue\SerializesModels;

class ChairBookRequest implements ShouldBroadcast
{
    use Dispatchable, InteractsWithSockets, SerializesModels;

    public $booking;
    public $userId;

    /**
     * Create a new event instance.
     */
    public function __construct($booking, $userId)
    {
        $this->booking = $booking;
        $this->userId = $userId;
    }


    public function broadcastOn()
    {
        return new PrivateChannel('App.User.' . $this->userId);
    }

    public function broadcastWith()
    {
        return ['booking' => $this->booking];
    }

}

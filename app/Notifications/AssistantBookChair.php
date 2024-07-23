<?php

namespace App\Notifications;

use App\Http\Resources\UpcomingAppointmentsResource;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Messages\BroadcastMessage;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Notifications\Notification;

class AssistantBookChair extends Notification implements ShouldQueue
{
    use Queueable;

    protected $process;

    /**
     * Create a new notification instance.
     */
    public function __construct($process)
    {
        $this->process = $process;
    }

    /**
     * Get the notification's delivery channels.
     *
     * @return array<int, string>
     */
    public function via($notifiable)
    {
        return ['database', 'broadcast'];
    }

    public function toArray($notifiable)
    {
        return [
            'process' => UpcomingAppointmentsResource::make($this->process),
            'message' => 'The doctor Choose you to this process.',
        ];
    }

    public function toBroadcast($notifiable)
    {
        return new BroadcastMessage([
            'process' => UpcomingAppointmentsResource::make($this->process),
            'message' => 'The doctor Choose you to this process.',
        ]);
    }
}

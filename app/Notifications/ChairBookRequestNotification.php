<?php

namespace App\Notifications;


use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Messages\BroadcastMessage;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Notifications\Notification;

class ChairBookRequestNotification extends Notification implements ShouldQueue
{
    use Queueable;

    protected $process, $user;

    /**
     * Create a new notification instance.
     */
    public function __construct($process, $user)
    {
        $this->process = $process;
        $this->user = $user;
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

    /**
     * Get the array representation of the notification.
     *
     * @return array<string, mixed>
     */
    public function toArray($notifiable)
    {
        return [
            'process_id' => $this->process->id,
            'user' => $this->user,
            'message' => 'A student want to book a chair.',
        ];
    }

    public function toBroadcast($notifiable)
    {
        return new BroadcastMessage([
            'process_id' => $this->process->id,
            'user' => $this->user,
            'message' => 'A student want to book a chair.',
        ]);
    }
}

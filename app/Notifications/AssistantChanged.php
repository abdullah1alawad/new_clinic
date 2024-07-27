<?php

namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Messages\BroadcastMessage;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Notifications\Notification;

class AssistantChanged extends Notification
{
    use Queueable;

    protected $process, $message;

    /**
     * Create a new notification instance.
     */
    public function __construct($process, $message)
    {
        $this->process = $process;
        $this->message = $message;
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
            'cause' => 'choose_assistant',
            'process' => $this->process->id,
            'message' => $this->message,
        ];
    }

    public function toBroadcast($notifiable)
    {
        return new BroadcastMessage([
            'cause' => 'choose_assistant',
            'process' => $this->process->id,
            'message' => $this->message,
        ]);
    }
}

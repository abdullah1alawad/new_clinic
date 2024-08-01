<?php

namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Messages\BroadcastMessage;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Notifications\Notification;

class AssistantBookChair extends Notification implements ShouldQueue
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
        return ['database'];
    }

    public function toArray($notifiable)
    {
        return [
            'cause' => 'choose_assistant',
            'user' => $this->user,
            'process_id' => $this->process->id,
            'message' => 'لقد اختارك الدكتور لهذا الموعد.',
        ];
    }
//
//    public function toBroadcast($notifiable)
//    {
//        return new BroadcastMessage([
//            'process_id' => $this->process->id,
//            'user' => $this->user,
//            'message' => 'لقد اختارك الدكتور لهذا الموعد.',
//        ]);
//    }
}

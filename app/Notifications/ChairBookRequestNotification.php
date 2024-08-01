<?php

namespace App\Notifications;


use Illuminate\Broadcasting\PrivateChannel;
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
        return ['database'];
    }

    /**
     * Get the array representation of the notification.
     *
     * @return array<string, mixed>
     */
    public function toArray($notifiable)
    {
        return [
            'cause' => 'student_book_request',
            'process_id' => $this->process->id,
            'user' => $this->user,
            'message' => 'الطالب يريد حجز موعد.',
        ];
    }

//    public function toBroadcast($notifiable)
//    {
//        return new BroadcastMessage([
//            'cause' => 'student_book_request',
//            'process_id' => $this->process->id,
//            'user' => $this->user,
//            'message' => 'الطالب يريد حجز موعد.',
//        ]);
//    }

}

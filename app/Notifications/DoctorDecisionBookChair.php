<?php

namespace App\Notifications;

use App\Http\Resources\UpcomingAppointmentsResource;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Messages\BroadcastMessage;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Notifications\Notification;

class DoctorDecisionBookChair extends Notification implements ShouldQueue
{
    use Queueable;

    protected $process, $message, $cause;

    /**
     * Create a new notification instance.
     */
    public function __construct($process, $message, $cause)
    {
        $this->process = $process;
        $this->message = $message;
        $this->cause = $cause;
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
            'cause' => $this->cause,
            'process' => $this->process->id,
            'message' => $this->message,
        ];
    }

    public function toBroadcast($notifiable)
    {
        return new BroadcastMessage([
            'cause' => $this->cause,
            'process' => $this->process->id,
            'message' => $this->message,
        ]);
    }
}

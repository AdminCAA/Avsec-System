<?php

namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Notifications\Notification;

class SecurityConcernReminder extends Notification
{
    use Queueable;

    /**
     * Create a new notification instance.
     */

    protected $concerns;


    public function __construct($concerns)
    {
        $this->concerns = $concerns;
    }

    /**
     * Get the notification's delivery channels.
     *
     * @return array<int, string>
     */
    public function via(object $notifiable): array
    {
        return ['mail'];
    }

    /**
     * Get the mail representation of the notification.
     */
    // public function toMail(object $notifiable): MailMessage
    // {
    //     return (new MailMessage)
    //                 ->subject('Weekly Security Concerns Reminder')
    //                 ->greeting('Dear ' . $notifiable->name . ',')
    //                 ->line('You have security concerns that require your attention.')
    //                 ->line('Total concerns: ' . count($this->concerns))
    //                 ->action('View Concerns', url('/welcome'))
    //                 ->line('Please resolve them promptly.');
    // }

    public function toMail(object $notifiable): MailMessage
    {
        return (new MailMessage)
            ->subject('Weekly Security Concerns Reminder')
            ->view('mails.security_concerns', [
                'notifiable' => $notifiable,
                'concerns' => $this->concerns
            ]);
    }


    /**
     * Get the array representation of the notification.
     *
     * @return array<string, mixed>
     */
    public function toArray(object $notifiable): array
    {
        return [
            //
        ];
    }
}

<?php

namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Notifications\Notification;

class EmailConfirmation extends Notification
{
    use Queueable;

    /**
     * Create a new notification instance.
     * 
     */

    public $user;

    public function __construct($user)
    {
        //
        $this->user = $user;
        
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
    public function toMail(object $notifiable): MailMessage
    {

        return (new MailMessage)
        ->subject('Welcome to' .config('app.name'))
        ->greeting('Hello ' . ($this->user->name ?? ','))
        ->line('Your Account has been created successfully.')
            // ->subject('Welcome to ' . config('app.name'))
            // ->subject('Welcome to ' . config('app.name') . ' - Email Confirmation')
            // ->subject('Email Confirmation for ' . config('app.name'))
            // ->subject('Confirm Your Email Address')
        
        // ->subject('Email Confirmation Notification')

            //->greeting('Hello ' . $this->user->name . ',')
            
            // ->line('The introduction to the notification.')
            // ->action('Notification Action', url('/'))
           
            ->line('Thank you for using our application!')
            ->salutation('Best Regards,');
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

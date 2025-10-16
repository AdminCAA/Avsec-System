<?php

namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Notifications\Notification;
use App\Models\QualityControl;
use Carbon\Carbon;

class QualityControlDueReminder extends Notification
{
    use Queueable;

    protected $qualityControl;

    public function __construct(QualityControl $qualityControl)
    {
        $this->qualityControl = $qualityControl;
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

    public function toMail($notifiable)
    {
        $recipientName = property_exists($notifiable, 'name') ? $notifiable->name : 'Admin';

        $daysLeft = max(0, Carbon::now()->diffInDays(Carbon::parse($this->qualityControl->end_date), false));

        return (new MailMessage)
            ->subject('⚠️ Quality Control Due Reminder')
            ->greeting('Dear ' . $recipientName . ',')
            ->line("The quality control activity titled **{$this->qualityControl->title}** is due in {$daysLeft} day(s).")
            ->line('Please make sure to complete it before it becomes overdue.')
            ->line('End Date: ' . Carbon::parse($this->qualityControl->end_date)->format('d M Y'))
            ->action('View Quality Control', route('quality-controls.show', $this->qualityControl->id))
            ->line('Thank you for your attention.');
    }


    public function toArray(object $notifiable): array
    {
        return [
            //
        ];
    }
}

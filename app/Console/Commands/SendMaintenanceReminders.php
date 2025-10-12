<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Models\MaintenanceSchedule;
use App\Mail\MaintenanceReminderMail;
use Illuminate\Support\Facades\Mail;
use Carbon\Carbon;

class SendMaintenanceReminders extends Command
{
    

    protected $signature = 'maintenance:send-reminders';

    protected $description = 'Send maintenance reminders 14 days before next due date';

    public function handle()
    {
        $targetDate = Carbon::now()->addDays(14)->toDateString();

        $schedules = MaintenanceSchedule::whereDate('next_due_date', $targetDate)->get();

        if ($schedules->isEmpty()) {
            $this->info('No maintenance reminders to send today.');
            return;
        }

        foreach ($schedules as $schedule) {
            Mail::to('umoyoprintex@gmail.com')->send(new MaintenanceReminderMail($schedule));
            $this->info("Reminder sent for equipment ID: {$schedule->securityEquipment->id}");
        }

        $this->info('All reminders have been sent successfully.');
    }
}


//testing if its working run
//php artisan maintenance:send-reminders

// cron e
// * * * * * php /Users/David.Chamanga/Documents/code/avsec-recess/artisan schedule:run >> /dev/null 2>&1


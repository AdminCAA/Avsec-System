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
    protected $description = 'Send maintenance reminders 14 days before next due date and mark overdue schedules';

    public function handle()
    {
        $avsec_email = env('AVSEC_EMAIL');
        $today = Carbon::now()->toDateString();
        $reminderDate = Carbon::now()->addDays(14)->toDateString();

        // 1️⃣ Send reminders 14 days before due date
        $upcomingSchedules = MaintenanceSchedule::whereDate('next_due_date', $reminderDate)->get();

        if ($upcomingSchedules->isEmpty()) {
            $this->info('No maintenance reminders to send today.');
        } else {
            foreach ($upcomingSchedules as $schedule) {
                Mail::to($avsec_email)->send(new MaintenanceReminderMail($schedule));
                $this->info("Reminder sent for equipment ID: {$schedule->securityEquipment->id}");
            }
        }

        // 2️⃣ Mark overdue schedules
        $overdueSchedules = MaintenanceSchedule::whereDate('next_due_date', '<', $today)
            ->where('status', '!=', 'Overdue')
            ->get();

        if ($overdueSchedules->isEmpty()) {
            $this->info('No overdue schedules to update.');
        } else {
            foreach ($overdueSchedules as $schedule) {
                $schedule->update(['status' => 'Overdue']);
                $this->info("Schedule ID {$schedule->id} marked as Overdue");
            }
        }

        $this->info('Maintenance reminders and overdue updates completed successfully.');
    }
}


//testing if its working run
//php artisan maintenance:send-reminders

// cron e
// * * * * * php /Users/David.Chamanga/Documents/code/avsec-recess/artisan schedule:run >> /dev/null 2>&1


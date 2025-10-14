<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\Notification;
use App\Models\QualityControl;
use App\Notifications\QualityControlDueReminder;
use Carbon\Carbon;

class CheckQualityControlOverduaStatus extends Command
{

    protected $signature = 'app:check-quality-control-overdua-status';

    protected $description = 'Check Quality Controls and send due reminders or mark overdue ones';


   public function handle()
    {
        $today = Carbon::today();
        $reminderDate = $today->copy()->addDays(7);

        // 1️⃣ Find QualityControls due in exactly 7 days
        $dueSoon = QualityControl::whereDate('end_date', $reminderDate)
            ->whereIn('status', ['Pending', 'In Progress'])
            ->get();

        foreach ($dueSoon as $qc) {
            // Notify all assigned users
            if ($qc->users->isNotEmpty()) {
                Notification::send($qc->users, new QualityControlDueReminder($qc));
            }

            // Notify approvers if any
            if ($qc->approvers->isNotEmpty()) {
                Notification::send($qc->approvers, new QualityControlDueReminder($qc));
            }

              // ✅ Also send reminder to admin
            Notification::route('mail', 'AVSEC@caa.co.zm')
                ->notify(new QualityControlDueReminder($qc));


            $this->info("Reminder sent for QC: {$qc->title}");
        }

        // 2️⃣ Mark records as Overdue where end_date < today and not already completed
        $overdueRecords = QualityControl::whereDate('end_date', '<', $today)
            ->whereNotIn('status', ['Completed', 'Overdue'])
            ->get();

        foreach ($overdueRecords as $qc) {
            $qc->update(['status' => 'Overdue']);
            $this->info("Marked as Overdue: {$qc->title}");
        }

        foreach ($overdueRecords as $qc) {
            $qc->update(['status' => 'Overdue']);
            $this->info("Marked as Overdue: {$qc->title}");

             // ✅ Send overdue alert to admin
            Notification::route('mail', 'AVSEC@caa.co.zm')
                ->notify(new QualityControlDueReminder($qc));

        }


        $this->info('Quality Control status check completed successfully.');
        return 0;
    }
}

<?php

namespace App\Console\Commands;

use App\Models\QualityControl;
use Illuminate\Console\Command;
use App\Notifications\SecurityConcernReminder;

class SendWeeklySecurityConcernReminder extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'security:weekly-reminder';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Send weekly email reminder for unresolved security concerns';

    /**
     * Execute the console command.
     */
    public function handle()
    {
        // Fetch all QualityControls that have unresolved security concerns
        $concerns = QualityControl::whereHas('selectedchecklistQuestions', function ($query) {
            $query->where('finding_category', '!=', 'Not Applicable')
                  ->where('status', '!=', 'Resolved'); 
        })->with(['users', 'approvers', 'selectedchecklistQuestions'])->get();

        if ($concerns->isEmpty()) {
            $this->info('No security concerns to send.');
            return;
        }

        // Collect all assigned users & approvers
        $users = collect();
        foreach ($concerns as $concern) {
            $users = $users->merge($concern->users);
            $users = $users->merge($concern->approvers);
        }

        $users = $users->unique('id'); // Remove duplicates

        foreach ($users as $user) {
            $user->notify(new SecurityConcernReminder($concerns));
        }

        $this->info('Weekly reminder sent to ' . $users->count() . ' users.');
    }
}

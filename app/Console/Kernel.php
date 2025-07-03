<?php

namespace App\Console;

use Illuminate\Console\Scheduling\Schedule;
use Illuminate\Foundation\Console\Kernel as ConsoleKernel;

class Kernel extends ConsoleKernel
{
    /**
     * Register the commands for the application.
     */
    

    /**
     * Define the application's command schedule.
     */
    protected function schedule(Schedule $schedule): void
    {
        // Schedule the custom reminder email command
        // $schedule->command('emails:reminder')
        //          ->dailyAt('09:00')            // Run every day at 9:00 AM
        //          ->withoutOverlapping()        // Prevent overlapping if it takes long
        //          ->onOneServer()               // For load-balanced apps
        //          ->runInBackground();          // Don't block other jobs

        $schedule->command('app:send-reminder-emails')
                 ->everyMinute()          // Run every day at 9:00 AM
                 ->withoutOverlapping()        // Prevent overlapping if it takes long
                 ->onOneServer()               // For load-balanced apps
                 ->runInBackground();          // Don't block other jobs

    }

    protected function commands(): void
    {
        $this->load(__DIR__.'/Commands');

        require base_path('routes/console.php');
    }
}

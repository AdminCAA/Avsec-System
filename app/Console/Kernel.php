<?php

namespace App\Console;

use Illuminate\Console\Scheduling\Schedule;
use Illuminate\Foundation\Console\Kernel as ConsoleKernel;
use Symfony\Component\HttpKernel\HttpKernel;

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
      

        $schedule->command('app:send-reminder-emails')
                 ->everyMinute()          // Run every day at 9:00 AM
                 ->withoutOverlapping()        // Prevent overlapping if it takes long
                 ->onOneServer()               // For load-balanced apps
                 ->runInBackground();          // Don't block other jobs
        
        $schedule->command('app:check-quality-control-status')
                 ->everyMinute()          // Run every day at 9:00 AM
                 ->withoutOverlapping()        // Prevent overlapping if it takes long
                 ->onOneServer()               // For load-balanced apps
                 ->runInBackground();  
                 
    // Don't block other jobs
    //  New: Send maintenance reminders 14 days before due date
        $schedule->command('maintenance:send-reminders')
                 ->everyMinute()               // for testing; change to ->dailyAt('08:00') in production
                 ->withoutOverlapping()
                 ->onOneServer()
                 ->runInBackground();

        // --- NEW: Weekly Security Concerns Reminder ---
        $schedule->command('security:weekly-reminder')
                ->weekly()
                ->fridays()
                ->at('09:00')
                ->withoutOverlapping()
                ->onOneServer()
                ->runInBackground();

         //
         $schedule->command('app:check-quality-control-overdua-status')
                ->weekly()
                ->fridays()
                ->at('08:00')
                ->withoutOverlapping()
                ->onOneServer()
                ->runInBackground();

    }

    protected function commands(): void
    {
        $this->load(__DIR__.'/Commands');

        require base_path('routes/console.php');
    }
}

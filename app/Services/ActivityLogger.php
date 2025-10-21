<?php

namespace App\Services;

use Monolog\Logger;
use Monolog\Handler\StreamHandler;
use Monolog\Formatter\LineFormatter;
use Monolog\Level;

class ActivityLogger
{
    private Logger $logger;

    public function __construct()
    {
        // Date format for log entries
        $dateFormat = "j F Y, g:i a";

        // Log line format
        $output = "%datetime% > %level_name% > %message% %context% %extra%\n";
        $formatter = new LineFormatter($output, $dateFormat, true, true);

        // Create Monolog instance
        $this->logger = new Logger('activity_logger');

        
        $fileHandler = new StreamHandler(
            storage_path('logs/activity_logs.log'),
            Level::Info
        );

        $fileHandler->setFormatter($formatter);

        // Stdout handler (shows logs in console)
        $stdoutHandler = new StreamHandler(
            'php://stdout',
            Level::Info
        );
        $stdoutHandler->setFormatter($formatter);

        // Push handlers to the logger
        $this->logger->pushHandler($fileHandler);
        $this->logger->pushHandler($stdoutHandler);
    }

    /**
     * Log an info message
     */
    public function info(string $message, array $context = []): void
    {
        $this->logger->info($message, $context);
    }

    /**
     * Log a warning message
     */
    public function warning(string $message, array $context = []): void
    {
        $this->logger->warning($message, $context);
    }

    /**
     * Log an error message
     */
    public function error(string $message, array $context = []): void
    {
        $this->logger->error($message, $context);
    }
}

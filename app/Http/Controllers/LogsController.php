<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Collection;
use Inertia\Inertia;
use Illuminate\Routing\Controllers\HasMiddleware;
use Illuminate\Routing\Controllers\Middleware;

class LogsController extends Controller implements HasMiddleware
{
   
    public static function middleware(): array
    {
        return [
            new Middleware('permission:view activity logs', only: ['index', 'clearLogs']),
        ];
    }

    public function index(Request $request)
    {
        $logFile = storage_path('logs/activity_logs.log');
        $logs = collect();

        if (file_exists($logFile)) {
            $lines = file($logFile, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);

            // Parse each line into structured data
            foreach ($lines as $line) {
                preg_match('/^(.*?) > (.*?) > (.*)$/', $line, $matches);
                $logs->push([
                    'datetime' => $matches[1] ?? '',
                    'level'    => $matches[2] ?? '',
                    'message'  => $matches[3] ?? $line,
                ]);
            }

            // Reverse to show latest first
            $logs = $logs->reverse()->values();

            // Pagination setup
            $perPage = 50;
            $page = $request->get('page', 1);
            $offset = ($page - 1) * $perPage;

            $paginatedLogs = new LengthAwarePaginator(
                $logs->slice($offset, $perPage)->values(),
                $logs->count(),
                $perPage,
                $page,
                ['path' => $request->url(), 'query' => $request->query()]
            );
        } else {
            // Empty paginator when file doesn’t exist
            $paginatedLogs = new LengthAwarePaginator([], 0, 50, 1);
        }

        return Inertia::render('Logs/List', [
            'logs' => $paginatedLogs,
        ]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //

    }

    public function clearLogs(Request $request)
    {
        $logFile = storage_path('logs/activity_logs.log');
        if (file_exists($logFile)) {
            file_put_contents($logFile, ''); // Clear the log file
            // Return 200 OK JSON response instead of redirect
            return response()->json([
                'success' => true,
                'message' => 'Activity logs cleared successfully.'
            ], 200);
        } else {
            return response()->json([
                'success' => false,
                'error' => 'Log file does not exist.'
            ], 404);
        }
    }
}

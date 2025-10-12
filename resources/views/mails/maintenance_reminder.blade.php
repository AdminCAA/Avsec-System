<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Maintenance Reminder</title>
</head>

<body 
style="font-family: Arial, sans-serif; background-color: #f4f4f4; padding: 20px;">
    <div style="max-width: 600px; background-color: #ffffff; margin: 0 auto; padding: 20px; border-radius: 8px;">
        
        <h2>Hello Administrator,</h2>
        <h4 style="color: #333;">Maintenance Reminder</h4>

        <p>This is a reminder that the following maintenance schedule is due soon:</p>

        <ul>
            <li><strong>Equipment Name:</strong> {{ $schedule->securityEquipment->name }}</li>
            <li><strong>Maintenance Type:</strong> {{ ucfirst($schedule->maintenance_type) }}</li>
            <li><strong>Next Due Date:</strong>
                {{ \Carbon\Carbon::parse($schedule->next_due_date)->toFormattedDateString() }}</li>
            <li><strong>Assigned To:</strong> {{ $schedule->assigned_to ?? 'N/A' }}</li>
            <li><strong>Description:</strong> {{ $schedule->description ?? 'No description provided' }}</li>
        </ul>

        <p>Please take the necessary action before the due date.</p>
        <a href="{{ route('welcome') }}" class="button"
        style="display:inline-block; padding:10px 20px; background:#212530; color:white; text-decoration:none; border-radius:5px;">
        Click to Login
    </a>

        <p>Thanks,<br>{{ config('app.name') }}</p>
    </div>
</body>

</html>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Security Concerns Reminder</title>
</head>
<body style="font-family: Arial, sans-serif; font-size: 14px;">
    <p>Dear {{ $notifiable->name }},</p>

    @php
        // Count all open questions
        $totalOpen = 0;
        foreach($concerns as $concern) {
            foreach($concern->selectedchecklistQuestions as $question) {
                if($question->status === 'Open') {
                    $totalOpen++;
                }
            }
        }
    @endphp

    <p>Here is a list of open security concerns that require your attention. 
       <strong>Total open concerns: {{ $totalOpen }}</strong>
    </p>

    <table cellpadding="0" cellspacing="0" border="1" style="border-collapse:collapse;width:100%;">
        <thead>
            <tr style="background-color:#f2f2f2">
                <th style="border:1px solid #ddd;padding:5px">ID</th>
                <th style="border:1px solid #ddd;padding:5px">Question</th>
                <th style="border:1px solid #ddd;padding:5px">Quality Control</th>
                <th style="border:1px solid #ddd;padding:5px">Type</th>
                <th style="border:1px solid #ddd;padding:5px">Category</th>
                <th style="border:1px solid #ddd;padding:5px">Status</th>
                <th style="border:1px solid #ddd;padding:5px">Last Updated</th>
            </tr>
        </thead>
        <tbody>
            @foreach($concerns as $concern)
                @foreach($concern->selectedchecklistQuestions as $question)
                    @if($question->status === 'Open')
                        <tr>
                            <td style="border:1px solid #ddd;padding:5px">{{ $question->id }}</td>
                            <td style="border:1px solid #ddd;padding:5px">{!! nl2br(e($question->question)) !!}</td>
                            <td style="border:1px solid #ddd;padding:5px">{{ $concern->title }}</td>
                            <td style="border:1px solid #ddd;padding:5px">{{ $concern->control_type }}</td>
                            <td style="border:1px solid #ddd;padding:5px">{{ $question->finding_category }}</td>
                            <td style="border:1px solid #ddd;padding:5px;color:red;font-weight:bold">{{ $question->status }}</td>
                            <td style="border:1px solid #ddd;padding:5px">{{ $question->updated_at->format('d-m-Y') }}</td>
                        </tr>
                    @endif
                @endforeach
            @endforeach
        </tbody>
    </table>

    <p>Please address them promptly to ensure compliance and safety.</p>

    <p>Regards,<br>Avsec System</p>
</body>
</html>



















{{-- <!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Security Concerns Reminder</title>
</head>
<body style="font-family: Arial, sans-serif; font-size: 14px;">
    <p>Dear {{ $notifiable->name }},</p>

    <p>Here is a list of open security concerns that require your attention:</p>

    <table cellpadding="0" cellspacing="0" border="1" style="border-collapse:collapse;width:100%;">
        <thead>
            <tr style="background-color:#f2f2f2">
                <th style="border:1px solid #ddd;padding:5px">ID</th>
                <th style="border:1px solid #ddd;padding:5px">Question</th>
                <th style="border:1px solid #ddd;padding:5px">Quality Control</th>
                <th style="border:1px solid #ddd;padding:5px">Type</th>
                <th style="border:1px solid #ddd;padding:5px">Category</th>
                <th style="border:1px solid #ddd;padding:5px">Status</th>
                <th style="border:1px solid #ddd;padding:5px">Last Updated</th>
            </tr>
        </thead>
        <tbody>
            @foreach($concerns as $concern)
                @foreach($concern->selectedchecklistQuestions as $question)
                    @if($question->status === 'Open')
                        <tr>
                            <td style="border:1px solid #ddd;padding:5px">{{ $question->id }}</td>
                            <td style="border:1px solid #ddd;padding:5px">{!! nl2br(e($question->question)) !!}</td>
                            <td style="border:1px solid #ddd;padding:5px">{{ $concern->title }}</td>
                            <td style="border:1px solid #ddd;padding:5px">{{ $concern->control_type }}</td>
                            <td style="border:1px solid #ddd;padding:5px">{{ $question->finding_category }}</td>
                            <td style="border:1px solid #ddd;padding:5px;color:red;font-weight:bold">{{ $question->status }}</td>
                            <td style="border:1px solid #ddd;padding:5px">{{ $question->updated_at->format('d-m-Y') }}</td>
                        </tr>
                    @endif
                @endforeach
            @endforeach
        </tbody>
    </table>

    <p>Please address them promptly to ensure compliance and safety.</p>

    <p>Regards,<br>Avsec System</p>
</body>
</html> --}}

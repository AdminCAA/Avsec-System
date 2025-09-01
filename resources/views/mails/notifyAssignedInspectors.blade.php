<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>New Quality Control Assigned</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            color: #333;
        }

        h2 {
            color: #2C3E50;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }

        th,
        td {
            text-align: left;
            padding: 10px;
            border: 1px solid #ddd;
        }

        th {
            background-color: #f5f5f5;
        }

        .button {
            display: inline-block;
            margin-top: 20px;
            padding: 12px 20px;
            font-size: 16px;
            color: #fff;
            background-color: #3490dc;
            text-decoration: none;
            border-radius: 5px;
        }

        .button:hover {
            background-color: #2779bd;
        }

        .footer {
            margin-top: 20px;
            font-size: 14px;
            color: #555;
        }
    </style>
</head>

<body>

    <p>Dear {{ $user->name }},</p>
    <p>A new quality control has been assigned to you. Please login to review the quality control task  accordingly.</p>

    {{-- <table>
        <tr>
            <th>Operator</th>
            <td>{{ $application->user->email ?? $application->operator }}</td>
        </tr>
        <tr>
            <th>Aircraft Type</th>
            <td>{{ $application->aircraft->aircraftType ?? 'N/A' }}</td>
        </tr>
        <tr>
            <th>Aircraft Registration</th>
            <td>{{ $application->aircraft->registration ?? 'N/A' }}</td>
        </tr>
        <tr>
            <th>Submitted By </th>
            <td>{{ $application->user->name ?? $application->operator }}</td>
        </tr>
        <tr>
            <th>Flight Type</th>
            <td>{{ $application->flight_type ?? 'N/A' }}</td>
        </tr>
        <tr>
            <th>Departure Airport</th>
            <td>{{ $application->departure_airport ?? 'N/A' }}</td>
        </tr>
        <tr>
            <th>Destination Airport</th>
            <td>{{ $application->destination_airport ?? 'N/A' }}</td>
        </tr>
        <tr>
            <th>Departure Date & Time</th>
            <td>{{ $application->departure_date_time->format('d M Y, H:i') ?? 'N/A' }}</td>
        </tr>
        <tr>
            <th>Purpose of Flight</th>
            <td>{{ $application->purpose_of_flight ?? 'N/A' }}</td>
        </tr>
    </table> --}}

    <a href="{{ route('welcome') }}" class="button"
        style="display:inline-block; padding:10px 20px; background:#212530; color:white; text-decoration:none; border-radius:5px;">
        Click to Login
    </a>

    <p class="footer">
        This is an automated email from your AVSEC Information System.
    </p>
</body>

</html>

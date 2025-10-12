<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Quality Control Approval Notification</title>
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
    <p>A new quality control has been assigned to you awaiting your approval.This will enable inspectors to begin working on the task promptly.</p>
    <p>Please login to review and approve the quality control task  accordingly.</p>

    <a href="{{ route('welcome') }}" class="button"
        style="display:inline-block; padding:10px 20px; background:#212530; color:white; text-decoration:none; border-radius:5px;">
        Click to Login
    </a>

    <p class="footer">
        This is an automated email from the AVSEC Information System.
    </p>
</body>

</html>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Quality Control PDF</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            font-size: 10px;
            color: #333;
            margin: 10px;
        }

        h2, h3 {
            color: #1a1a1a;
            margin-bottom: 5px;
        }

        h3 {
            margin-top: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
            font-size: 9px;
        }

        th, td {
            border: 1px solid #888;
            padding: 4px;
            text-align: left;
        }

        th {
            background-color: #F6F6F6;
            color: #333;
            font-weight: bold;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        /* Horizontal header info */
        .header-info th, .header-info td {
            border: none;
            padding: 6px 10px;
            text-align: left;
        }

        .header-info th {
            font-weight: bold;
        }

        /* ---------- COVER PAGE ---------- */
        .cover-page {
            text-align: center;
            height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            page-break-after: always;
        }

        .cover-page img {
            height: 180px;
            margin-bottom: 25px;
        }

        .cover-page h1 {
            margin: 0;
            font-size: 32px;
            font-weight: 800;
            color: #44444E;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .cover-page h2 {
            margin: 20px 0 25px;
            font-size: 26px;
            color: #000;
            text-transform: uppercase;
        }

        .cover-date {
            font-size: 16px;
            color: #333;
            margin-top: 10px;
        }
    </style>
</head>
<body>

    <!-- Cover Page -->
    <div class="cover-page">
        <img src="{{ public_path('assets/caa-logo.png') }}" alt="CAA Logo">
        <h1>CIVIL AVIATION AUTHORITY</h1>
        <h2>QUALITY CONTROL - CHECKLIST QUESTIONS REPORT</h2>
        <p class="cover-date">Generated on: {{ \Carbon\Carbon::now()->format('d-m-Y H:i') }}</p>
    </div>

    <!-- Horizontal Quality Control Header -->
    <table class="header-info">
        <tbody>
            <tr>
                <th>TITLE</th>
                <td>{{ $qualityControl->title }}</td>
                <th>TYPE</th>
                <td>{{ $qualityControl->control_type }}</td>
                <th>OPERATOR</th>
                <td>{{ $qualityControl->facility->name }}</td>
                <th>SCHEDULED DATE</th>
                <td>{{ $qualityControl->scheduled_date }}</td>
                <th>STATUS</th>
                <td>{{ $qualityControl->status }}</td>
            </tr>
        </tbody>
    </table>

    <!-- Checklist Questions Table -->
    <h3>Checklist Questions</h3>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Audit Area Name</th>
                <th>Question</th>
                <th>Response</th>
                {{-- <th>Observation</th> --}}
                <th>Finding Category</th>
                <th>Date QC</th>
                {{-- <th>Follow Up Action</th>
                <th>Corrective Action</th>
                <th>Recommendations</th>
                <th>Reference</th> --}}
                <th>Status</th>

                {{-- <th>Action Taken</th>
                <th>Problem Cause</th>
                <th>Short Term Action</th>
                <th>Long Term Action</th>
                <th>Completion Date</th>
                <th>Follow Up Date</th> --}}
               
                {{-- <th>Date of Closure</th> --}}
               
                {{-- <th>Short Term Date</th>
                <th>Long Term Date</th>
                <th>CAP File</th>
                <th>CAP Status</th>
                <th>Reason for Rejection</th> --}}
                
                {{-- <th>Evidence File</th> --}}
            </tr>
        </thead>
        <tbody>
            @foreach($questions as $q)
            <tr>
                <td>{{ $q['id'] }}</td>
                <td>{{ $q['audit_area_name'] }}</td>
                <td>{{ $q['question'] }}</td>
                <td>{{ $q['question_response'] }}</td>
                {{-- <td>{{ $q['finding_observation'] }}</td> --}}
                <td>{{ $q['finding_category'] }}</td>
                <td>{{ $q['date_quality_control'] }}</td>
                {{-- <td>{{ $q['proposed_follow_up_action'] }}</td>
                <td>{{ $q['immediate_corrective_action'] }}</td>
                <td>{{ $q['recommendations'] }}</td>
                <td>{{ $q['reference'] }}</td> --}}
                <td>{{ $q['status'] }}</td>


                {{-- <td>{{ $q['action_taken'] }}</td>
                <td>{{ $q['problem_cause'] }}</td>
                <td>{{ $q['short_term_action'] }}</td>
                <td>{{ $q['long_term_action'] }}</td>
                <td>{{ $q['completion_date'] }}</td>
                <td>{{ $q['follow_up_date'] }}</td>

                
                <td>{{ $q['date_of_closure'] }}</td>
                
               
                <td>{{ $q['short_term_date'] }}</td>
                <td>{{ $q['long_term_date'] }}</td>
                <td>{{ $q['cap_file'] }}</td>
                <td>{{ $q['cap_status'] }}</td>
                <td>{{ $q['reason_for_rejection'] }}</td>
               
                <td>{{ $q['evidence_file'] }}</td> --}}
            </tr>
            @endforeach
        </tbody>
    </table>
</body>
</html>

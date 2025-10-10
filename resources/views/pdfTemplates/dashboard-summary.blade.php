<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <title>Dashboard Summary</title>
    <style>
        body {
            font-family: 'Poppins', 'Segoe UI', sans-serif;
            margin: 30px;
            color: #2c3e50;
        }

        h1,
        h2,
        h3 {
            color: #2c3e50;
            text-align: center;
            margin-bottom: 10px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 25px;
        }

        th,
        td {
            border: 1px solid #999;
            padding: 8px;
            font-size: 12px;
        }

        th {
            background: #f2f2f2;
            text-align: center;
        }

        td:first-child {
            text-align: left;
        }

        td:last-child {
            text-align: center;
        }

        .cover-page {
            text-align: center;
            margin-top: 150px;
        }

        .cover-page h1 {
            font-size: 28px;
            color: #2c3e50;
        }

        .cover-page p {
            margin-top: 20px;
            font-size: 14px;
            color: #555;
        }

        .page-break {
            page-break-after: always;
        }

        .header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 10px;
            border-bottom: 2px solid #ddd;
            padding-bottom: 8px;
        }

        .header img {
            height: 80px;
        }

        .header h4 {
            margin: 0;
            font-size: 16px;
            font-weight: bold;
            color: #2c3e50;
        }

        .chart-section {
            margin-top: 40px;
        }

        .chart-container {
            display: inline-block;
            width: 48%;
            margin: 1%;
            text-align: center;
            page-break-inside: avoid;
        }

        .chart-container img {
            max-width: 100%;
            height: auto;
            border: 1px solid #ccc;
            margin-bottom: 5px;
        }
    </style>
</head>

<body>

    <!-- Header with logo and title centered -->
    <div class="header" style="text-align: center; margin-bottom: 30px;">
        <img src="{{ public_path('assets/caa-logo.png') }}" alt="CAA Logo"
            style="height: 100px; display: block; margin: 0 auto;">
        <h4 style="margin: 10px 0 0 0; font-size: 18px;">CIVIL AVIATION AUTHORITY</h4>
    </div>

    <!-- Cover Page -->
    <div class="cover-page">
        <h1>COMPLIANCES STATISTIC SUMMARY REPORT</h1>
        <p><strong>Period:</strong> {{ $startDate ?? 'All Time' }} — {{ $endDate ?? 'Present' }}</p>
        <p><strong>Generated On:</strong> {{ now()->format('F j, Y, g:i a') }}</p>
    </div>

    <div class="page-break"></div>

    <!-- Summary Table -->
    <h2>Quality Control Summary</h2>
    <table>
        <thead>
            <tr>
                <th>Category</th>
                <th>Total</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>Total Audits</td>
                <td>{{ $stats['totalAudits'] }}</td>
            </tr>
            <tr>
                <td>Total Inspections</td>
                <td>{{ $stats['totalInspections'] }}</td>
            </tr>
            <tr>
                <td>Total Security Tests</td>
                <td>{{ $stats['totalSecurityTests'] }}</td>
            </tr>
            <tr>
                <td>Total Security Concerns</td>
                <td>{{ $stats['totalSecurityConcerns'] }}</td>
            </tr>
            <tr>
                <td>Pending</td>
                <td>{{ $stats['pendingQualityControls'] }}</td>
            </tr>
            <tr>
                <td>In Progress</td>
                <td>{{ $stats['inProgressQualityControls'] }}</td>
            </tr>
            <tr>
                <td>Completed</td>
                <td>{{ $stats['completedQualityControls'] }}</td>
            </tr>
            <tr>
                <td>Overdue</td>
                <td>{{ $stats['overdueQualityControls'] }}</td>
            </tr>
        </tbody>
    </table>

    <!-- Charts Section -->
    @if(!empty($charts))
        <div class="chart-section">
            <h2>Charts Overview</h2>
            @foreach($charts as $index => $chart)
                <div class="chart-container">
                    <img src="{{ $chart }}" alt="Chart {{ $index + 1 }}">
                    <p><strong>Chart {{ $index + 1 }}</strong></p>
                </div>
            @endforeach
        </div>
    @endif

</body>

</html>


{{--
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <title>Dashboard Summary Report</title>
    <style>
        body {
            font-family: DejaVu Sans, sans-serif;
            color: #333;
            font-size: 12px;
            margin: 20px;
        }

        h1,
        h2,
        h3 {
            text-align: center;
            color: #222;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }

        th,
        td {
            border: 1px solid #999;
            padding: 6px;
            text-align: left;
        }

        .chart-container {
            text-align: center;
            margin-top: 25px;
            page-break-inside: avoid;
        }

        .chart-container img {
            max-width: 100%;
            height: auto;
            border: 1px solid #ccc;
            margin-bottom: 10px;
        }

        .summary-section {
            margin-bottom: 20px;
        }
    </style>
</head>

<body>
    <h1>Dashboard Summary Report</h1>
    <p style="text-align:center;">
        Period: <strong>{{ $startDate ?? 'N/A' }}</strong> to <strong>{{ $endDate ?? 'N/A' }}</strong>
    </p>

    <div class="summary-section">
        <h3>Summary Statistics</h3>
        <table>
            <tr>
                <th>Total Audits</th>
                <td>{{ $stats['totalAudits'] }}</td>
            </tr>
            <tr>
                <th>Total Inspections</th>
                <td>{{ $stats['totalInspections'] }}</td>
            </tr>
            <tr>
                <th>Total Security Tests</th>
                <td>{{ $stats['totalSecurityTests'] }}</td>
            </tr>
            <tr>
                <th>Total Security Concerns</th>
                <td>{{ $stats['totalSecurityConcerns'] }}</td>
            </tr>
        </table>
    </div>

    @if(!empty($charts))
    <div class="chart-section">
        <h3>Charts Overview</h3>
        @foreach($charts as $index => $chart)
        <div class="chart-container">
            <img src="{{ $chart }}" alt="Chart {{ $index + 1 }}">
            <p><strong>Chart {{ $index + 1 }}</strong></p>
        </div>
        @endforeach
    </div>
    @endif




    @if(!empty($charts))
    <div class="chart-section">
        <h3>Charts Overview dee</h3>
        @foreach($charts as $index => $chart)
        <div class="chart-container">
            <img src="{{ $chart }}" alt="Chart {{ $index + 1 }}">
            <p><strong>Chart {{ $index + 1 }}</strong></p>
        </div>
        @endforeach
    </div>
    @endif


</body>

</html> --}}
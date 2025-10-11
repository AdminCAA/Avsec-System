<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>{{ $facility->name }} - Quality Control Report</title>
    <style>
        body {
            font-family: DejaVu Sans, sans-serif;
            font-size: 12px;
            margin: 25px;
            color: #000;
        }

        /* --- Cover Page Styles --- */
        .cover-page {
            text-align: center;
            margin-top: 150px;
        }

        .cover-logo {
            height: 120px;
            margin-bottom: 20px;
        }

        .cover-title {
            font-size: 26px;
            font-weight: bold;
            margin-top: 20px;
            text-transform: uppercase;
        }

        .cover-subtitle {
            font-size: 18px;
            margin-top: 10px;
        }

        .cover-date {
            font-size: 14px;
            margin-top: 40px;
        }

        /* --- Main Report Styles --- */
        h2, h3 {
            text-align: center;
            margin-bottom: 10px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 12px;
        }

        th, td {
            border: 1px solid #44444E;
            padding: 6px;
            text-align: left;
            vertical-align: top;
        }

        th {
            background-color: #f0f0f0;
        }

        .section {
            margin-bottom: 25px;
        }

        .info-table {
            width: 100%;
            margin-top: 10px;
            border-collapse: collapse;
        }

        .info-table td {
            padding: 6px;
            vertical-align: top;
        }

        .summary-table th, .summary-table td {
            text-align: center;
        }

        .footer {
            margin-top: 20px;
            font-size: 11px;
            text-align: center;
            border-top: 1px solid #ccc;
            padding-top: 8px;
        }
    </style>
</head>
<body>

    <!-- Cover Page -->
    <div class="cover-page">
        <div class="header">
            <img src="{{ public_path('assets/caa-logo.png') }}" alt="CAA Logo" class="cover-logo">
            <h4 style="margin: 10px 0 0 0; font-size: 18px;">CIVIL AVIATION AUTHORITY</h4>
        </div>

        <h1 class="cover-title">QUALITY CONTROL REPORT</h1>
        <p class="cover-subtitle"><strong>Operator:</strong> {{ $facility->name }}</p>

        <p class="cover-date">
            <strong>Generated on:</strong> {{ now()->format('d F Y, H:i') }}
        </p>
    </div>

    <!-- Page Break -->
    <div style="page-break-after: always;"></div>

    <!-- Report Section -->
    {{-- <h2>{{ $facility->name }}</h2> --}}
    {{-- <h3>Quality Control Report</h3> --}}

    <!-- Summary Table -->
    <div class="section">
        <h3>Summary</h3>
        <table class="summary-table">
            <thead>
                <tr>
                    <th>Audits</th>
                    <th>Inspections</th>
                    <th>Security Tests</th>
                    <th>Certified Personnel</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>{{ $qualityControlCounts['audits'] }}</td>
                    <td>{{ $qualityControlCounts['inspections'] }}</td>
                    <td>{{ $qualityControlCounts['securityTests'] }}</td>
                    <td>{{ $usersCount }}</td>
                </tr>
            </tbody>
        </table>
    </div>

    <!-- Facility Info -->
    <div class="section">
        <table class="info-table">
            <tr>
                <td><strong>Category:</strong> {{ $facility->category }}</td>
                <td><strong>Location:</strong> {{ $facility->location }}</td>
            </tr>
            <tr>
                <td><strong>Email:</strong> {{ $facility->email }}</td>
                <td><strong>Contact:</strong> {{ $facility->contact_number }}</td>
            </tr>
            <tr>
                <td><strong>Address:</strong> {{ $facility->address }}</td>
                <td><strong>Date Generated:</strong> {{ now()->format('d M Y') }}</td>
            </tr>
        </table>
    </div>

    <!-- Quality Control Records -->
    <div class="section">
        <h3>Detailed Quality Control Records</h3>
        <table>
            <thead>
                <tr>
                    <th>#</th>
                    <th>Control Type</th>
                    <th>Title</th>
                    <th>Description</th>
                    <th>Start Date</th>
                    <th>End Date</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                @foreach($qualityControls as $index => $qc)
                    <tr>
                        <td>{{ $index + 1 }}</td>
                        <td>{{ $qc->control_type }}</td>
                        <td>{{ $qc->title }}</td>
                        <td>{{ $qc->description }}</td>
                        <td>{{ \Carbon\Carbon::parse($qc->scheduled_date)->format('d-m-Y') }}</td>
                        <td>{{ \Carbon\Carbon::parse($qc->end_date)->format('d-m-Y') }}</td>
                        <td>{{ $qc->status }}</td>
                    </tr>
                @endforeach
            </tbody>
        </table>
    </div>

    <!-- Certified Personnel Table -->
    <div class="section">
        <h3>Certified Personnel</h3>
        <table>
            <thead>
                <tr>
                    <th>#</th>
                    <th>Full Name</th>
                    <th>Email</th>
                </tr>
            </thead>
            <tbody>
                @forelse($facility->users as $index => $user)
                    <tr>
                        <td>{{ $index + 1 }}</td>
                        <td>{{ $user->name }}</td>
                        <td>{{ $user->email }}</td>
                    </tr>
                @empty
                    <tr>
                        <td colspan="3" style="text-align:center;">No certified personnel found</td>
                    </tr>
                @endforelse
            </tbody>
        </table>
    </div>

    <div class="footer">
        Generated by Aviation Security Information Management System (ASIMS) - {{ now()->format('d M Y, H:i') }}
    </div>
</body>
</html>



{{-- <!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>{{ $facility->name }} - Quality Control Report</title>
    <style>
        body {
            font-family: DejaVu Sans, sans-serif;
            font-size: 12px;
            margin: 25px;
            color: #000;
        }
        h2, h3 {
            text-align: center;
            margin-bottom: 10px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 12px;
        }
        th, td {
            border: 1px solid #000;
            padding: 6px;
            text-align: left;
            vertical-align: top;
        }
        th {
            background-color: #f0f0f0;
        }
        .section {
            margin-bottom: 25px;
        }
        /* .info-table td {
            border: none;
            padding: 4px 0;
        } */

        .info-table {
            width: 100%;
            margin-top: 10px;
            border-collapse: collapse;
        }
        .info-table td {
            padding: 6px;
            vertical-align: top;
        }
        .summary-table th, .summary-table td {
            text-align: center;
        }
        .footer {
            margin-top: 20px;
            font-size: 11px;
            text-align: center;
            border-top: 1px solid #ccc;
            padding-top: 8px;
        }
    </style>
</head>
<body>
    <h2>{{ $facility->name }}</h2>
    <h3>Quality Control Report</h3>

    <!-- Summary Table -->
    <div class="section">
        <h3>Summary</h3>
        <table class="summary-table">
            <thead>
                <tr>
                    <th>Audits</th>
                    <th>Inspections</th>
                    <th>Security Tests</th>
                    <th>Certified Personnel</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>{{ $qualityControlCounts['audits'] }}</td>
                    <td>{{ $qualityControlCounts['inspections'] }}</td>
                    <td>{{ $qualityControlCounts['securityTests'] }}</td>
                    <td>{{ $usersCount }}</td>
                </tr>
            </tbody>
        </table>
    </div>

    <!-- Facility Info -->
    <div class="section">
        <table class="info-table">
            <tr>
                <td><strong>Category:</strong> {{ $facility->category }}</td>
                <td><strong>Location:</strong> {{ $facility->location }}</td>
            </tr>
            <tr>
                <td><strong>Email:</strong> {{ $facility->email }}</td>
                <td><strong>Contact:</strong> {{ $facility->contact_number }}</td>
            </tr>
            <tr>
                <td><strong>Address:</strong> {{ $facility->address }}</td>
                <td><strong>Date Generated:</strong> {{ now()->format('d M Y') }}</td>
            </tr>
        </table>
    </div>

    <!-- Quality Control Records -->
    <div class="section">
        <h3>Detailed Quality Control Records</h3>
        <table>
            <thead>
                <tr>
                    <th>#</th>
                    <th>Control Type</th>
                    <th>Title</th>
                    <th>Description</th>
                    <th>Start Date</th>
                    <th>End Date</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                @foreach($qualityControls as $index => $qc)
                    <tr>
                        <td>{{ $index + 1 }}</td>
                        <td>{{ $qc->control_type }}</td>
                        <td>{{ $qc->title }}</td>
                        <td>{{ $qc->description }}</td>
                        <td>{{ \Carbon\Carbon::parse($qc->scheduled_date)->format('d-m-Y') }}</td>
                        <td>{{ \Carbon\Carbon::parse($qc->end_date)->format('d-m-Y') }}</td>
                        <td>{{ $qc->status }}</td>
                    </tr>
                @endforeach
            </tbody>
        </table>
    </div>

    <!-- Certified Personnel Table -->
    <div class="section">
        <h3>Certified Personnel</h3>
        <table>
            <thead>
                <tr>
                    <th>#</th>
                    <th>Full Name</th>
                    <th>Email</th>
                </tr>
            </thead>
            <tbody>
                @forelse($facility->users as $index => $user)
                    <tr>
                        <td>{{ $index + 1 }}</td>
                        <td>{{ $user->name }}</td>
                        <td>{{ $user->email }}</td>
                    </tr>
                @empty
                    <tr>
                        <td colspan="3" style="text-align:center;">No certified personnel found</td>
                    </tr>
                @endforelse
            </tbody>
        </table>
    </div>

    <div class="footer">
        Generated by Aviation Secuirty Information Management System (ASIMS) - {{ now()->format('d M Y, H:i') }}
    </div>
</body>
</html> --}}

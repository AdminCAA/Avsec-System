<!DOCTYPE html>
<html>
<head>
    <title>Personnel Report</title>
    <style>
        body {
            font-family: 'Poppins', 'Segoe UI', sans-serif;
            font-size: 12px;
            line-height: 1.4;
        }

        .header,
        .cover {
            text-align: center;
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

        .section-title {
            margin-top: 30px;
            font-size: 18px;
            text-decoration: underline;
        }

        .info-section {
            display: flex;
            align-items: flex-start;
            margin-top: 20px;
        }

        .portrait {
            width: 120px;
            height: 120px;
            object-fit: cover;
            border-radius: 10px;
            border: 2px solid #ccc;
            margin-right: 25px;
        }

        .info-table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            border: 1px solid #333232;
            padding: 6px;
            text-align: left;
        }

        th {
            background-color: #d1cfcf;
        }

        .qual-table, .cert-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
    </style>
</head>
<body>

    <!-- Cover Page -->
    <div class="cover-page">
        <img src="{{ public_path('assets/caa-logo.png') }}" alt="CAA Logo">
        <h1>CIVIL AVIATION AUTHORITY</h1>
        <h2>AVSEC STAFF DETAIL REPORT</h2>
        <p class="cover-date">Generated on: {{ \Carbon\Carbon::now()->format('d-m-Y H:i') }}</p>
    </div>

    <!-- Personal Information -->
    <h3 class="section-title">Personal Information</h3>

    <div class="info-section">
        @if(!empty($personnel->portrait) && file_exists(public_path($personnel->portrait)))
            <img src="{{ public_path($personnel->portrait) }}" alt="Portrait" class="portrait">
        @else
            <img src="{{ public_path('assets/default-avatar.png') }}" alt="Default Portrait" class="portrait">
        @endif

        <table class="info-table">
            <tr>
                <th>Name</th>
                <td>{{ $personnel->name }}</td>
                <th>Gender</th>
                <td>{{ $personnel->gender }}</td>
            </tr>
            <tr>
                <th>Email</th>
                <td>{{ $personnel->email }}</td>
                <th>Phone</th>
                <td>{{ $personnel->phone_number }}</td>
            </tr>
            <tr>
                <th>NRC</th>
                <td>{{ $personnel->nrc }}</td>
                <th>Facility</th>
                <td>{{ $personnel->facility_name }}</td>
            </tr>
            <tr>
                <th>Category</th>
                <td>{{ $personnel->user_type }}</td>
                <th>Certification Status</th>
                <td>{{ $personnel->is_certified }}</td>
            </tr>
        </table>
    </div>

    <!-- Qualifications -->
    <h3 class="section-title">Qualifications</h3>
    @if($qualifications->isNotEmpty())
        <table class="qual-table">
            <thead>
                <tr>
                    <th>#</th>
                    <th>Name</th>
                    <th>Institution</th>
                    <th>Type</th>
                    <th>Date Obtained</th>
                    <th>Number</th>
                </tr>
            </thead>
            <tbody>
                @foreach($qualifications as $index => $q)
                    <tr>
                        <td>{{ $index + 1 }}</td>
                        <td>{{ $q->qualification_name }}</td>
                        <td>{{ $q->institution }}</td>
                        <td>{{ $q->qualification_type }}</td>
                        <td>{{ \Carbon\Carbon::parse($q->date_obtained)->format('d-m-Y') }}</td>
                        <td>{{ $q->qualification_number }}</td>
                    </tr>
                @endforeach
            </tbody>
        </table>
    @else
        <p>No qualifications available for this staff.</p>
    @endif

    <!-- Certifications -->
    {{-- <h3 class="section-title">Certifications</h3>
    @if($certifications->isNotEmpty())
        <table class="cert-table">
            <thead>
                <tr>
                    <th>#</th>
                    <th>Name</th>
                    <th>Issuer</th>
                    <th>Number</th>
                    <th>Date Issued</th>
                    <th>Expiry Date</th>
                    <th>Status</th>
                    <th>Score</th>
                </tr>
            </thead>
            <tbody>
                @foreach($certifications as $index => $c)
                    <tr>
                        <td>{{ $index + 1 }}</td>
                        <td>{{ $c->certification_name }}</td>
                        <td>{{ $c->certification_body }}</td>
                        <td>{{ $c->certification_number }}</td>
                        <td>{{ \Carbon\Carbon::parse($c->date_issued)->format('d-m-Y') }}</td>
                        <td>{{ \Carbon\Carbon::parse($c->expiry_date)->format('d-m-Y') }}</td>
                        <td>{{ $c->status }}</td>
                        <td>{{ $c->score }}%</td>
                    </tr>
                @endforeach
            </tbody>
        </table>
    @else
        <p>No certifications available for this staff.</p>
    @endif --}}

    <!-- Mandatory Course -->
    <h3 class="section-title">Mandatory Course</h3>
    @if($mandatorycourse->isNotEmpty())
        <table class="cert-table">
            <thead>
                <tr>
                    <th>#</th>
                    <th>Course Name</th>
                    <th>Training Center</th>
                    <th>Certificate No</th>
                    <th>Date Issued</th>
                    <th>Expiry Date</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                @foreach($mandatorycourse as $index => $c)
                    <tr>
                        <td>{{ $index + 1 }}</td>
                        <td>{{ $c->course_name }}</td>
                        <td>{{ $c->training_center }}</td>
                        <td>{{ $c->certificate_number }}</td>
                        <td>{{ \Carbon\Carbon::parse($c->date_issued)->format('d-m-Y') }}</td>
                        <td>{{ \Carbon\Carbon::parse($c->expiry_date)->format('d-m-Y') }}</td>
                        <td>{{ $c->status }}</td>
                    </tr>
                @endforeach
            </tbody>
        </table>
    @else
        <p>No mandatory course available for this staff.</p>
    @endif


     <!-- Specialised Training Course -->
    <h3 class="section-title">Mandatory Course</h3>
    @if($specialisedtraining->isNotEmpty())
        <table class="cert-table">
            <thead>
                <tr>
                    <th>#</th>
                    <th>Traning Name</th>
                    <th>Training Center</th>
                    <th>Certificate No</th>
                    <th>Date Issued</th>
                    <th>Expiry Date</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                @foreach($specialisedtraining as $index => $c)
                    <tr>
                        <td>{{ $index + 1 }}</td>
                        <td>{{ $c->training_name }}</td>
                        <td>{{ $c->training_center }}</td>
                        <td>{{ $c->certificate_number }}</td>
                        <td>{{ \Carbon\Carbon::parse($c->date_issued)->format('d-m-Y') }}</td>
                        <td>{{ \Carbon\Carbon::parse($c->expiry_date)->format('d-m-Y') }}</td>
                        <td>{{ $c->status }}</td>
                    </tr>
                @endforeach
            </tbody>
        </table>
    @else
        <p>No specialised training available for this staff.</p>
    @endif

</body>
</html>

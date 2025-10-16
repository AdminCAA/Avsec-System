<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <title>Protocol Report</title>
    <style>
        body {
            font-family: DejaVu Sans, sans-serif;
            font-size: 11px;
            color: #000;
        }

        h2 {
            text-align: center;
            font-size: 18px;
            margin-bottom: 5px;
        }

        h4 {
            text-align: center;
            font-size: 14px;
            margin-top: 0;
            margin-bottom: 20px;
            color: #555;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }

        th,
        td {
            border: 1px solid #444;
            padding: 6px;
            vertical-align: top;
        }

        th {
            background-color: #f0f0f0;
            text-align: center;
        }

        td {
            text-align: left;
        }

        .footer {
            position: fixed;
            bottom: 0;
            left: 0;
            right: 0;
            font-size: 10px;
            text-align: right;
            color: #555;
        }

        .page-break {
            page-break-after: always;
        }

        .logo {
            width: 70px;
            height: auto;
            position: absolute;
            top: 20px;
            left: 20px;
        }

        .header-text {
            text-align: center;
            margin-top: 20px;
        }

        .header-text h3 {
            margin: 0;
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
        <h2>PROTOCOL QUESTIONS REPORT</h2>
        <p class="cover-date">Generated on: {{ \Carbon\Carbon::now()->format('d-m-Y H:i') }}</p>
    </div>

    <!-- Report Content -->

    <div class="header-text">
        <h2>PROTOCOL QUESTIONS REPORT</h2>
        <h4>Detailed Summary of AVSEC Protocol Questions, References, and Evidences</h4>
    </div>


    <table>
        <thead>
            <tr>
                <th>#</th>
                <th>PQ No</th>
                <th>Question</th>
                <th>Answer Details</th>
                <th>References</th>
                <th>Evidences</th>
                <th>CE Type</th>
                <th>ICAO Ref</th>
                <th>Answer</th>
                <th>Responsible Entity</th>
                <th>Status</th>
            </tr>
        </thead>
        <tbody>
            @foreach ($protocolQuestions as $index => $question)
                <tr>
                    <td>{{ $index + 1 }}</td>
                    <td>{{ $question->pq_number }}</td>
                    <td>{{ $question->question }}</td>
                    <td>{{ $question->answer_details }}</td>

                    {{-- Reference Documents --}}
                    <td>
                        @if($question->referenceDocuments->count())
                            @foreach($question->referenceDocuments as $doc)
                                {{ $doc->name }} <br>
                            @endforeach
                        @else
                            -
                        @endif
                    </td>

                    {{-- Evidence Documents --}}
                    <td>
                        @if($question->evidenceDocuments->count())
                            @foreach($question->evidenceDocuments as $doc)
                                {{ $doc->name }} <br>
                            @endforeach
                        @else
                            -
                        @endif
                    </td>

                    <td>{{ $question->ce_category }}</td>
                    <td>{{ $question->icao_reference }}</td>
                    <td>{{ $question->answer }}</td>
                    <td>{{ $question->responsible_entity }}</td>
                    <td>{{ $question->status }}</td>
                </tr>
            @endforeach
        </tbody>
    </table>

    <div class="footer">
        Generated on {{ now()->format('d M Y, H:i') }}
    </div>

</body>

</html>
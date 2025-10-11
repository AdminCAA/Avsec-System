<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <title>Operators List</title>
    <style>
        body {
            font-family: 'Poppins', 'Segoe UI', sans-serif;
            font-size: 12px;
            margin: 0;
            padding: 0;
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

        .cover-page h2 {
            margin: 0;
            font-size: 32px;
            font-weight: 800;
            color: #44444E;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .cover-page h3 {
            margin: 20px 0 25px;
            font-size: 26px;
            /* Larger subtitle */
            color: #000;
            text-transform: uppercase;
        }

        .cover-date {
            font-size: 16px;
            color: #333;
            margin-top: 10px;
        }

        /* ---------- HEADER & TABLE ---------- */
        .header {
            text-align: center;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }

        th,
        td {
            border: 1px solid #000;
            padding: 6px;
            margin: 0;
        }

        th {
            background-color: #a8a8a8;
        }

        h4 {
            margin-top: 10px;
            margin-bottom: 5px;
        }
    </style>
</head>

<body>

    {{-- Cover Page --}}
    <div class="cover-page">
        <img src="{{ public_path('assets/caa-logo.png') }}" alt="CAA Logo">
        <h2>CIVIL AVIATION AUTHORITY</h2>
        <h3>AVSEC OPERATORS LIST</h3>
        <div class="cover-date">Generated on: {{ $generatedAt }}</div>
    </div>

    <table>
        <thead>
            <tr>
                <th>#</th>
                <th>Operator</th>
                <th>Category</th>
                <th>Email</th>
                <th>Contact</th>
            </tr>
        </thead>
        <tbody>
            @if ($operators->isNotEmpty())
                @foreach ($operators as $index => $operator)
                    <tr>
                        <td>{{ $index + 1 }}</td>
                        <td>{{ $operator->name }}</td>
                        <td>{{ $operator->category }}</td>
                        <td>{{ $operator->email }}</td>
                        <td>{{ $operator->contact_number }}</td>
                    </tr>
                @endforeach
            @else
                <tr>
                    <td colspan="5" style="text-align: center;">No Operator is available.</td>
                </tr>
            @endif
        </tbody>
    </table>
</body>

</html>
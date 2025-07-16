<!DOCTYPE html>
<html>
<head>
    <title>Application Submission</title>
    <style>
        body { font-family: sans-serif; font-size: 12px; }
        table { width: 100%; border-collapse: collapse; margin-bottom: 20px; }
        th, td { border: 1px solid #ccc; padding: 6px; }
        h2, h3 { margin-top: 30px; }
        th { background-color: #f2f2f2; }
        .header, .footer { text-align: center; }
        .header { font-size: 24px; margin-bottom: 20px; }
    </style>
</head>
<body>
    <div class="header">
        <div>
            <img src="../public/assets/caa-logo.png" alt="Logo" style="height: 100px" >
            <h4>CIVIL AVIATION AUTHORITY</h4>
        </div>
      <hr>
    <h4> APPLICATION SUBMISSION</h4>
    <h6 style="margin-top: 2px;"><strong>{{ $application->application_code ?? 'N/A' }}</strong> </h6>
    </div>
    <p><strong>Full Name:</strong> {{ $application->user->name ?? 'N/A' }}</p>
    <p><strong>Email ID:</strong> {{ $application->user->email ?? 'N/A' }}</p>
    <p><strong>Application Type:</strong> {{ $application->application_type->name ?? 'N/A' }}</p>
    <p><strong>Action Type:</strong> {{ $application->actionType }}</p>

    <h3>License Particulars</h3>
    <table>
        <thead>
            <tr>
                <th>License Number</th>
                <th>Place of Issue</th>
                <th>Date of Issue</th>
                <th>Type</th>
                <th>Expiry Date</th>
            </tr>
        </thead>
        <tbody>
            @if ($application->licenseParticulars->isNotEmpty())
                @foreach ($application->licenseParticulars as $license)
                    <tr>
                        <td>{{ $license->licenseNumber }}</td>
                        <td>{{ $license->placeOfIssue }}</td>
                        <td>{{ $license->dateOfIssue }}</td>
                        <td>{{ $license->typeOfLicense }}</td>
                        <td>{{ $license->expiryDate }}</td>
                    </tr>
                @endforeach
            @else
                <tr>
                    <td colspan="5">No license particulars available.</td>
                </tr>
            @endif
        </tbody>
    </table>

    <h3>License Categories</h3>
    <table>
        <thead>
            <tr>
                <th>Category</th>
                <th>License Class</th>
                <th>Aircraft Types</th>
            </tr>
        </thead>
        <tbody>
            @if ($application->licenseCategories->isNotEmpty())
                @foreach ($application->licenseCategories as $category)
                    <tr>
                        <td>{{ $category->category }}</td>
                        <td>{{ $category->licenseClass }}</td>
                        <td>{{ $category->aircraftTypes }}</td>
                    </tr>
                @endforeach
            @else
                <tr>
                    <td colspan="3">No license categories available.</td>
                </tr>
            @endif
        </tbody>
    </table>

    <h3>Single Engine Aircrafts</h3>
    <table>
        <thead>
            <tr>
                <th>Day Dual</th>
                <th>Day Pilot</th>
                <th>Night Dual</th>
                <th>Night Pilot</th>
                <th>FSTD</th>
            </tr>
        </thead>
        <tbody>
            @forelse ($application->singleEngineAircrafts ?? [] as $single)
                <tr>
                    <td>{{ $single->dayDual }}</td>
                    <td>{{ $single->dayPilot }}</td>
                    <td>{{ $single->nightDual }}</td>
                    <td>{{ $single->nightPilot }}</td>
                    <td>{{ $single->fstd }}</td>
                </tr>
            @empty
                <tr>
                    <td colspan="5">No single engine aircraft data available.</td>
                </tr>
            @endforelse
        </tbody>
    </table>

    <h3>Multi Engine Aircrafts</h3>
    <table>
        <thead>
            <tr>
                <th>Day First Pilot</th>
                <th>Day Second Pilot</th>
                <th>Night First Pilot</th>
                <th>Night Second Pilot</th>
                <th>Night Dual</th>
            </tr>
        </thead>
        <tbody>
            @forelse ($application->multiEngineAircrafts ?? [] as $multi)
                <tr>
                    <td>{{ $multi->dayFirstPilot }}</td>
                    <td>{{ $multi->daySecondPilot }}</td>
                    <td>{{ $multi->nightFirstPilot }}</td>
                    <td>{{ $multi->nightSecondPilot }}</td>
                    <td>{{ $multi->nightDual }}</td>
                </tr>
            @empty
                <tr>
                    <td colspan="5">No multi-engine aircraft data available.</td>
                </tr>
            @endforelse
        </tbody>
    </table>

    <h3>Type Ratings</h3>
    @if ($application->typeRatings && $application->typeRatings->isEmpty())
        <p>No type ratings submitted.</p>
    @else
        <table>
            <thead>
                <tr>
                    <th>Type</th>
                    <th>Rating</th>
                </tr>
            </thead>
            <tbody>
                @forelse ($application->typeRatings ?? [] as $rating)
                    <tr>
                        <td>{{ $rating->type ?? 'N/A' }}</td>
                        <td>{{ $rating->rating ?? 'N/A' }}</td>
                    </tr>
                @empty
                    <tr>
                        <td colspan="2">No type ratings available.</td>
                    </tr>
                @endforelse
            </tbody>
        </table>
    @endif

</body>
</html>

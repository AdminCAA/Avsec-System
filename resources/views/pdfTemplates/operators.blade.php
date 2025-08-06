<!DOCTYPE html>
<html>
<head>
    <title>Operators List</title>
    <style>
         body { font-family: sans-serif; font-size: 12px; }
       /* table { width: 100%; border-collapse: collapse; margin-bottom: 20px; } */
       table {
          width: 100%;
          border-collapse: collapse; /* Important to remove spacing between borders */
        }
        th, td { border: 1px solid #000; padding: 6px; margin:0 }
        h2, h3 { margin-top: 15px; }
        th { background-color: #a8a8a8; }
        .header, .footer { text-align: center; }
        /* .header { font-size: 24px; margin-bottom: 20px; } */
    </style>
    <script setup>
        const logoImage = '/assets/caa-logo.png';
    </script>
</head>
<body>
    <div class="header">
        <div>
            <img src="../public/assets/caa-logo.png" alt="Logo" style="height: 100px" >
            <h4>CIVIL AVIATION AUTHORITY</h4>
        </div>
      <hr>
    <h4> AVSEC OPERATORS LIST</h4>    
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
                    <td colspan="5">No Operator is available.</td>
                </tr>
            @endif
        </tbody>
    </table>

    {{-- <h3>License Categories</h3>
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
    </table> --}}

    {{-- <h3>Single Engine Aircrafts</h3>
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
    </table> --}}

    {{-- <h3>Multi Engine Aircrafts</h3>
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
    </table> --}}
{{-- 
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
    @endif --}}

</body>
</html>

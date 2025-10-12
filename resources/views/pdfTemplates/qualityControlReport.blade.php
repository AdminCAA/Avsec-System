<!DOCTYPE html>
<html>
<head>
    <title>Quality Control Report</title>    
  <style>
    body {
        font-family: 'Poppins', 'Segoe UI', sans-serif;
        font-size: 14px;
        line-height: 1.6;
        color: #000;
        margin: 40px;
    }

    p {
        text-align: justify;
        margin-bottom: 15px;
    }

    h2, h3, h4 {
        text-align: center;
        margin-top: 25px;
        margin-bottom: 15px;
        font-weight: 600;
        letter-spacing: 0.5px;
    }

    ul {
        margin: 10px 0 15px 40px;
    }

    li {
        margin-bottom: 5px;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
        margin-bottom: 25px;
        page-break-inside: avoid;
    }

    th, td {
        border: 1px solid #000;
        padding: 8px 10px;
        vertical-align: top;
        font-size: 13px;
    }

    th {
        background-color: #a8a8a8;
        font-weight: bold;
        text-align: center;
    }

    /* ↓↓↓ Updated header spacing ↓↓↓ */
    .header {
        text-align: center;
        margin-bottom: 10px;
    }

    .header h4 {
        margin: 3px 0;
        font-weight: 600;
        line-height: 1.3;
    }

    .footer {
        text-align: center;
        font-size: 12px;
        margin-top: 30px;
        color: #555;
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
        text-align: center;
    }

    .section-title {
        font-size: 16px;
        font-weight: 600;
        text-decoration: underline;
        margin-top: 30px;
        margin-bottom: 10px;
    }

    .questions-container {
        display: flex;
        flex-direction: column;
        gap: 20px;
    }
</style>

</head>
<body>

    <!-- Cover Page -->
    <div class="cover-page">
        <img src="{{ public_path('assets/caa-logo.png') }}" alt="CAA Logo">
        <h1>CIVIL AVIATION AUTHORITY</h1>
        <h2>QUALITY CONTROL REPORT</h2>
        <p class="cover-date">Generated on: {{ \Carbon\Carbon::now()->format('d-m-Y H:i') }}</p>
    </div>

    <!-- Header -->
    <div class="header">
        <h4>NATIONAL CIVIL AVIATION SECURITY QUALITY CONTROL PROGRAMME</h4>   
        <h4>CONFIDENTIAL REPORT ON THE SECURITY OVERSIGHT OF {{ $operator->name }}</h4>
        <h4>FOR THE PERIOD {{ \Carbon\Carbon::parse($qualityControl->scheduled_date)->format('d/m/Y') }} 
            TO {{ \Carbon\Carbon::parse($qualityControl->end_date)->format('d/m/Y') }}
        </h4>
    </div>

    <!-- Confidentiality Note -->
    <p>
        This document contains <strong>CONFIDENTIAL</strong> information pertaining to the aviation security status of 
        the <strong>{{ $operator->name }}</strong>. Distribution and dissemination of copies or contents are therefore 
        <strong>RESTRICTED</strong> to persons having an official requirement for access as determined by 
        {{ $operator->name }}.
    </p>

    <!-- Introduction -->
    <h4>INTRODUCTION</h4>
    <h4>PROGRAMME AND SECURITY OVERSIGHT OBJECTIVES</h4>

    <p>
        The overall objective of the National Civil Aviation Security Quality Control Programme (NCASQCP) is to promote 
        national aviation security through the security oversight of Operators on a regular basis to determine the status 
        of implementation of Civil Aviation Security Requirements. The primary objectives of the security oversight are to:
    </p>

    <ul>
        <li>Determine the degree of conformance of the Operators in implementing regulatory requirements of the Civil Aviation Security Requirements.</li>
        <li>Determine the extent to which an Operator's implementation of its security system is sustainable through the establishment of company policies and internal quality control assurance and enforcement capabilities.</li>
        <li>Identify any deficiencies in the aviation security system, measures and procedures.</li>
        <li>Verify whether the findings of the previous audits have been adequately addressed as per the auditee’s Corrective Action Plan (CAP).</li>
    </ul>

    <h4>LIST OF ICAO DOCUMENTS RELATED TO THE AVIATION SECURITY OVERSIGHT</h4>
    <ul>
        <li><strong>Annex 17</strong> — Security — Safeguarding International Civil Aviation Against Acts of Unlawful Interference</li>
        <li><strong>Doc 9807</strong> — Security Audit Reference Manual (Restricted)</li>
        <li><strong>Doc 8973/8</strong> — Aviation Security Manual</li>
    </ul>

    <h4>LIST OF ZCAA DOCUMENTS RELATED TO THE AVIATION SECURITY OVERSIGHT</h4>
    <ul>
        <li><strong>NCASP</strong> — National Civil Aviation Security Programme</li>
        <li><strong>NCASTP</strong> — National Civil Aviation Security Training Programme</li>
        <li><strong>NCASQCP</strong> — National Civil Aviation Security Quality Control Programme</li>
        <li><strong>ZCARs</strong> — Zambia Civil Aviation Requirements Part 20</li>
        <li><strong>ASIM</strong> — Aviation Security Inspectors Manual</li>
    </ul>

    <div style="page-break-before: always;"></div>

    <!-- Section II -->
    <h4>SECTION II</h4>

    @php $groupIndex = 1; @endphp
    @foreach ($groupedAuditedArea as $auditArea => $questions)
        <h4>PART {{ $groupIndex++ }} - {{ $auditArea }}</h4>

        <div class="questions-container">
            <table>
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Question</th>
                        <th>Response</th>
                        <th>Finding / Observation</th>                            
                        <th>Recommendations</th>                           
                        <th>Status</th>
                        <th>Finding Category</th>
                        <th>Date</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach ($questions as $question)
                        <tr>
                            <td>{{ $loop->iteration }}</td>
                            <td>{{ $question->question ?? 'N/A' }}</td>
                            <td>{{ $question->question_response ?? 'N/A' }}</td>
                            <td>{{ $question->finding_observation ?? 'N/A' }}</td>                               
                            <td>{{ $question->recommendations ?? 'N/A' }}</td>                                
                            <td
                                @if ($question->status === 'Open')
                                    style="background-color: #f8d7da; color: #721c24;"  
                                @elseif ($question->status === 'Closed')
                                    style="background-color: #d4edda; color: #155724;"  
                                @else
                                    style="background-color: #fff3cd; color: #856404;"  
                                @endif
                            >
                                {{ $question->status ?? 'N/A' }}
                            </td>
                            <td
                                @if ($question->finding_category === 'Compliant')
                                    style="background-color: #d4edda; color: #155724;"  
                                @elseif ($question->finding_category === 'Not Compliant(Minor)')
                                    style="background-color: #fff3cd; color: #856404;" 
                                @elseif ($question->finding_category === 'Not Compliant(Serious)')
                                    style="background-color: #f8d7da; color: #721c24;"  
                                @endif
                            >
                                @if ($question->finding_category === 'Compliant')
                                    1
                                @elseif ($question->finding_category === 'Not Compliant(Minor)')
                                    2
                                @elseif ($question->finding_category === 'Not Compliant(Serious)')
                                    3
                                @else
                                    N/A
                                @endif
                            </td>
                            <td>
                                {{ $question->date_quality_control 
                                    ? \Carbon\Carbon::parse($question->date_quality_control)->format('d/m/Y') 
                                    : 'N/A' 
                                }}
                            </td>
                        </tr>
                    @endforeach
                </tbody>
            </table>
        </div>     
        <div style="page-break-before: always;"></div>       
    @endforeach

    <!-- Section III -->
    <h4>SECTION III</h4>                 
    <h4>RESPONSIBLE ZCAA INSPECTORS</h4>

    <table>
        <thead>
            <tr>
                <th>#</th>
                <th>CAA Inspector</th>
                <th>Signature</th>
                <th>Date</th>
            </tr>
        </thead>
        <tbody>
            @foreach ($qualityControl->users as $index => $user)  
                <tr>
                    <td>{{ $loop->iteration }}</td>
                    <td>{{ $user->name }}</td>
                    <td></td>
                    <td>{{ \Carbon\Carbon::today()->format('d/m/Y') }}</td>
                </tr>
            @endforeach
        </tbody>
    </table>  

    <div class="footer">
        <p>End of Report</p>
    </div>
</body>
</html>





{{-- <!DOCTYPE html>
<html>
<head>
    <title>Quality Control Report</title>    
    <style>
        body {
          font-family: 'Poppins', 'Segoe UI', sans-serif;
          font-size: 14px;
        }
        
        table {
          width: 100%;
          border-collapse: collapse;
        }
        
        th, td {
          border: 1px solid #000;
          padding: 6px;  
          margin: 0; 
        }
        
        h2, h3 {
          margin-top: 15px;
        }
        
        th {
          background-color: #a8a8a8;
        }        
        .header, .footer {
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

        </style>
        
</head>
<body>

    <!-- Cover Page -->
    <div class="cover-page">
        <img src="{{ public_path('assets/caa-logo.png') }}" alt="CAA Logo">
        <h1>CIVIL AVIATION AUTHORITY</h1>
        <h2>AVSEC QUALITY CONTROL REPORT</h2>
        <p class="cover-date">Generated on: {{ \Carbon\Carbon::now()->format('d-m-Y H:i') }}</p>
    </div>

    <div class="header">

        <h4> NATIONAL CIVIL AVIATION SECURITY QUALITY CONTROL PROGRAMME</h4>   
        <h4> CONFIDENTIAL REPORT ON THE SECURITY OVERSIGHT OF {{ $operator->name}}</h4>
        <h4> FOR THE PERIOD {{ \Carbon\Carbon::parse($qualityControl->scheduled_date)->format('d/m/Y') }} TO {{\Carbon\Carbon::parse($qualityControl->end_date)->format('d/m/Y')}}</h4>
    
    </div>

    <p>This document contains CONFIDENTIAL information pertaining to the aviation security status of the {{ $operator->name }}. Distribution and dissemination of copies or contents are therefore RESTRICTED to persons having an official requirement for access as determined by {{ $operator->name }}.</p>
    
        <h4  style="text-align: center">INTRODUCTION</h4>
        <h4  style="text-align: center">PROGRAMME AND SECURITY OVERSIGHT OBJECTIVES</h4>
        <p style="text-align: justify">The overall objective of the National Civil Aviation Security Quality Control Programme (NCASQCP) is to promote national aviation security through the security oversight of Operators on a regular basis to determine the status of implementation of Civil Aviation Security Requirements. The primary objectives of the security oversight are to:
            <ul>
                <li>determine the degree of conformance of the Operators in implementing regulatory requirements of the Civil Aviation Security Requirements;</li>
                <li>determine the extent to which an Operator's implementation of its security system is sustainable through the establishment of company policies and internal quality control assurance and enforcement capabilities;</li>
                <li>identify any deficiencies in the aviation security system, measures and procedures; and</li>
                <li>verify whether the findings of the previous audits have been adequately addressed as per the auditee’s Corrective Action Plan (CAP).</li>   
            </ul>
        </p>

        <h4>LIST OF ICAO DOCUMENTS RELATED TO THE AVIATION SECURITY OVERSIGHT</h4>
        <ul>
            <li>Annex 17		— Security — Safeguarding International Civil Aviation Against Acts of   
                Unlawful Interference
            </li>
            <li>Doc 9807		— Security Audit Reference Manual (Restricted)</li>
            <li>Doc 8973/8	— Aviation Security Manual</li>

        </ul>
       
    
        <h4>LIST OF ZCAA DOCUMENTS RELATED TO THE AVIATION SECURITY OVERSIGHT</h4>
        <ul>
            <li>NCASP 	-  National Civil Aviation Security Programme</li>
            <li>NCASTP 	- National Civil Aviation Security Training Programme</li>
            <li>NCASQCP	- National Civil Aviation Security Quality Control Programme</li>
            <li>ZCARs 	- Zambia Civil Aviation Requirements Part 20</li>
            <li>ASIM 	- Aviation Security Inspectors Manual</li>
        </ul>

        <div style="page-break-before: always;"></div>
        <h4 style="text-align: center">SECTION II</h4>
        @php $groupIndex = 1; @endphp
        @foreach ($groupedAuditedArea as $auditArea => $questions)
        
            <h4 style="text-align: center">PART {{ $groupIndex++ }}  -  {{ $auditArea }}</h4>
            <div class="questions-container" style="display: flex; flex-direction: column; gap: 20px;">
                @php $index = 1; @endphp

                <table class="table table-bordered table-striped">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Question</th>
                            <th>Response</th>
                            <th>Finding/Observation</th>                            
                            <th>Recommendations</th>                           
                            <th>Status</th>
                            <th>Finding Category</th>
                            <th>Date</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach ($questions as $question)
                            <tr>
                                <td>{{ $loop->iteration }}</td>
                                <td>{{ $question->question ?? 'N/A' }}</td>
                                <td>{{ $question->question_response ?? 'N/A' }}</td>
                                <td>{{ $question->finding_observation ?? 'N/A' }}</td>                               
                                <td>{{ $question->recommendations ?? 'N/A' }}</td>                                
                                <td
                                    @if ($question->status === 'Open')
                                        style="background-color: #f8d7da; color: #721c24;"  
                                    @elseif ($question->status === 'Closed')
                                        style="background-color: #d4edda; color: #155724;"  
                                    @else
                                        style="background-color: #fff3cd; color: #856404;"  
                                    @endif
                                >
                                    @if ($question->status === 'Open')
                                        Open
                                    @elseif ($question->status === 'Closed')
                                        Closed
                                    @else
                                        N/A
                                    @endif
                                </td>
                                <td
                                @if ($question->finding_category === 'Compliant')
                                    style="background-color: #d4edda; color: #155724;"  
                                @elseif ($question->finding_category === 'Not Compliant(Minor)')
                                    style="background-color: #fff3cd; color: #856404;" 
                                @elseif ($question->finding_category === 'Not Compliant(Serious)')
                                    style="background-color: #f8d7da; color: #721c24;"  
                                @endif
                            >
                                @if ($question->finding_category === 'Compliant')
                                    1
                                @elseif ($question->finding_category === 'Not Compliant(Minor)')
                                    2
                                @elseif ($question->finding_category === 'Not Compliant(Serious)')
                                    3
                                @else
                                    N/A
                                @endif
                            </td>
                                <td>
                                    {{ $question->date_quality_control 
                                        ? \Carbon\Carbon::parse($question->date_quality_control)->format('d/m/Y') 
                                        : 'N/A' 
                                    }}
                                </td>
                            </tr>
                        @endforeach
                    </tbody>
                </table>                                                             
            </div>     
            <div style="page-break-before: always;"></div>       
        @endforeach
        <h4 style="text-align: center">SECTION III</h4>                 
        <h4>RESPONSIBLE ZCAA INSPECTORS</h4>
        <table class="table table-bordered table-striped">
            <thead>
                <tr>
                    <th>#</th>
                    <th>CAA Inspector</th>
                    <th>Signature</th>
                    <th>Date</th>
                    
                </tr>
            </thead>
            <tbody>
                @foreach ($qualityControl->users as $index => $user)  
                    <tr>
                        <td>{{ $loop->iteration }}</td>
                        <td class="text-center fw-bold">
                            {{ $user->name }}
                        </td>
                        <td class="text-center fw-bold">
                            
                        </td>
                        <td class="text-center fw-bold">
                            <b>Date: {{ \Carbon\Carbon::today()->format('d/m/Y') }}</b>
                        </td>
                    </tr>
                @endforeach
            </tbody>
        </table>  
</body>
</html> --}}

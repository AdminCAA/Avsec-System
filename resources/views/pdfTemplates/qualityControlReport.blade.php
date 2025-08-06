<!DOCTYPE html>
<html>
<head>
    <title>Quality Control Report</title>    
    <style>
        body {
          font-family: sans-serif;
          font-size: 14px;
        }
        
        /* Ensure no gaps and margins between cells */
        table {
          width: 100%;
          border-collapse: collapse; /* Important to remove spacing between borders */
        }
        
        th, td {
          border: 1px solid #000;
          padding: 6px;   /* Change to 0 if you want no space inside cells */
          margin: 0;      /* Removes any outer margin (though rarely applied to td) */
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
            <li>NCASTP 	– National Civil Aviation Security Training Programme</li>
            <li>NCASQCP	– National Civil Aviation Security Quality Control Programme</li>
            <li>ZCARs 	– Zambia Civil Aviation Requirements Part 20</li>
            <li>ASIM 	– Aviation Security Inspector’s Manual</li>
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
                                        style="background-color: #f8d7da; color: #721c24;"  {{-- Red --}}
                                    @elseif ($question->status === 'Closed')
                                        style="background-color: #d4edda; color: #155724;"  {{-- Green --}}
                                    @else
                                        style="background-color: #fff3cd; color: #856404;"  {{-- Yellow --}}
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
                                    style="background-color: #d4edda; color: #155724;"  {{-- Green --}}
                                @elseif ($question->finding_category === 'Not Compliant(Minor)')
                                    style="background-color: #fff3cd; color: #856404;"  {{-- Yellow --}}
                                @elseif ($question->finding_category === 'Not Compliant(Serious)')
                                    style="background-color: #f8d7da; color: #721c24;"  {{-- Red --}}
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
</html>

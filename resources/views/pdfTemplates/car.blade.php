<!DOCTYPE html>
<html>
<head>
    <title>Corrective Action Request</title>   
    <style>
        body {
          /* font-family: sans-serif; */
          font-family: 'Poppins', 'Segoe UI', sans-serif;
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
    <h4> CORRECTIVE ACTION REQUEST(CAR)</h4>   
    <table>
        <tbody>
           <!-- Title row with 3 separate cells -->
            <tr>
                <td style="width: 50%" class="text-center fw-bold"><h4>CORRECTIVE ACTION REQUEST (CAR) </h4></td>
                <td class="text-center fw-bold"><b>1</b></td>
                <td class="text-center fw-bold"><b>File Reference: </b></td>
            </tr>
            <tr>
                <td class="text-center fw-bold" colspan="3">
                    <b>Name of Operator : </b> {{ $operator->name ?? 'N/A' }} <br>
                    <b>Name of Unit:</b> Aviation Security
                </td>
            </tr>
            <tr>
                <td class="text-center fw-bold" colspan="3"><b>Question: </b> {{ $question->question ?? 'N/A' }}</td>
            </tr>
            <tr>
                <td class="text-center fw-bold" colspan="3"><b>Area Audited :</b> {{ $question->audit_area_name ?? 'N/A' }} </td>
            </tr>

            <tr>
                <td class="text-center fw-bold" colspan="3">
                <b>Date of Audit : </b>
                {{ \Carbon\Carbon::parse($question->date_quality_control)->format('d/m/Y') ?? 'N/A' }}</td>
            </tr>
            <tr>
                <td class="text-center fw-bold" colspan="3">
                    <b>Description of Finding(s): </b></br>
                    {{ $question->finding_observation ?? 'N/A' }} </td>
            </tr>

            
            <tr>
                <td class="text-center fw-bold" colspan="3">
                    <b>Corrective Action Recommendation(s): </b></br>
                    {{ $question->recommendations ?? 'N/A' }}</td>
            </tr>

            <tr>
                <td class="text-center fw-bold" colspan="3">
                    <b>Corrective Action Plan to be submitted within 30 days of the date of this CAR</b>
                </td>           
            </tr>
            @foreach ($users as $index => $user)  
                <tr>
                    <td class="text-center fw-bold"><b>Name of ZCAA Inspector:</b> {{ $user->name }} </td>
                    <td class="text-center fw-bold"><b>Signature: </b></td>
                    <td class="text-center fw-bold"><b>Date : {{ \Carbon\Carbon::today()->format('d/m/Y') }}</b></td>
                </tr>
            @endforeach
        </tbody>
      </table>
</body>
</html>

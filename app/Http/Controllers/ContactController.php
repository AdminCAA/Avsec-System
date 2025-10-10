<?php

namespace App\Http\Controllers;

use App\Models\Contact;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class ContactController extends Controller
{
   
    public function store(Request $request)
    {
       // dd($request->all());
        // Validation rules
        $validator = Validator::make($request->all(), [
            'first_name' => 'required|string|max:255',
            'last_name'  => 'required|string|max:255',
            'email'      => 'required|email|max:255',
            'subject'    => 'required|string|max:255',
            'message'    => 'required|string',
        ]);

        // If validation fails
        if ($validator->fails()) {
            return response()->json([
                'errors' => $validator->errors()
            ], 422);
        }

        // Save to database
        $contact = Contact::create([
            'first_name' => $request->first_name,
            'last_name'  => $request->last_name,
            'email'      => $request->email,
            'subject'    => $request->subject,
            'message'    => $request->message,
        ]);

        return response()->json([
            'message' => 'Contact message sent successfully!',
            'data' => $contact
        ], 201);
    }


    // Fetch all contact messages
    public function fetchAllContacts()
    {
        $contacts = Contact::orderBy('created_at', 'desc')->get();

        return response()->json([
            'data' => $contacts
        ], 200);
    }

}

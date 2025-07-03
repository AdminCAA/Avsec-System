<?php

namespace App\Models;

// use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Spatie\Permission\Traits\HasRoles;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Http\Request;
class User extends Authenticatable
{
    /** @use HasFactory<\Database\Factories\UserFactory> */
    use HasFactory, Notifiable, HasRoles;

    /**
     * The attributes that are mass assignable.
     *
     * @var list<string>
     */
    protected $fillable = [
        'name',
        'gender',
        'email',
        'password',
        'facility_id',
        'facility_name',
        'nrc',
        'user_type',
        'is_certified',
        'phone_number',
        'portrait',
        'signature',      
    ];


    public const UserTypes = [
        'Screener',
        'Supervisor',
        'Trainer',
        'Inspector',        
    ];

    public const UserStatuses = [
        'Certified',
        'Not Certified',        
        'Suspended'        
    ];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var list<string>
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * Get the attributes that should be cast.
     *
     * @return array<string, string>
     */
    protected function casts(): array
    {
        return [
            'email_verified_at' => 'datetime',
            'password' => 'hashed',
        ];
    }

    public function scopeSearch(Builder $query , Request $request){       
        return $query->where(function($query) use ($request){
            return $query->when($request->search,function($query) use ($request){ 
                return $query->where(function ($query) use ($request){
                    $query->where('name','like','%'.$request->search.'%')
                    ->orWhere('email','like','%'.$request->search.'%');                    
                });
            });
        });
    }

    public function facility()
    {
        return $this->belongsTo(Facility::class);
    }

    public function qualifications()
    {
        return $this->hasMany(Qualification::class);
    }

    public function certifications()
    {
        return $this->hasMany(Certification::class);
    }

    public function trainings()
    {
        return $this->belongsToMany(Training::class)
                    ->withPivot('date_taken', 'score', 'type')
                    ->withTimestamps();
    }
   
}

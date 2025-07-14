<?php

namespace App\Console\Commands;

use App\Models\QualityControl;
use Carbon\Carbon;
use Illuminate\Console\Command;

class CheckQualityControlStatus extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'app:check-quality-control-status';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'The command checks the status of quality control alerts and updates their status if necessary.';

    /**
     * Execute the console command.
     */
    public function handle()
    {
        //
        // $qualityControls = QualityControl::where('status', '!=', 'Resolved')
        //     ->where('next_check_date', '<=', now())
        //     ->get();
        
        $qualityControls = QualityControl::with('selectedchecklistQuestions')->get();
        if ($qualityControls->isEmpty()) {
            $this->info('No quality control alerts found.');
            return;
        }        
        foreach ($qualityControls as $qualityControl) {            
            if($qualityControl->status !== 'Completed'  && Carbon::parse($qualityControl->scheduled_date)->isPast()) {
                foreach($qualityControl->selectedchecklistQuestions as $selectedQuestion){
                    $completionDate = $selectedQuestion->completion_date ? Carbon::parse($selectedQuestion->completion_date): null;                     
                    $daysRemaining = $completionDate? (int)now()->diffInDays($completionDate): null;                    
                    $this->line(" QUESTION: " . $selectedQuestion->question);
                    $this->line("   RESPONSE: " . $selectedQuestion->question_response);
                    $this->line("   STATUS: " . $selectedQuestion->status);   
                    $this->line("   COMPLETION DATE: " . $completionDate );             
                    $this->line("   REMAINING DATE: " . $daysRemaining . " days ago");  

                    if($selectedQuestion->status !== 'Closed' && 
                    ($selectedQuestion->finding_category =='Not Compliant(Minor)' || 
                    $selectedQuestion->finding_category =='Not Compliant(Serious)')) 
                    {
                        if($daysRemaining <= 7 && $daysRemaining >= 0)
                        {                                
                            //Send a notification email                                                
                            $this->line("SEND EMAIL OF NOTIFICATION FOR QUALITY CONTROL QUESTION : ID {$selectedQuestion->id}");                    
                        }                              
                        if($daysRemaining < 0 )
                        {
                            
                            $qualityControl->status = 'Overdue';
                            $qualityControl->save();  
                            //Update the status of the selected question
                            $selectedQuestion->status = 'Open';
                            $selectedQuestion->modified_at = now();
                            $selectedQuestion->save();
                            $this->info("QUALITY CONTROL ID: {$qualityControl->id}. UPDATED");
                            $this->info("QUALITY QUESTION ID: {$selectedQuestion->id}. UPDATED");
                        }                                                                             
                    }                    
                } 

            } else {
                //$this->info("Quality Control ID {$qualityControl->id} is not overdue.");
                $this->info("Quality Control ID: {$qualityControl->id}.");
                $this->info("Quality Control STATUS: {$qualityControl->status}.");
            }

            //if($qualityControl->status == )

        }
    }
}

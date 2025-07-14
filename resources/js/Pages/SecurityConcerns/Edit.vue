<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import { Head,Link, useForm } from '@inertiajs/vue3';
import { ref,onMounted} from 'vue';
import Swal from 'sweetalert2';
import 'sweetalert2/dist/sweetalert2.min.css';
import 'vue-select/dist/vue-select.css'
import {router} from '@inertiajs/vue3';

const {qualityControl, question,facility } = defineProps({ 
    qualityControl:{
        type: Object,
        required: true
    },  
    question:{
      type:Object,
      required: true
    },
    facility: {
      type: Object,
      required: true
    },
});

const responseOptions = [
  {id : 1, option  : 'Yes'},
  {id : 2, option  : 'No'},
  {id:3, option:'Pass'},
  {id:4, option:'Fail'},
  {id : 5, option  : 'Not Applicable'},
  {id : 6, option  : 'Not Comfirmed'},
]

const findingCategoryOptions = [
  {id : 1, option  : 'Compliant'},
  {id : 2, option  : 'Not Compliant(Minor)'},
  {id : 3, option  : 'Not Compliant(Serious)'},
  {id : 4, option  : 'Not Applicable'},
  {id : 5, option  : 'Not Confirmed'},
]

const statusOptions = [
  {id : 1, option  : 'Open'},
  {id : 2, option  : 'Closed'},  
]

const form = useForm({
    question_id: question.id || '',
    quality_control_id: qualityControl.id || '',
    question_response: question.question_response || '',
    finding_observation: question.finding_observation || '',
    action_taken: question.action_taken || '',
    status: question.status || '',
    finding_category: question.finding_category || '',
    date_quality_control: question.date_quality_control || '',
    problem_cause: question.problem_cause || '',
    proposed_follow_up_action: question.proposed_follow_up_action || '',
    short_term_action: question.short_term_action || '',
    long_term_action: question.long_term_action || '',
    completion_date: question.completion_date || '',
    date_of_closure: question.date_of_closure || '',
    follow_up_date: question.follow_up_date || '',    
    evidence_file: null, // For file upload    
});

const isLoading = ref(false);
const formErrors = ref({});




// Realtime validation examples
function validateQuestionForm() {  
    const errors = {};
    if (!form.question_response) errors.question_response = 'Response is required';
    if (!form.finding_category) errors.finding_category = 'Finding category is required';
    if (!form.date_quality_control) errors.date_quality_control = 'Date of Quality Control is required';
    if (!form.problem_cause) errors.problem_cause = 'Problem cause is required';
    if (!form.status) errors.status = 'Status is required';
    if (!form.date_of_closure) errors.date_of_closure = 'Date of closure is required';
    if (!form.completion_date) errors.completion_date = 'Completion date is required';
    if (!form.follow_up_date) errors.follow_up_date = 'Follow-up date is required';
    //Check if the evidence file is more the 2Mb
    if (form.evidence_file && form.evidence_file.size > 2 * 1024 * 1024) {
        errors.evidence_file = 'File size must be less than 2MB';
    } 
    //Check if the evidence file is file type
    if (form.evidence_file && !['application/pdf', 'image/jpeg', 'image/png', 'image/jpg'].includes(form.evidence_file.type)) {
        errors.evidence_file = 'Only PDF, JPG, or PNG files are allowed.';
    } 

    formErrors.value = errors;
    return Object.keys(errors).length === 0;
}

function submitQuestionForm(){
    if(validateQuestionForm()){
        let formData = new FormData();
    isLoading.value = true;
    formData.append('question_id', form.question_id);
    formData.append('quality_control_id', form.quality_control_id);
    formData.append('question_response', form.question_response);
    formData.append('finding_observation', form.finding_observation);
    formData.append('action_taken', form.action_taken);
    formData.append('status', form.status);
    formData.append('finding_category', form.finding_category);
    formData.append('date_quality_control', form.date_quality_control);
    formData.append('problem_cause', form.problem_cause);
    formData.append('proposed_follow_up_action', form.proposed_follow_up_action);
    formData.append('short_term_action', form.short_term_action);
    formData.append('long_term_action', form.long_term_action);
    formData.append('completion_date', form.completion_date);
    formData.append('date_of_closure', form.date_of_closure);
    formData.append('follow_up_date', form.follow_up_date);
    if (form.evidence_file) {
        formData.append('evidence_file', form.evidence_file);
    }   

    axios.post(route('securityconcerns.update', question.id), formData)
    .then(() => {
      Swal.fire({
        icon: 'success',
        title: 'Quality Control Checklist updated successfully',
        toast: true,
        position: 'top-end',
        timer: 1500,
        showConfirmButton: false
      });
      setTimeout(() => {
        router.visit(route('securityconcerns.index'), {
          preserveScroll: true,
          preserveState: true,
          replace: true
        });
      }, 1500);
    })
    .catch(error => {
      if (error.response?.status === 422) {
        const errors = error.response.data.errors;
        formErrors.value = errors;
        const message = Object.values(errors).flat().join('\n');          
        Swal.fire({
          icon: 'error',
          title: 'Validation failed',
          text: message,
          toast: true,
          position: 'top-end',
          timer: 3000,
          showConfirmButton: false
        });
      }
    }).finally(() => {
      isLoading.value = false;
    });
    }else{
        Swal.fire({
            icon: 'error',
            title: 'Validation failed',
            text: formErrors.value ? Object.values(formErrors.value).flat().join('\n') : 'Please fill all required fields correctly.',
            toast: true,
            position: 'top-end',
            timer: 3000,
            showConfirmButton: false
        });
    }
    
};
const fileName = ref('');
const handleFileUpload = (event) => {
    const file = event.target.files[0];
    if (file) {
        form.evidence_file = file;
        fileName.value = file.name;
        // Optional: Basic file type validation
        const allowedTypes = ['application/pdf', 'image/jpeg', 'image/png', 'image/jpg'];
        if (!allowedTypes.includes(file.type)) {            
            formErrors.evidence_file = 'Only PDF, JPG, or PNG files are allowed.';
        } else {
            formErrors.evidence_file = '';
        }
    } else {
        fileName = '';
        form.evidence_file = null;
    }
};

</script>

<template>
  <Head title="Update Checklist Question"/>
  <AuthenticatedLayout>
    <div class="content-wrapper">    
      <div class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-12">
                    <h4><Link :href="route('facilities.show',qualityControl.facility.id)">{{ qualityControl.facility.name }} </Link> / <Link :href="route('quality-controls.edit',qualityControl.id)">{{ qualityControl.title }} - {{  qualityControl.control_type }} </Link></h4>                    
                </div>                
            </div>
        </div>
      </div>
    
      <div class="content">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h3 class="m-0">Update Quality Control Checklist</h3>
                </div>    
                <div class="col-sm-6">
                  <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item"><Link class="btn btn-info" :href="route('securityconcerns.index')"><i class="fas fa-arrow-left"></i> Back</Link></li>                                
                  </ol>
                </div><!-- /.col -->            
            </div>
          <div class="d-flex justify-content-center align-items-center min-vh-60  bg-light">
            <div class="row w-100 justify-content-center">
              <div class="col-md-12 mb-4">                    
                <!-- general form elements -->
                <div class="card card-info">                 
                    <div class="card-body">
                      <div class="row">
                        <div class="col-md-12"  >
                          <div class="col-md-12">
                            <div class="card card-info">
                                <div class="card-header">
                                    <h3 style="font-weight: bold;" class="card-title">{{question.question}}</h3>                                  
                                </div>                                                                                         
                                <form @submit.prevent="submitQuestionForm" enctype="multipart/form-data">
                                    <div class="col-md-12">                                    
                                        <div class="card-body">                                          
                                            <div class="row">
                                                <div class="form-group col-md-6">                                                
                                                <label>Response</label>
                                                <select 
                                                    required  v-model="form.question_response" 
                                                    class="form-control"                                                                        
                                                    :class="{ 
                                                    'is-invalid': formErrors.question_response, 
                                                    'is-valid': form.question_response && !formErrors.question_response 
                                                }">
                                                    <option value="">-- Select Question Response -- </option>
                                                    <option v-for="item in responseOptions" :key="item.id" :value="item.option">{{ item.option }}</option>
                                                </select>   
                                                <small v-if="formErrors.question_response" class="text-danger">{{ formErrors.question_response }}</small>                                                
                                                </div>

                                                <div class="form-group col-md-6">
                                                <label>Finding /Observation</label>
                                                <textarea 
                                                    v-model="form.finding_observation
                                                    "
                                                    class="form-control" rows="2" placeholder="Findings/Observation"                                                
                                                    :class="{ 
                                                        'is-invalid': formErrors.finding_observation, 
                                                        'is-valid': form.finding_observation && !formErrors.finding_observation 
                                                    }"
                                                    >
                                                </textarea>
                                                <small v-if="formErrors.finding_observation" class="text-danger">{{ formErrors.finding_observation }}</small>
                                                </div>                                                    
                                            </div>

                                            <div class="row">
                                                <div class="form-group col-md-6">                                                  
                                                    <label>Finding Category</label>
                                                    <select required v-model="form.finding_category" 
                                                    class="form-control"                                                  
                                                    :class="{ 
                                                            'is-invalid': formErrors.finding_category, 
                                                            'is-valid': form.finding_category && !formErrors.finding_category 
                                                        }"                                                    
                                                    >
                                                        <option value="">-- Select Finding Category --</option>
                                                        <option v-for="item in findingCategoryOptions" :key="item.id" :value="item.option">{{ item.option }}</option>
                                                    </select> 
                                                    <small v-if="formErrors.finding_category" class="text-danger">{{ formErrors.finding_category }}</small>                                                     
                                                </div>

                                                <div class="form-group col-md-6">
                                                    <label>Date of Quality Control</label>
                                                    <input 
                                                    required 
                                                    v-model="form.date_quality_control"                                         
                                                    type="date"
                                                    class="form-control"                                                 
                                                    :class="{ 
                                                            'is-invalid': formErrors.date_quality_control, 
                                                            'is-valid': form.date_quality_control && !formErrors.date_quality_control 
                                                        }"                                                     
                                                    placeholder="Date of Quality Control"
                                                    />
                                                    <small v-if="formErrors.date_quality_control" class="text-danger">{{ formErrors.date_quality_control }}</small>                                                                                               
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="form-group col-md-6">
                                                    <label>Action Taken By Operator</label>
                                                    <textarea v-model="form.action_taken
                                                    "class="form-control" rows="2" placeholder="Action Taken">
                                                    </textarea>                                                                                            
                                                </div>

                                                <div class="form-group col-md-6">
                                                    <label>Root Cause of Problem</label>
                                                    <textarea required v-model="form.problem_cause"
                                                        class="form-control" rows="2" placeholder="Cause of Problem"                                                                                   
                                                        :class="{ 
                                                                    'is-invalid': formErrors.problem_cause, 
                                                                    'is-valid': form.problem_cause && !formErrors.problem_cause 
                                                        }" 
                                                        >
                                                    </textarea>
                                                    <small v-if="formErrors.problem_cause" class="text-danger">{{ formErrors.problem_cause }}</small>                                                     
                                                </div>
                                            </div> 

                                            <div class="row">
                                                <div class="form-group col-md-6">
                                                    <label>Short term CAP</label>
                                                    <textarea v-model="form.short_term_action"
                                                    class="form-control" rows="2" placeholder="Short term CAP">
                                                    </textarea>
                                                </div>

                                                <div class="form-group col-md-6">
                                                    <label>Long term CAP</label>
                                                    <textarea v-model="form.long_term_action" class="form-control" rows="2" placeholder="Long term CAP">
                                                    </textarea>
                                                </div>
                                            </div> 

                                            <div class="row">
                                                <div class="form-group col-md-6">
                                                    <label>Proposed Completion Date</label>
                                                    <input required                                              
                                                        v-model="form.completion_date"                                         
                                                        type="date"
                                                        class="form-control"                                                      
                                                        placeholder="Proposed Completion Date"
                                                        :class="{ 
                                                            'is-invalid': formErrors.completion_date, 
                                                            'is-valid': form.completion_date && !formErrors.completion_date 
                                                        }" 
                                                    /> 
                                                    
                                                    <small v-if="formErrors.completion_date" class="text-danger">{{ formErrors.completion_date }}</small>                                                                                                      
                                                </div>
                                                <div class="form-group col-md-6">
                                                    <label>Follow-up Date</label>
                                                    <input                                                     
                                                        v-model="form.follow_up_date"                                         
                                                        type="date"
                                                        class="form-control"                                                    
                                                        :class="{ 
                                                            'is-invalid': formErrors.follow_up_date, 
                                                            'is-valid': form.follow_up_date && !formErrors.follow_up_date 
                                                        }"                                                  
                                                        placeholder="Follow-up Date"
                                                    />  
                                                    <small v-if="formErrors.follow_up_date" class="text-danger">{{ formErrors.follow_up_date }}</small>
                                                
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="form-group col-md-6">
                                                    <label>Proposed Follow up Action</label>
                                                    <textarea v-model="form.proposed_follow_up_action"
                                                        class="form-control"
                                                        
                                                        rows="2" placeholder="Proposed Follow up Action">
                                                    </textarea>
                                                </div><div class="form-group col-md-6">
                                                    <label>Date of Closure</label>
                                                    <input required                                                      
                                                        v-model="form.date_of_closure"                                         
                                                        type="date"
                                                        class="form-control"                                                      
                                                        :class="{ 
                                                            'is-invalid': formErrors.date_of_closure, 
                                                            'is-valid': form.date_of_closure && !formErrors.date_of_closure 
                                                        }"
                                                                                                
                                                        placeholder="Date of Closure"
                                                    /> 
                                                    <small v-if="formErrors.date_of_closure" class="text-danger">{{ formErrors.date_of_closure }}</small>
                                                
                                                </div>
                                            </div>

                                            <div class="row">                                                                                                                                              
                                                <div class="form-group col-md-6">                                    
                                                    <label v-if="!question.evidence_file">Evidence Attachment</label>  
                                                    <a v-if="question.evidence_file"
                                                       
                                                        data-bs-toggle="tooltip"
                                                        title="View Evidence Attachment"
                                                        :href="`/storage/${question.evidence_file}`" 
                                                        target="_blank"
                                                    >
                                                        <i class="fas fa-paperclip"></i><span><label>Evidence Attachment</label> </span>
                                                    </a>                                      
                                                    <div class="input-group">
                                                        <div class="custom-file">
                                                            <input 
                                                                type="file"                                                     
                                                                accept="image/*,application/pdf"   
                                                                @change="handleFileUpload"
                                                                class="custom-file-input" 
                                                                id="exampleInputFile"
                                                                :class="{ 'is-invalid': formErrors.evidence_file, 'is-valid': form.evidence_file && !formErrors.evidence_file }"
                                                            >
                                                            <label class="custom-file-label" for="exampleInputFile">
                                                                {{ fileName || 'Choose file' }}
                                                            </label>
                                                        </div>
                                                    </div>
                                                    <small v-if="formErrors.evidence_file" class="text-danger">{{ formErrors.evidence_file }}</small>
                                                </div> 
                                                <div class="form-group col-md-6">                                                    
                                                    <label>Status</label>
                                                    <select required v-model="form.status" 
                                                    class="form-control"                                              
                                                    :class="{ 
                                                        'is-invalid': formErrors.status, 
                                                        'is-valid': form.status && !formErrors.status 
                                                    }"
                                                    
                                                    >
                                                        <option value="">-- Select Status --</option>
                                                        <option v-for="item in statusOptions" :key="item.id" :value="item.option">{{ item.option }}</option>
                                                    </select>    

                                                </div>  
                                                
                                                
                                            

                                            </div>
                                            
                                           

                                        <div class="d-flex justify-content-end">
                                            <button :disabled="isLoading" type="submit" class="btn btn-info mr-0">
                                                <span v-if="isLoading"><i class="fas fa-spinner fa-spin"></i> Saving...</span>
                                                <span v-else><i class="fas fa-save"></i> Save</span>
                                            </button>                                               
                                        </div>                                                
                                        </div>
                                    </div>                                                                            
                                </form>                               
                            </div>
                          </div>
                        </div>
                      </div>                                  
                    </div>                                                                                                     
                </div>
              </div>
            </div>
          </div>
        </div>        
      </div>    
    </div>  
  </AuthenticatedLayout>
</template>
<style>
  .is-invalid {
    border-color: red;
  }
  .text-danger {
    font-size: 0.875rem;
  }

  .card-success:not(.card-outline)>.card-header {
    background-color: #20c997 !important;
}
</style>

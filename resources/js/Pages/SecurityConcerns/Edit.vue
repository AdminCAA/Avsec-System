<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import { Head,Link, useForm } from '@inertiajs/vue3';
import { ref} from 'vue';
import Swal from 'sweetalert2';
import 'sweetalert2/dist/sweetalert2.min.css';
import 'vue-select/dist/vue-select.css'
import {router} from '@inertiajs/vue3';
import dayjs from 'dayjs';


const {qualityControl, question,facility,followups} = defineProps({ 
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
    followups: {
      type: Object,
      required: true
    }
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
  {id : 3, option  : 'Overdue'},  
]

const followupActionOptions = [
{id : 1, option  : 'Onsite'},
  {id : 2, option  : 'Administrative'},  
  {id : 3, option  : 'Onsite and Administrative'},  
  {id : 4, option  : 'Not Applicable'},  
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
    immediate_corrective_action: question.immediate_corrective_action || '', // Assuming this is a new field for immediate corrective action
    problem_cause: question.problem_cause || '',
    recommendations: question.recommendations || '', // Assuming this is a new field for recommendations
    reference: question.reference || '', // Assuming this is a new field for reference
    proposed_follow_up_action: question.proposed_follow_up_action || '',
    short_term_action: question.short_term_action || '',
    short_term_date: question.short_term_date || '', // Assuming this is a new field for short term date
    long_term_action: question.long_term_action || '',
    long_term_date: question.long_term_date || '', // Assuming this is a new field for long term date
    completion_date: question.completion_date || '',
    date_of_closure: question.date_of_closure || '',
    follow_up_date: question.follow_up_date || '',    
    cap_status: question.cap_status || '', // New field for CAP status
    evidence_file: null, // For file upload    
    cap_file: null, // For CAP file upload
    cap_status: question.cap_status || '', // New field for CAP status
    reason_for_rejection: question.reason_for_rejection || '', // New field for reason for rejection
});


const selectedRowId = ref(null);
  
const selectRow = (id) => {
    selectedRowId.value = id;
};
const isLoading = ref(false);
const formErrors = ref({});




// Realtime validation examples
function validateQuestionForm() {  
    const errors = {};
    if (!form.question_response) errors.question_response = 'Response is required';
    if (!form.finding_category) errors.finding_category = 'Finding category is required';
    if (!form.date_quality_control) errors.date_quality_control = 'Date of Quality Control is required';
    if(!form.finding_observation) errors.finding_observation = 'Finding/Observation is required';
    //if (!form.problem_cause) errors.problem_cause = 'Problem cause is required';
    if (!form.status) errors.status = 'Status is required';
    //if (!form.date_of_closure) errors.date_of_closure = 'Date of closure is required';
    //if (!form.completion_date) errors.completion_date = 'Completion date is required';
    //if (!form.follow_up_date) errors.follow_up_date = 'Follow-up date is required';
    //Check if the evidence file is more the 2Mb
    if (form.evidence_file && form.evidence_file.size > 2 * 1024 * 1024) {
        errors.evidence_file = 'File size must be less than 2MB';
    } 
    //Check if the evidence file is file type
    if (form.evidence_file && !['application/pdf', 'image/jpeg', 'image/png', 'image/jpg'].includes(form.evidence_file.type)) {
        errors.evidence_file = 'Only PDF, JPG, or PNG files are allowed.';
    } 

    //Check if the cap file is more the 2Mb
    if (form.cap_file && form.cap_file.size > 2 * 1024 * 1024) {
        errors.cap_file = 'File size must be less than 2MB';
    }
    //Check if the cap file is file type
    if (form.cap_file && !['application/pdf', 'image/jpeg', 'image/png', 'image/jpg'].includes(form.cap_file.type)) {
        errors.cap_file = 'Only PDF, JPG, or PNG files are allowed.';
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
    formData.append('immediate_corrective_action', form.immediate_corrective_action); // Append the new field for immediate corrective action
    formData.append('problem_cause', form.problem_cause);
    formData.append('recommendations', form.recommendations); // Append the new field for recommendations
    formData.append('reference', form.reference); // Append the new field for reference
    formData.append('proposed_follow_up_action', form.proposed_follow_up_action);
    formData.append('short_term_action', form.short_term_action);
    formData.append('short_term_date', form.short_term_date); // Append the new field for short term date
    formData.append('long_term_action', form.long_term_action);
    formData.append('long_term_date', form.long_term_date); // Append the new field for long term date
    formData.append('completion_date', form.completion_date);
    formData.append('date_of_closure', form.date_of_closure);
    formData.append('follow_up_date', form.follow_up_date);
    formData.append('cap_status', form.cap_status); // Append the new field for CAP status
    formData.append('reason_for_rejection', form.reason_for_rejection); // Append the new field for reason for rejection

    if (form.evidence_file) {
        formData.append('evidence_file', form.evidence_file);
    }   
    if (form.cap_file) {
        formData.append('cap_file', form.cap_file);
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

const generateCAR = async () => {   
    try{
      const response = await axios.get(`/api/securityconcerns/${question.id}/generateCar`,{
        responseType:'blob'
      });      
      const url = window.URL.createObjectURL(new Blob([response.data]));
      const link =  document.createElement('a');
      link.href = url;
      link.setAttribute('download','correctiveActionRequest.pdf');
      document.body.appendChild(link);
      link.click();
      document.body.removeChild(link);

    }catch(error){
      console.log(error);
      Swal.fire({
              icon: "error",
              title: "PDF Generation Failed",
              text: 'Something went wrong while generating the PDF file.',
              toast: true,  
              position: "top-end",
              showConfirmButton: false,
              timer: 1000,
              timerProgressBar: true,
          });
    }    
  }

let fileName = ref('');
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

let capfileName = ref('');
const handleCapFileUpload = (event) => {
    const file = event.target.files[0];
    if (file) {
        form.cap_file = file;
        capfileName.value = file.name;
        // Optional: Basic file type validation
        const allowedTypes = ['application/pdf', 'image/jpeg', 'image/png', 'image/jpg'];
        if (!allowedTypes.includes(file.type)) {            
            formErrors.cap_file = 'Only PDF, JPG, or PNG files are allowed.';
        } else {
            formErrors.cap_file = '';
        }
    } else {
        capfileName = '';
        form.cap_file = null;
    }
};


const deleteFollowup = (id)=>{
    Swal.fire({
      title: 'Are you sure?',
      text: 'This action cannot be undone.',
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#d33',
      cancelButtonColor: '#3085d6',
      confirmButtonText: 'Yes, delete it!'
    })
    .then((result)=>{
      if (result.isConfirmed) {
        axios.delete(route('followups.destroy', id),{data:{}})
        .then(response => {            
          Swal.fire({
            icon: 'success',
            title: 'Followup deleted successfully',
            toast: true,
            position: 'top-end',
            showConfirmButton: false,
            timer: 1000,
            timerProgressBar: true,
          });
          //redirect to the permissions index page
          setTimeout(() => {
              router.visit(route('securityconcerns.edit',question.id), {
              preserveScroll: true,
              replace: true
            });          
          }, 1000);        
        })
        .catch(error => {    
          let message = "Something went wrong.";
          if (error.response && error.response.status === 422){
              const errors = error.response.data.errors;
              message = Object.values(errors).flat().join("\n");
          }
          if(error.response && error.response.status === 404) {                        
            message = error.response.data.error;
          }
          if(error.response && error.response.status === 403) {                        
            message = error.response.data.errors;
          }
          Swal.fire({
              icon: "error",
              title: "Processing failed",
              text: message,
              toast: true,  
              position: "top-end",
              showConfirmButton: false,
              timer: 1000,
              timerProgressBar: true,
          });
        });
      }
    })    
  }

</script>

<template>
  <Head title="Update Checklist Question"/>
  <AuthenticatedLayout>
    <div class="content-wrapper">    
      <div class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-12">
                    <h4><Link :href="route('facilities.show',qualityControl.facility.id)">{{ qualityControl.facility.name }} </Link> / <Link :href="route('quality-controls.edit',qualityControl.id)">{{ qualityControl.title }} - {{  qualityControl.control_type }} </Link> / <Link :href="route('quality-controls.show',qualityControl.id)">Checklist</Link></h4>                    
                </div>                
            </div>
        </div>
      </div>
    
      <div class="content">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h4 class="m-0">Update Quality Control Question</h4>
                </div>    
                <div class="col-sm-6">
                  <ol class="breadcrumb float-sm-right">                    
                    <li class="breadcrumb-item">
                        <button @click="generateCAR" class="btn  btn-primary">
                            <i class="fas fa-file-pdf"></i> Generate CAR                        
                        </button>
                    </li> 
                    <li class="breadcrumb-item">
                        <Link class="btn btn-info" :href="route('securityconcerns.index')"><i class="fas fa-arrow-left"></i> Back</Link>
                    </li>                                
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
                                                    v-model="form.question_response" 
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
                                                    <select  v-model="form.finding_category" 
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
                                                    <label>Recommendations</label>
                                                    <textarea  v-model="form.recommendations"
                                                    class="form-control" rows="2" placeholder="Recommendations"                                                                                                        
                                                    :class="{ 
                                                                'is-invalid': formErrors.recommendations, 
                                                                'is-valid': form.recommendations && !formErrors.recommendations 
                                                        }" 
                                                    >
                                                    </textarea>
                                                    <small v-if="formErrors.recommendations" class="text-danger">{{ formErrors.recommendations }}</small>                                                     
                                                </div>

                                                <div class="form-group col-md-6">
                                                    <label>Reference</label>
                                                    <input 
                                                        required 
                                                        v-model="form.reference"                                         
                                                        type="text"
                                                        class="form-control"                                                          
                                                        :class="{ 
                                                                'is-invalid': formErrors.reference, 
                                                                'is-valid': form.reference && !formErrors.reference 
                                                            }"                                                     
                                                        placeholder="Reference"
                                                    />
                                                    <small v-if="formErrors.reference" class="text-danger">{{ formErrors.reference }}</small>                                                                                                         
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="form-group col-md-6">                                                    
                                                    <label>Proposed Follow up Action</label>
                                                    <select  v-model="form.proposed_follow_up_action" 
                                                    class="form-control"                                              
                                                    :class="{ 
                                                        'is-invalid': formErrors.proposed_follow_up_action, 
                                                        'is-valid': form.proposed_follow_up_action && !formErrors.proposed_follow_up_action 
                                                    }"
                                                    
                                                    >
                                                        <option value="">-- Select Proposed Followup Action --</option>
                                                        <option v-for="item in followupActionOptions" :key="item.id" :value="item.option">{{ item.option }}</option>
                                                    </select>    
                                                </div>  
                                                <div class="form-group col-md-6">
                                                    <label>Immediate Corrective Actions</label>
                                                    <textarea v-model="form.immediate_corrective_action
                                                    "class="form-control" rows="2" placeholder="Immediate Corrective Action"
                                                    
                                                    @change="validateQuestionForm(question.id)"
                                                    :class="{ 
                                                                'is-invalid': formErrors.immediate_corrective_action, 
                                                                'is-valid': form.immediate_corrective_action && !formErrors.immediate_corrective_action 
                                                        }" 
                                                    >
                                                    </textarea>                                                                                  
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
                                                    <select  v-model="form.status" 
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


                                            <div class="card card-info collapsed-card">
                                                <div class="card-header">
                                                    <h3 style="font-weight: bold;" class="card-title" data-card-widget="collapse">Corrective Action Plan</h3>
                                                    <div class="card-tools">
                                                        <button type="button" class="btn btn-tool" data-card-widget="collapse"><i class="fas fa-plus"></i>
                                                        </button>
                                                    </div>
                                                <!-- /.card-tools -->
                                                </div>
                                                <!-- /.card-header -->
                                                <div class="card-body">
                                                    <div class="row">                                                                                                                                              
                                                        <div class="form-group col-md-6">                                    
                                                            <label v-if="!question.cap_file">CAP Attachment</label>  
                                                            <a v-if="question.cap_file"
                                                            
                                                                data-bs-toggle="tooltip"
                                                                title="View CAP Attachment"
                                                                :href="`/storage/${question.cap_file}`" 
                                                                target="_blank"
                                                            >
                                                                <i class="fas fa-paperclip"></i><span><label>CAP Attachment</label> </span>
                                                            </a>                                      
                                                            <div class="input-group">
                                                                <div class="custom-file">
                                                                    <input 
                                                                        type="file"                                                     
                                                                        accept="image/*,application/pdf"   
                                                                        @change="handleCapFileUpload"
                                                                        class="custom-file-input" 
                                                                        id="exampleInputFile"
                                                                        :class="{ 'is-invalid': formErrors.cap_file, 'is-valid': form.cap_file && !formErrors.cap_file }"
                                                                    >
                                                                    <label class="custom-file-label" for="exampleInputFile">
                                                                        {{ capfileName || 'Choose file' }}
                                                                    </label>
                                                                </div>
                                                            </div>
                                                            <small v-if="formErrors.cap_file" class="text-danger">{{ formErrors.cap_file }}</small>
                                                        </div>                                                     
                                                    </div>
                                                    <!-- <div class="d-flex justify-content-end">
                                                        <button @click="downLoadOperator" class="btn btn-sm btn-primary">
                                                            <i class="fas fa-file-pdf"></i> Export CAP                        
                                                        </button>
                                                    </div>                                                                              -->
                                                </div>
                                                <!-- /.card-body -->
                                            </div>
                                                                
                                            <!-- general form elements -->
                                            <div class="card card-info collapsed-card">
                                                <div class="card-header">
                                                    <h3 style="font-weight: bold;"  class="card-title" data-card-widget="collapse">
                                                        Follow-Ups <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-warning ml-1"> 
                                                            {{followups.length}}
                                                            
                                                        </span>
                                                    </h3>
                                                    <div class="card-tools">
                                                        <button type="button" class="btn btn-tool" data-card-widget="collapse"><i class="fas fa-plus"></i>
                                                        </button>
                                                    </div>                                                
                                                </div>
                                                
                                                <div class="card-body">
                                                    <div class="d-flex justify-content-end mb-2">
                                                        <Link :href="route('followups.create', question.id)" class="btn btn-primary btn-sm "><i class="fas fa-plus"></i> Add Follow-Up</Link>                                                    
                                                    </div>
                                                    <div class="table-responsive">
                                                        <table   id="example2" class="table table-sm table-bordered table-hover table-striped">
                                                            <thead>
                                                            <tr>
                                                            <th>#</th>
                                                            <th>Title</th>
                                                            <th>Comment</th>                                   
                                                            <th>Date</th>       
                                                            <th>Inspector</th>                        
                                                            <th>Actions</th>             
                                                            </tr>
                                                            </thead>
                                                            <tbody>
                                                            <tr  v-for="(followup, index) in followups" :key="followup.id"
                                                            :class="{'table table-selected': selectedRowId === followup.id }" 
                                                            @click="selectRow(followup.id)"                 
                                                            >
                                                            <td>{{  index + 1 }}</td>
                                                            <td class="text-center">{{ followup.title }}</td>

                                                            <td class="text-center">{{ followup.followup_comments }}</td>
                                                            
                                                                                
                                                            <td class="text-center">{{dayjs(followup.followup_date).format('DD-MM-YYYY')}}</td>
                                                            <td class="text-center">                        
                                                                {{ followup.user_name }}          
                                                            </td>
                                                                                
                                                            <td>
                                                                <div class="d-flex justify-content-center">

                                                                <Link class="btn btn-info btn-sm mr-2" :href="route('followups.edit', followup.id)">
                                                                    <i class="fas fa-edit"></i> <span>Edit</span>
                                                                </Link>
                                                                <button type="button" class="btn btn-danger btn-sm" @click="deleteFollowup(followup.id)">
                                                                    <i class="fas fa-trash"></i> <span>Del</span>
                                                                </button>
                                                                </div>
                                                            </td>                    
                                                            </tr>                                        
                                                            </tbody>                
                                                        </table>
                                                    </div>
                                                </div>                                                
                                            </div>

                                            <!-- general form elements -->



                                            <!-- <div class="card card-info collapsed-card">
                                                <div class="card-header">
                                                    <h3 style="font-weight: bold;"  class="card-title">Operator Responses</h3>
                                                    <div class="card-tools">
                                                        <button type="button" class="btn btn-tool" data-card-widget="collapse"><i class="fas fa-plus"></i>
                                                        </button>
                                                    </div>
                                                
                                                </div>
                                                
                                                <div class="card-body">
                                                    <div class="row">
                                                <div class="form-group col-md-6">
                                                    <label>Action Taken By Operator</label>
                                                    <textarea v-model="form.action_taken
                                                    "class="form-control" rows="2" placeholder="Action Taken">
                                                    </textarea>                                                                                            
                                                </div>

                                                <div class="form-group col-md-6">
                                                    <label>Root Cause of Problem</label>
                                                    <textarea v-model="form.problem_cause"
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
                                                <label>Short term  Date</label>
                                                <input                                                     
                                                    v-model="form.short_term_date"                                         
                                                    type="date"
                                                    class="form-control"                                                             
                                                    :class="{ 
                                                        'is-invalid': formErrors.short_term_date, 
                                                        'is-valid': form.short_term_date && !formErrors.short_term_date 
                                                    }"                                                  
                                                    placeholder="Short Term Date"
                                                />  
                                                <small v-if="formErrors.short_term_date" class="text-danger">{{ formErrors.short_term_date }}</small>                                      
                                                </div>                                                
                                            </div> 

                                            <div class="row">
                                                <div class="form-group col-md-6">
                                                    <label>Long term CAP</label>
                                                    <textarea v-model="form.long_term_action" class="form-control" rows="2" placeholder="Long term CAP">
                                                    </textarea>
                                                </div>

                                                <div class="form-group col-md-6">
                                                <label>Long term  Date</label>
                                                <input                                                     
                                                    v-model="form.long_term_date"                                         
                                                    type="date"
                                                    class="form-control"                                                             
                                                    :class="{ 
                                                        'is-invalid': formErrors.long_term_date, 
                                                        'is-valid': form.long_term_date && !formErrors.long_term_date 
                                                    }"                                                  
                                                    placeholder="Long Term Date"
                                                />  
                                                <small v-if="formErrors.long_term_date" class="text-danger">{{ formErrors.long_term_date }}</small>                                      
                                                </div> 
                                            </div>

                                            <div class="row">
                                                <div class="form-group col-md-6">
                                                    <label>Proposed Completion Date</label>
                                                    <input                                              
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
                                                    <label>Follow-Up Date</label>
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
                                                    <label>Date of Closure</label>
                                                    <input                                                      
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
                                                <div class="form-group col-md-2">
                                                    <label class="d-block">Accept/Reject</label>
                                                    <div class="custom-control custom-radio custom-control-inline">
                                                        <input class="custom-control-input"
                                                            type="radio"
                                                            id="acceptCap"
                                                            name="cap_status"
                                                            value="Accepted"
                                                            v-model="form.cap_status">
                                                        <label for="acceptCap" class="custom-control-label">CAP Accepted</label>
                                                    </div>

                                                    <div class="custom-control custom-radio custom-control-inline">
                                                        <input class="custom-control-input"
                                                            type="radio"
                                                            id="rejectCap"
                                                            name="cap_status"
                                                            value="Rejected"
                                                            v-model="form.cap_status">
                                                        <label for="rejectCap" class="custom-control-label">CAP Rejected</label>
                                                    </div>                                                
                                                </div>
                                                <div class="form-group col-md-4">
                                                    <div v-if="form.cap_status === 'Rejected'" class="form-group">
                                                    <label>Reason for Rejecting CAP</label>
                                                    <textarea v-model="form.reason_for_rejection" class="form-control"  placeholder="Reason for Rejecting CAP">
                                                    </textarea>
                                                </div>
                                                </div>

                                                
                                            </div>                                                                            
                                            </div>                                            
                                            </div>    -->
                                            

                                            
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

.table .table-selected {
    background-color: #bebebe !important; /* or any other color */
    color: white !important; /* or any other color */
  }
  
  
 
  .table td, .table th {    
        vertical-align: middle;    
    }
    .table th {
        text-align: center;
        background-color: #B2C6D5;  
    }



    .card-title:hover {
        color: #007bff;      /* Bootstrap primary blue */
        cursor: pointer;  
    }

    .card-title {
    position: relative;
    display: inline-block;
    }

    .card-title::after {
    content: "";
    position: absolute;
    left: 0;
    bottom: -3px;
    width: 0;
    height: 2px;
    /* background: #007bff; */
    transition: width 0.3s ease;
    }

    .card-title:hover::after {
    width: 100%;
    }


    .card-title {
    transition: transform 0.2s ease, color 0.2s ease;
    }

    .card-title:hover {
    transform: scale(1.05);
    color: #0056b3;
    }


</style>



<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import { Head,Link, useForm } from '@inertiajs/vue3';

import Swal from 'sweetalert2';
import 'sweetalert2/dist/sweetalert2.min.css';
import InputError from '@/Components/InputError.vue';
import { router } from '@inertiajs/vue3';
import { ref, watch } from 'vue';
import 'sweetalert2/dist/sweetalert2.min.css';
import vSelect from 'vue-select'
import 'vue-select/dist/vue-select.css'


const {
    trainings,user_id
} = defineProps({
   
    trainings: {
        type: Object,
        required: true
    },
    user_id: {
        type: Number,
        required: true
    }
   
});

const genderOptions = [
    'Male','Female'
]

const userStatuses = [
    'Active', 'Expired',
    'Suspended',
];
const certificationTypes = [
    'Certification', 'License','Training'
];


const formErrors = ref({
    certification_name: "",   
    certification_type: "",
    certification_body: "",   
    date_issued: "", 
    expiry_date: "", 
    certification_number: "",
    score: "", // Initialize score as null    
    status:"",  
    remarks: "",  
    certification_file: null,
    
});


const form = useForm({
    certification_name: "",   
    certification_type: "",
    certification_body: "",   
    date_issued: "", 
    expiry_date: "",         
    certification_number:"",
    status:"",
    score: "", 
    remarks: "",
    certification_file: null,
});

const isLoading = ref(false);
const errorMessage = ref('');

// Define the score property as numbers 1 to 100

const scoreOptions = Array.from({ length: 100 }, (_, i) => i + 1);


function createCertification() {
    let formData = new FormData();
    isLoading.value = true;   

    // Append form data    
    formData.append('user_id', user_id); // Use the selected user ID
    formData.append('certification_name', form.certification_name);
    formData.append('certification_type', form.certification_type); // Use the selected certification type
    formData.append('certification_number', form.certification_number);
    formData.append('expiry_date',form.expiry_date);
    formData.append('date_issued', form.date_issued); // Use the selected facility ID
    formData.append('certification_body', form.certification_body);
    formData.append('status', form.status); // Use the selected status
    formData.append('score', form.score);
    formData.append('remarks', form.remarks);
  
    // Append attachment file if present
    if (form.certification_file) {
        formData.append('certification_file', form.certification_file);
    }
   
    axios.post(route('certifications.store', user_id), formData)
    .then(response => {
        Swal.fire({
            icon: "success",
            title: "Certification created successfully",
            toast: true,
            position: "top-end",
            showConfirmButton: false,
            timer: 1000,
            timerProgressBar: true,
        });
             
        //redirect to the permissions index page
        setTimeout(() => {            
            router.visit(route('personnels.show', user_id), {
                preserveScroll: true,
                replace: true
            }); 
        }, 1000);        
    })
    .catch(error => {           
        let message = "Something went wrong.";
        if (error.response && error.response.status === 422) {
            const errors = error.response.data.errors;
            message = Object.values(errors).flat().join("\n");
        }
        Swal.fire({
            icon: "error",
            title: "Validation failed",
            text: message,
            toast: true,
            position: "top-end",
            showConfirmButton: false,
            timer: 3000,
            timerProgressBar: true,
        });
        // Handle the error message
        if (error.response && error.response.status === 422) {
            const errors = error.response.data.errors;
            errorMessage.value = Object.values(errors).flat().join("\n");
        } else if (error.response && error.response.status === 404) {
            errorMessage.value = error.response.data.error;
        } else {
            errorMessage.value = "An unexpected error occurred.";
        }        
    }).finally(() => {
        isLoading.value = false;
    });
            
}

watch(() => form.status, (value) => {
    if (!value.trim()) {
        formErrors.value.status = 'Status is required.';        
    }  else {
        formErrors.value.status = '';
    }
});

watch(() => form.certification_type, (value) => {
    if (!value.trim()) {
        formErrors.value.certification_type = 'Certificate type is required.';        
    }  else {
        formErrors.value.certification_type = '';
    }
});

watch(() => form.score, (value) => {
    if (!value) {
        formErrors.value.score = 'Score is required.';        
    }  else {
        formErrors.value.score = '';
    }
});

watch(() => form.certification_body, (value) => {
  
  if (!value.trim()) {
    formErrors.value.certification_body = 'Certication body is required.';
    } else if (value.trim().length < 3) {
    formErrors.value.certification_body = 'Certification body must be at least 3 characters.';
  } else {
    formErrors.value.certification_body = '';
  }
});

watch(() => form.certification_number, (value) => {
    if (!value.trim()) {
        formErrors.value.certification_number = 'Certification number is required.';
    } else if (value.trim().length < 3) {
        formErrors.value.certification_number = 'Certification number must be at least 3 characters.';
    } else {
        formErrors.value.certification_number = '';
    }  
});

watch(() => form.date_issued, (value) => {
    if (!value.trim()) {
        formErrors.value.date_issued = 'Issue date is required.';
    } else if (form.expiry_date && new Date(value) >= new Date(form.expiry_date)) {
        formErrors.value.date_issued = 'Issue date must be less than expiry date.';
    } else {
        formErrors.value.date_issued = '';
        formErrors.value.expiry_date = ''; 
    }
});

watch(() => form.expiry_date, (value) => {
    if (!value.trim()) {
        formErrors.value.expiry_date = 'Expiry date is required.';
    } else if (form.date_issued && new Date(value) <= new Date(form.date_issued)) {
        formErrors.value.expiry_date = 'Expiry date must be greater than issue date.';
    } else {
        formErrors.value.expiry_date = '';
        formErrors.value.date_issued = ''; 
    }
});

// Handle file upload for attachment
const fileName = ref('');

const handleFileUpload = (event) => {
    const file = event.target.files[0];
    if (file) {
        form.certification_file = file;
        fileName.value = file.name;
        // Optional: Basic file type validation
        const allowedTypes = ['application/pdf', 'image/jpeg', 'image/png', 'image/jpg'];
        if (!allowedTypes.includes(file.type)) {
            this.formErrors.certification_file = 'Only PDF, JPG, or PNG files are allowed.';
        } else {
            formErrors.certification_file = '';
        }
    } else {
        fileName = '';
        form.certification_file = null;
    }
};
</script>

<template>
    <Head title="Certification-Create" />
    <AuthenticatedLayout>
    <div class="content-wrapper">    
        <div class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
            <div class="col-sm-6">
                <h3 class="m-0">Certification / Create</h3>
            </div>
            <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item"><Link class="btn btn-info mr-3" :href="route('personnels.show',user_id)"><i class="fas fa-arrow-left"></i> Back</Link></li>
                </ol>
            </div>
            </div>
        </div>
        </div>
   
    <div class="content">
      <div class="container-fluid">
        <div class="d-flex justify-content-center align-items-center min-vh-60  bg-light">
            <div class="row w-100 justify-content-center">
                <div class="col-md-12"> 
                    <div class="col-md-12">                    
                        <!-- general form elements -->
                        <div class="card card-info">
                            <div class="card-header">
                                <h3 class="card-title">Create Certification</h3>
                            </div>
                            <!-- form start -->
                            <form @submit.prevent="createCertification" method="post" enctype="multipart/form-data">
                                <div class="card-body">
                                <div class="row">
                                    <div class="form-group col-md-6">
                                        <label>Certification Name</label>
                                        <select required v-model="form.certification_name" class="form-control"
                                            :class="{ 'is-invalid': formErrors.certification_name, 'is-valid': form.certification_name && !formErrors.certification_name }"
                                        >
                                            <option value="">-- Select Certification --</option>
                                            <option v-for="training in trainings" :key="training.id" :value="training.title">
                                                {{ training.title }}
                                            </option>                                            
                                        </select>
                                        <InputError :message="formErrors.certification_name" class="mt-1" />
                                    </div>
                                             

                                    <div class="form-group col-md-6">
                                        <label>Certification Body</label>
                                        <input 
                                            v-model="form.certification_body" 
                                            type="text" 
                                            required max="255"
                                            class="form-control"
                                            :class="{ 'is-invalid': formErrors.certification_body, 'is-valid': form.certification_body && !formErrors.certification_body }"
                                            placeholder="Enter Certification Body">
                                        <InputError :message="formErrors.certification_body" class="mt-1" />
                                    </div> 
                                </div>
                                <div class="row">
                                    <div class="form-group col-md-3">
                                        <label for="date_issued">Issue Date</label>
                                        <input  
                                            v-model="form.date_issued"                                            
                                            type="date" 
                                            name="date_issued"
                                            id="date_issued" 
                                            class="form-control" 
                                            :class="{
                                                'is-invalid': formErrors.date_issued,
                                                'is-valid': form.date_issued && !formErrors.date_issued
                                            }"
                                            required 
                                            placeholder="Enter Issue Date"                                            
                                        >                    
                                        <InputError :message="formErrors.date_issued" class="mt-2" />                                                                 
                                        <div v-if="form.date_issued && !formErrors.date_issued" class="valid-feedback d-block">
                                            Issue date looks good!
                                        </div>
                                    </div>
 
                                    <div class="form-group col-md-3">
                                        <label for="expiry_date">Expiry Date</label>
                                        <input  
                                            v-model="form.expiry_date"                                            
                                            type="date" 
                                            name="expiry_date"
                                            id="expiry_date" 
                                            class="form-control" 
                                            :class="{
                                                'is-invalid': formErrors.expiry_date,
                                                'is-valid': form.expiry_date && !formErrors.expiry_date
                                            }"
                                            required 
                                            placeholder="Enter Expiry Date"                                            
                                        >                                                                                
                                        <InputError :message="formErrors.expiry_date" class="mt-2" />                                                                                
                                        <div v-if="form.expiry_date && !formErrors.expiry_date" class="valid-feedback d-block">
                                            Expiry date looks good!
                                        </div>
                                    </div> 
                                    
                                    <div class="form-group col-md-3">
                                        <label>Score</label>
                                        <select required v-model="form.score" class="form-control"
                                            :class="{ 'is-invalid': formErrors.score, 'is-valid': form.score && !formErrors.score }"    

                                        >
                                            <option value="">-- Select Score --</option>
                                            <option v-for="score in scoreOptions" :key="score" :value="score">
                                                {{ score }}
                                            </option>
                                        </select>

                                        <InputError :message="formErrors.score" class="mt-1" />
                                    </div>  
                                    <div class="form-group col-md-3">
                                        <label>Certificate Number</label>
                                        <input 
                                            v-model="form.certification_number" 
                                            type="text" 
                                            required max="20"
                                            class="form-control"
                                            :class="{ 'is-invalid': formErrors.certification_number, 'is-valid': form.certification_number && !formErrors.certification_number }"
                                            placeholder="Enter Certificate Number">
                                        <InputError :message="formErrors.certification_number" class="mt-1" />
                                    </div>                                                                     
                                </div>

                                <div class="row">
                                    <div class="form-group col-md-6">
                                        <label>Status</label>
                                        <select required v-model="form.status" class="form-control"
                                            :class="{ 'is-invalid': formErrors.status, 'is-valid': form.status && !formErrors.status }"
                                        >
                                            <option value="">-- Select Status --</option>
                                            <option v-for="item in userStatuses" :key="item" :value="item">{{ item }}</option>
                                        </select>
                                        <InputError :message="formErrors.status" class="mt-1" />
                                    </div>

                                    <div class="form-group col-md-6">
                                        <label>Certification Type</label>
                                        <select required v-model="form.certification_type" class="form-control"
                                            :class="{ 'is-invalid': formErrors.certification_type, 'is-valid': form.certification_type && !formErrors.certification_type }"
                                        >
                                            <option value="">-- Select Certification Type --</option>
                                            <option v-for="item in certificationTypes" :key="item" :value="item">{{ item }}</option>
                                        </select>
                                        <InputError :message="formErrors.user_type" class="mt-1" />
                                    </div>
                                                                                                            
                                </div>                            
                             


                                <div class="row">                                                                                                            
                                    <div class="form-group col-md-6">                                    
                                      <label>Remarks</label>                                        
                                      <textarea 
                                          v-model="form.remarks" 
                                          class="form-control"
                                          :class="{ 'is-invalid': formErrors.remarks, 'is-valid': form.remarks && !formErrors.remarks }"
                                          placeholder="Enter Remarks">
                                        </textarea>
                                      <InputError :message="formErrors.remarks" class="mt-1" />
                                    </div>  


                                    <div class="form-group col-md-6">                                    
                                        <label>Attachment</label>                                        
                                        <div class="input-group">
                                            <div class="custom-file">
                                            <input 
                                                type="file"                                                     
                                                accept="image/*,application/pdf"   
                                                @change="handleFileUpload"
                                                class="custom-file-input" 
                                                id="exampleInputFile"
                                                :class="{ 'is-invalid': formErrors.certification_file, 'is-valid': form.certification_file && !formErrors.certification_file }"
                                            >
                                            <label class="custom-file-label" for="exampleInputFile">
                                                {{ fileName|| 'Choose file' }}
                                            </label>
                                        </div>

                                        </div>
                                        <InputError :message="formErrors.certification_file" class="mt-1" />
                                    </div>  

                                </div>   
                                                         
                                </div>
                                                                    
                                <div class="card-footer">
                                    <div class="d-flex ">                                
                                        <button :disabled="isLoading"
                                            :class="{ 'opacity-25': isLoading }"
                                            type="submit"
                                            class="btn btn-info ml-auto mr-2">
                                            <span v-if="isLoading">
                                                <i class="fas fa-spinner fa-spin"></i> Processing...
                                            </span>
                                            <span v-else>
                                                <i class="fas fa-save"></i> Submit
                                            </span>
                                        </button> 
                                        <Link :href="route('personnels.show', user_id)" class="btn btn-default float-right">
                                            <i class="fas fa-window-close"></i> Cancel
                                        </Link>                
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
    </AuthenticatedLayout>
</template>
<style>
.content-wrapper {
  font-family: 'Poppins', 'Segoe UI', sans-serif;
}
</style>
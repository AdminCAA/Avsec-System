
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


const { user_id, qualification } = defineProps({       
    user_id: {
        type: Number,
        required: true
    },
    qualification: {
        type:Object,
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
const qualificationTypes = [
    'Certificate', 'Diploma','Degree','Masters'
];


const formErrors = ref({
    qualification_name: "",   
    qualification_type: "",
    qualification_number:"",
    institution: "",   
    date_obtained: "", 
    qualification_file: null,   
});


const form = useForm({
    qualification_name: qualification.qualification_name || "",
    qualification_type: qualification.qualification_type || "",
    qualification_number: qualification.qualification_number || "",
    date_obtained: qualification.date_obtained || "",
    qualification_file: null, // Initialize as null for file upload
    institution: qualification.institution || "",       
});

const isLoading = ref(false);
const errorMessage = ref('');

// Define the score property as numbers 1 to 100

const scoreOptions = Array.from({ length: 100 }, (_, i) => i + 1);


function editQualification() {
    let formData = new FormData();
    isLoading.value = true;   

    // Append form data    
    formData.append('user_id', user_id); // Use the selected user ID
    formData.append('qualification_name', form.qualification_name);
    formData.append('institution', form.institution);
    formData.append('qualification_type', form.qualification_type); // Use the selected certification type
    formData.append('qualification_number', form.qualification_number);
    formData.append('date_obtained',form.date_obtained);    
  
    // Append attachment file if present
    if (form.qualification_file) {
        formData.append('qualification_file', form.qualification_file);
    }
   
    axios.post(route('qualifications.update', qualification.id), formData)
    .then(response => {
        Swal.fire({
            icon: "success",
            title: "Qualification updated successfully",
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


watch(() => form.qualification_name, (value) => {
    if (!value.trim()) {
        formErrors.value.qualification_name = 'Qualification name is required.';        
    }  else {
        formErrors.value.qualification_name = '';
    }
});



watch(() => form.qualification_type, (value) => {
    if (!value.trim()) {
        formErrors.value.qualification_type = 'Qualification type is required.';        
    }  else {
        formErrors.value.qualification_type = '';
    }
});



watch(() => form.institution, (value) => {
  
  if (!value.trim()) {
    formErrors.value.institution = 'Institution is required.';
    } else if (value.trim().length < 3) {
    formErrors.value.institution = 'Institution must be at atleast 3 characters.';
  } else {
    formErrors.value.institution = '';
  }
});

watch(() => form.qualification_number, (value) => {
    if (value.trim().length < 3) {
        formErrors.value.qualification_number = 'Qualification number must be at least 3 characters.';
    } else {
        formErrors.value.qualification_number = '';
    }  
});

watch(() => form.date_obtained, (value) => {
    if (!value.trim()) {
        formErrors.value.date_obtained = 'Date obtained is required.';
    }  else {
        formErrors.value.date_obtained = '';
        
    }
});


// Handle file upload for attachment
const fileName = ref('');

const handleFileUpload = (event) => {
    const file = event.target.files[0];
    if (file) {
        form.qualification_file = file;
        fileName.value = file.name;
        // Optional: Basic file type validation
        const allowedTypes = ['application/pdf', 'image/jpeg', 'image/png', 'image/jpg'];
        if (!allowedTypes.includes(file.type)) {
            this.formErrors.qualification_file = 'Only PDF, JPG, or PNG files are allowed.';
        } else {
            formErrors.qualification_file = '';
        }
    } else {
        fileName = '';
        form.qualification_file = null;
    }
};


</script>

<template>
    <Head title="Qualification-Create" />
    <AuthenticatedLayout>
    <div class="content-wrapper">    
        <div class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
            <div class="col-sm-6">
                <h3 class="m-0">Qualification / Edit</h3>
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
                                <h3 class="card-title">Edit Qualification</h3>
                            </div>
                            <!-- form start -->
                            <form @submit.prevent="editQualification" method="post" enctype="multipart/form-data">
                                <div class="card-body">
                                    <div class="row">
                                        <div class="form-group col-md-6">
                                            <label>Qualification Name</label>
                                            <input 
                                                v-model="form.qualification_name" 
                                                type="text" 
                                                required max="255"
                                                class="form-control"
                                                :class="{ 'is-invalid': formErrors.qualification_name, 'is-valid': form.qualification_name && !formErrors.qualification_name }"
                                                placeholder="Enter Qualification Name">
                                            <InputError :message="formErrors.qualification_name" class="mt-1" />
                                            <div v-if="form.qualification_name && !formErrors.qualification_name" class="valid-feedback d-block">
                                            Qualification looks good!
                                            </div>
                                        </div>
                                                

                                        <div class="form-group col-md-6">
                                            <label>Institution</label>
                                            <input 
                                                v-model="form.institution" 
                                                type="text" 
                                                required max="255"
                                                class="form-control"
                                                :class="{ 'is-invalid': formErrors.institution, 'is-valid': form.institution && !formErrors.institution }"
                                                placeholder="Enter Institution">
                                            <InputError :message="formErrors.institution" class="mt-1" />
                                            <div v-if="form.institution && !formErrors.institution" class="valid-feedback d-block">
                                            Institution looks good!
                                            </div>
                                        </div> 
                                    </div>
                                    <div class="row">
                                        <div class="form-group col-md-6">
                                            <label for="date_issued">Date Obtained</label>
                                            <input  
                                                v-model="form.date_obtained"                                            
                                                type="date" 
                                                name="date_obtained"
                                                id="date_obtained" 
                                                class="form-control" 
                                                :class="{
                                                    'is-invalid': formErrors.date_obtained,
                                                    'is-valid': form.date_obtained && !formErrors.date_obtained
                                                }"
                                                required 
                                                placeholder="Enter Date Obtained"                                            
                                            >                    
                                            <InputError :message="formErrors.date_obtained" class="mt-2" />                                                                 
                                            <div v-if="form.date_obtained && !formErrors.date_obtained" class="valid-feedback d-block">
                                            Date obtained looks good!
                                            </div>
                                        </div>
    
                                        <div class="form-group col-md-6">
                                            <label>Qualification Type</label>
                                            <select required v-model="form.qualification_type" class="form-control"
                                                :class="{ 'is-invalid': formErrors.qualification_type, 'is-valid': form.qualification_type && !formErrors.qualification_type }"
                                            >
                                                <option value="">-- Select Qualification Type --</option>
                                                <option v-for="item in qualificationTypes" :key="item" :value="item">{{ item }}</option>
                                            </select>
                                            <InputError :message="formErrors.qualification_type" class="mt-1" />
                                            <div v-if="form.qualification_type && !formErrors.qualification_type" class="valid-feedback d-block">
                                            Qualification type looks good!
                                            </div>
                                        </div>                                                                                                
                                    </div>

                                    <div class="row">                                       
                                        <div class="form-group col-md-6">
                                            <label>Qualification Number</label>
                                            <input 
                                                v-model="form.qualification_number" 
                                                type="text" 
                                                max="20"
                                                class="form-control"
                                                :class="{ 'is-invalid': formErrors.qualification_number, 'is-valid': form.qualification_number && !formErrors.qualification_number }"
                                                placeholder="Enter Qualification Number">
                                            <InputError :message="formErrors.qualification_number" class="mt-1" />
                                            <div v-if="form.qualification_number && !formErrors.qualification_number" class="valid-feedback d-block">
                                            Qualification number looks good!
                                            </div>
                                            
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
                                                    :class="{ 'is-invalid': formErrors.qualification_file, 'is-valid': form.qualification_file && !formErrors.qualification_file }"
                                                >
                                                <label class="custom-file-label" for="exampleInputFile">
                                                    {{ fileName|| 'Choose file' }}
                                                </label>
                                            </div>

                                            </div>
                                            <InputError :message="formErrors.qualification_file" class="mt-1" />
                                            <div v-if="form.qualification_file && !formErrors.qualification_file" class="valid-feedback d-block">
                                            Attachement looks good!
                                            </div>
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
                                                <i class="fas fa-save"></i> Save
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
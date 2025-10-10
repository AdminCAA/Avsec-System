<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import { Head, Link, useForm } from '@inertiajs/vue3';

import Swal from 'sweetalert2';
import 'sweetalert2/dist/sweetalert2.min.css';
import InputError from '@/Components/InputError.vue';
import { router } from '@inertiajs/vue3';
import { ref, watch } from 'vue';

const props = defineProps({
    roles: {
        type: Object,
        required: true
    },
    user: {
        type: Object,
        required: true
    },
    userRoles: {
        type: Object,
        required: true
    },
    departments: {
        type: Object,
        required: true
    }
});



const formErrors = ref({
    name: '',
<<<<<<< HEAD
    nrc:'',
    gender:'',
    phone_number:'',
    designation:'',
    portrait: '',
    user_type:"",
    email: '',
    department_id:'',
=======
    nrc: '',
    gender: '',
    phone_number: '',
    designation: '',
    portrait: '',

    email: '',
    department_id: '',
>>>>>>> 38f8373b61a9793faa640ae28cb592a362ddca11
    password: '',
    confirm_password: ''
});


const form = useForm({
    name: props.user.name,
    email: props.user.email,
    nrc: props.user.nrc,
    gender: props.user.gender,
    user_type:props.user.user_type,
    phone_number: props.user.phone_number,
    designation: props.user.designation,
    portrait: null,
    department_id: props.user.department_id,
    password: "",
    confirm_password: ""
});

const isLoading = ref(false);
//Create the user permission
// and redirect to the permissions index page
const selectedRoles = ref([]); // This will hold the selected permission IDs
selectedRoles.value = props.userRoles;
const errorMessage = ref('');

function updateUser() {
    isLoading.value = true;
    let formData = new FormData();

    formData.append('name', form.name);
    formData.append('email', form.email);
    formData.append('nrc', form.nrc);
<<<<<<< HEAD
    formData.append('gender',form.gender);
    formData.append('user_type', form.user_type);
=======
    formData.append('gender', form.gender);
>>>>>>> 38f8373b61a9793faa640ae28cb592a362ddca11
    formData.append('department_id', form.department_id);
    formData.append('designation', form.designation);
    formData.append('phone_number', form.phone_number);
    formData.append('password', form.password);
    formData.append('password_confirmation', form.confirm_password);
    selectedRoles.value.forEach(role => {
        formData.append('roles[]', role);
    });

    // Append the selected trainings with scores
    // Append portrait file if present
    if (form.portrait) {
        formData.append('portrait', form.portrait);
    }


    axios.post(route('users.update', props.user.id),
        formData
        // {
        //     name: form.name, // assuming you're using reactive `form` or `ref()`
        //     email: form.email, // assuming you're using reactive `form` or `ref()`
        //     department_id: form.department_id, // assuming you're using reactive `form` or `ref()`
        //     roles: selectedRoles.value // Get the selected permission IDs
        // }
    )
        .then(response => {
            Swal.fire({
                icon: "success",
                title: "User updated successfully",
                toast: true,
                position: "top-end",
                showConfirmButton: false,
                timer: 1000,
                timerProgressBar: true,
            });
            //redirect to the permissions index page
            setTimeout(() => {
                router.visit(route('users.index'), {
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
<<<<<<< HEAD
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
=======
>>>>>>> 38f8373b61a9793faa640ae28cb592a362ddca11
}


watch(() => form.name, (value) => {
    if (!value.trim()) {
        formErrors.value.name = 'Name is required.';
    } else if (value.trim().length < 3) {
        formErrors.value.name = 'Name must be at least 3 characters.';
    } else {
        formErrors.value.name = '';
    }
});

watch(() => form.email, (value) => {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!value.trim()) {
        formErrors.value.email = 'Email is required.';
    } else if (!emailRegex.test(value)) {
        formErrors.value.email = 'Invalid email format.';
    } else {
        formErrors.value.email = '';
    }
});

watch(() => form.password, (value) => {
    formErrors.value.password = value.length < 6 ? 'Password must be at least 6 characters.' : '';
    let message = '';

    if (value.length < 8) {
        message = "Password must be at least 8 characters.";
    } else if (!/[A-Z]/.test(value)) {
        message = "Add at least one uppercase letter.";
    } else if (!/[a-z]/.test(value)) {
        message = "Add at least one lowercase letter.";
    } else if (!/[0-9]/.test(value)) {
        message = "Add at least one number.";
    } else if (!/[!@#$%^&*(),.?\":{}|<>]/.test(value)) {
        message = "Add at least one special character.";
    } else {
        message = ""; // no error
    }
    formErrors.value.password = message;
});

watch([() => form.password, () => form.confirm_password], ([pwd, confPwd]) => {
    formErrors.value.confirm_password =
        confPwd !== pwd ? 'Passwords do not match.' : '';
});
watch(() => form.name, (value) => {
    if (!value.trim()) {
        formErrors.value.name = 'Name is required.';
    } else if (value.trim().length < 3) {
        formErrors.value.name = 'Name must be at least 3 characters.';
    } else {
        formErrors.value.name = '';
    }
});

watch(() => form.email, (value) => {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!value.trim()) {
        formErrors.value.email = 'Email is required.';
    } else if (!emailRegex.test(value)) {
        formErrors.value.email = 'Invalid email format.';
    } else {
        formErrors.value.email = '';
    }
});

watch(() => form.phone_number, (value) => {
    const phoneRegex = /^\d{10,15}$/; // Adjust regex as needed
    if (!value.trim()) {
        formErrors.value.phone_number = 'Phone number is required.';
    } else if (!phoneRegex.test(value)) {
        formErrors.value.phone_number = 'Invalid phone number format.';
    } else {
        formErrors.value.phone_number = '';
    }
});


watch(() => form.gender, () => {
    if (!form.gender) {
        formErrors.value.gender = 'Gender is required.';
    } else if (!genderOptions.includes(form.gender)) {
        formErrors.value.gender = 'Please select a valid gender.';
    } else {
        formErrors.gender = '';
    }
})

const genderOptions = [
    'Male', 'Female'
]
const userCategoryOptions = [
    'CAA Staff','Non CAA Staff'
]

// Handle file upload for portrait
const fileName = ref('');
const handleFileUpload = (event) => {
    const file = event.target.files[0];
    if (file) {
        form.portrait = file;
        fileName.value = file.name;
    }
};
watch(() => form.nrc, (value) => {
    const nrcPattern = /^\d{1,10}\/\d{1,5}\/\d{1,5}$/;
    if (!value.trim()) {
        formErrors.value.nrc = 'NRC is required.';
    } else if (!nrcPattern.test(value)) {
        formErrors.value.nrc = 'Invalid NRC format. Example: 214129/48/1';
    } else {
        formErrors.value.nrc = '';
    }
});

</script>

<template>

    <Head title="User-Edit" />
    <AuthenticatedLayout>
        <div class="content-wrapper">
            <div class="content-header">
                <div class="container-fluid">
                    <div class="row mb-2">
                        <div class="col-sm-6">
                            <h1 class="m-0">User / Edit</h1>
                        </div>
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item">
                                    <Link class="btn btn-info" :href="route('users.index')"><i
                                        class="fas fa-arrow-left"></i> Back</Link>
                                </li>
                            </ol>
                        </div>
<<<<<<< HEAD
                        <!-- form start -->
                        <form @submit.prevent="updateUser" method="post" enctype="multipart/form-data">                                                                                                                                        
                                <div class="col-md-2 mt-3 ml-3">
                                    <div class="card card-info card-outline">
                                        <div class="card-body box-profile">
                                            <div class="text-center">
                                                <img class="profile-user-img img-fluid img-circle" style="width: 150px;"
                                                    :src="user.portrait ? 
                                                        `/storage/${user.portrait}` 
                                                        : '/storage/portraits/avatar.png'"
                                                        alt="User profile picture">
                                            </div>
                                            <h3 class="profile-username text-center">{{user.name}}</h3>
                                                                                                                                  
                                        </div>                                        
                                    </div>
                                </div>

                                <div class="card-body">
                                <div class="row">
                                    <div class="form-group col-md-6">
                                        <label for="name">Names</label>
                                        <input  
                                            v-model="form.name"
                                            type="text" 
                                            class="form-control"  
                                            id="name"
                                            :class="{
                                                'is-invalid': formErrors.name,
                                                'is-valid': form.name && !formErrors.name
                                            }"
                                            required maxlength="255" 
                                            placeholder="Enter Name">
                                            <InputError :message="formErrors.name || form.errors.name" class="mt-2" />
                                            <div v-if="form.name && !formErrors.name" class="valid-feedback d-block">
                                                Name looks good!
                                            </div>
                                    </div>

                                    <div class="form-group col-md-6">
                                        <label for="name">Email</label>
                                        <input  
                                            v-model="form.email"
                                            type="email" 
                                            class="form-control" id="email" 
                                            :class="{
                                                'is-invalid': formErrors.email,
                                                'is-valid': form.email && !formErrors.email
                                            }"
                                            required max="255" 
                                            placeholder="Enter Email">
                                            <InputError :message="formErrors.email || form.errors.email" class="mt-2" />
                                            <div v-if="form.email && !formErrors.email" class="valid-feedback d-block">
                                                Email looks good!
                                            </div>
                                    </div>

                                </div>
                                <div class="row">
                                    <div class="form-group col-md-6">
                                        <label for="nrc">NRC</label>
                                        <input  
                                            v-model="form.nrc"
                                            type="text" 
                                            name="nrc"
                                            id="nrc" 
                                            class="form-control" 
                                            :class="{
                                                'is-invalid': formErrors.nrc,
                                                'is-valid': form.nrc && !formErrors.nrc
                                            }"
                                            required 
                                            maxlength="12"	 
                                            placeholder="Enter NRC"
                                        >
                                        
                                        <!-- Error Display -->
                                        <InputError :message="formErrors.nrc" class="mt-2" />
                                        
                                        <!-- Success Feedback -->
                                        <div v-if="form.nrc && !formErrors.nrc" class="valid-feedback d-block">
                                            NRC looks good!
                                        </div>
                                    </div>
 
                                    <div class="form-group col-md-6">
                                        <label>Gender</label>
                                        <select required v-model="form.gender" class="form-control"
                                            :class="{ 'is-invalid': formErrors.gender, 'is-valid': form.gender && !formErrors.gender }"
                                        >
                                            <option value="">-- Select Gender --</option>
                                            <option v-for="item in genderOptions" :key="item" :value="item">{{ item }}</option>
                                        </select>
                                        <InputError :message="formErrors.gender" class="mt-1" />                                        
                                        <div v-if="form.gender && !formErrors.gender" class="valid-feedback d-block">
                                            Gender looks good!
                                        </div>
                                    </div>                                                                                                                                        
                                </div>

                                <div class="row">
                                    <div class="form-group col-md-6">
                                        <label>Phone Number</label>
                                        <input 
                                            v-model="form.phone_number" 
                                            type="text" 
                                            required max="15"
                                            class="form-control"
                                            :class="{ 'is-invalid': formErrors.phone_number, 'is-valid': form.phone_number && !formErrors.phone_number }"
                                            placeholder="Enter Phone Number">
                                            <InputError :message="formErrors.phone_number" class="mt-1" />
                                            <div v-if="form.phone_number && !formErrors.phone_number" class="valid-feedback d-block">
                                                Phone number looks good!
                                            </div>
                                    </div>    

                                    <div class="form-group col-md-3">
                                        <label>User Category</label>
                                        <select required v-model="form.user_type" class="form-control"
                                            :class="{ 'is-invalid': formErrors.user_type, 'is-valid': form.user_type && !formErrors.user_type }">
                                            <option value="">-- Select User Category --</option>
                                            <option v-for="item in userCategoryOptions" :key="item" :value="item">{{ item }}</option>
                                        </select>
                                        <InputError :message="formErrors.user_type" class="mt-1" />                                        
                                        <div v-if="form.user_type && !formErrors.user_type" class="valid-feedback d-block">
                                            User Category looks good!
                                        </div>
                                    </div>


                                    <div class="form-group col-md-3">
                                        <label for="designation">Job Position</label>
                                        <input  
                                            v-model="form.designation"
                                            type="text" 
                                            class="form-control"  
                                            id="designation"
                                            :class="{
                                                'is-invalid': formErrors.designation,
                                                'is-valid': form.designation && !formErrors.designation
                                            }"
                                            required maxlength="255" 
                                            placeholder="Enter Designation">
                                            <InputError :message="formErrors.designation || form.errors.designation" class="mt-2" />
                                            <div v-if="form.designation && !formErrors.designation" class="valid-feedback d-block">
                                                Job Position looks good!
                                            </div>
                                    </div>                                                                                                                                               
                                </div>                            
                             


                                <div class="row"> 
                                    <div class="form-group col-md-6"> 
                                        <div class="form-group">
                                            <label>Department</label>
                                            <select required v-model="form.department_id" class="form-control"
                                                :class="{ 'is-invalid': formErrors.department_id, 'is-valid': form.department_id && !formErrors.department_id }"
                                            >
                                                <option value="">-- Department --</option>
                                                <option v-for="item in props.departments" :key="item" :value="item.id">{{ item.name }}</option>
                                            </select>
                                            <div v-if="form.department_id && !formErrors.department_id" class="valid-feedback d-block">
                                                Department looks good!
                                            </div>
                                            <InputError :message="formErrors.department_id" class="mt-1" />
                                        </div>
                                    </div>
                                    
                                    <div class="form-group col-md-6">                                    
                                        <label>Portrait</label>                                        
                                        <div class="input-group">
                                            <div class="custom-file">
                                                <input 
                                                    type="file"                                                     
                                                    accept="image/*"   
                                                    @change="handleFileUpload"
                                                    class="custom-file-input" 
                                                    id="exampleInputFile"
                                                    :class="{ 'is-invalid': formErrors.portrait, 'is-valid': form.portrait && !formErrors.portrait }"
                                                >
                                                <label class="custom-file-label" for="exampleInputFile">
                                                    {{ fileName || 'Choose file' }}
                                                </label>
                                            </div>
                                        </div>
                                        <div v-if="form.portrait && !formErrors.portrait" class="valid-feedback d-block">
                                                Portait looks good!
                                            </div>
                                        <InputError :message="formErrors.portrait" class="mt-1" />
                                        
                                    </div>  

                                </div>   
                                                                                                                             
                                <div class="row">
                                    <div class="form-group col-md-6">
                                        <label for="name">Password</label>
                                            <input  
                                                v-model="form.password"
                                                type="password" 
                                                class="form-control" id="password" 
                                                max="255" 
                                                :class="{
                                                    'is-invalid': formErrors.password,
                                                    'is-valid': form.password && !formErrors.password
                                                }"
                                                placeholder="Enter Password">
                                                <InputError :message="formErrors.password || form.errors.password" class="mt-2" />
                                            
                                                <!-- Success message -->
                                                <div v-if="form.password && !formErrors.password" class="valid-feedback d-block">
                                                    Strong password!
                                                </div>
                                    </div>

                                    <div class="form-group col-md-6">
                                        <label for="name">Confirm Password</label>
                                        <input  
                                            v-model="form.confirm_password"
                                            type="password" 
                                            class="form-control" id="paswword_confirmation" 
                                            max="255" 
                                            :class="{
                                                'is-invalid': formErrors.confirm_password,
                                                'is-valid': form.confirm_password && !formErrors.confirm_password
                                            }"
                                            placeholder="Confirm Password">
                                            <InputError :message="formErrors.confirm_password || form.errors.confirm_password" class="mt-2" />
                                            <div v-if="form.confirm_password && !formErrors.confirm_password" class="valid-feedback d-block">
                                                Password confirmation looks good!
                                            </div>
                                    </div>
                                </div>

                                
                                <label for="name">User Roles</label>
                                <div class="row">
                                    <div class="col-sm-12">    
                                        <div class="card card-info card-outline">    
                                            <div class="card-header">
                                                <h5 class="card-title">Assign Roles</h5>                                                                                       
                                            </div>            
                                            <div class="form-group d-flex flex-wrap card-body">                                                                                                                                                                                                         
                                                <div 
                                                    class="custom-control custom-checkbox mr-3 mb-2" 
                                                    v-for="(role, index) in roles" :key="role.id">
                                                    <input class="custom-control-input" 
                                                        :id="'role-' + role.id"
                                                        type="checkbox"                                               
                                                        v-model="selectedRoles"                                                
                                                        :value="role.name">
                                                    <label :for="'role-' + role.id" class="custom-control-label">{{ role.name}}</label>
                                                </div>
                                            </div>                                           
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
                                                <i class="fas fa-save"></i> Submit
                                            </span>
                                        </button> 
                                        <Link :href="route('users.index')" class="btn btn-default float-right">
                                            <i class="fas fa-window-close"></i> Cancel
                                        </Link>                
                                    </div>                                                                
                                </div>
                        </form>
=======
>>>>>>> 38f8373b61a9793faa640ae28cb592a362ddca11
                    </div>
                </div>
            </div>


            <div class="content">
                <div class="container-fluid">
                    <div class="d-flex justify-content-center align-items-center min-vh-60  bg-light">
                        <div class="row w-100 justify-content-center">
                            <div class="col-md-12">
                                <!-- general form elements -->
                                <div class="card card-info">
                                    <div class="card-header">
                                        <h3 class="card-title">Edit User</h3>
                                    </div>
                                    <!-- form start -->
                                    <form @submit.prevent="updateUser" method="post" enctype="multipart/form-data">
                                        <div class="col-md-2 mt-3 ml-3">
                                            <div class="card card-info card-outline">
                                                <div class="card-body box-profile">
                                                    <div class="text-center">
                                                        <img class="profile-user-img img-fluid img-circle"
                                                            style="width: 150px;" :src="user.portrait ?
                                                                `/storage/${user.portrait}`
                                                                : '/storage/portraits/avatar.png'" alt="User profile picture">
                                                    </div>
                                                    <h3 class="profile-username text-center">{{ user.name }}</h3>

                                                </div>
                                            </div>
                                        </div>

                                        <div class="card-body">
                                            <div class="row">
                                                <div class="form-group col-md-6">
                                                    <label for="name">Names</label>
                                                    <input v-model="form.name" type="text" class="form-control"
                                                        id="name" :class="{
                                                            'is-invalid': formErrors.name,
                                                            'is-valid': form.name && !formErrors.name
                                                        }" required maxlength="255" placeholder="Enter Name">
                                                    <InputError :message="formErrors.name || form.errors.name"
                                                        class="mt-2" />
                                                    <div v-if="form.name && !formErrors.name"
                                                        class="valid-feedback d-block">
                                                        Name looks good!
                                                    </div>
                                                </div>

                                                <div class="form-group col-md-6">
                                                    <label for="name">Email</label>
                                                    <input v-model="form.email" type="email" class="form-control"
                                                        id="email" :class="{
                                                            'is-invalid': formErrors.email,
                                                            'is-valid': form.email && !formErrors.email
                                                        }" required max="255" placeholder="Enter Email">
                                                    <InputError :message="formErrors.email || form.errors.email"
                                                        class="mt-2" />
                                                    <div v-if="form.email && !formErrors.email"
                                                        class="valid-feedback d-block">
                                                        Email looks good!
                                                    </div>
                                                </div>

                                            </div>
                                            <div class="row">
                                                <div class="form-group col-md-6">
                                                    <label for="nrc">NRC</label>
                                                    <input v-model="form.nrc" type="text" name="nrc" id="nrc"
                                                        class="form-control" :class="{
                                                            'is-invalid': formErrors.nrc,
                                                            'is-valid': form.nrc && !formErrors.nrc
                                                        }" required maxlength="12" placeholder="Enter NRC">

                                                    <!-- Error Display -->
                                                    <InputError :message="formErrors.nrc" class="mt-2" />

                                                    <!-- Success Feedback -->
                                                    <div v-if="form.nrc && !formErrors.nrc"
                                                        class="valid-feedback d-block">
                                                        NRC looks good!
                                                    </div>
                                                </div>

                                                <div class="form-group col-md-6">
                                                    <label>Gender</label>
                                                    <select required v-model="form.gender" class="form-control"
                                                        :class="{ 'is-invalid': formErrors.gender, 'is-valid': form.gender && !formErrors.gender }">
                                                        <option value="">-- Select Gender --</option>
                                                        <option v-for="item in genderOptions" :key="item" :value="item">
                                                            {{ item }}</option>
                                                    </select>
                                                    <InputError :message="formErrors.gender" class="mt-1" />
                                                    <div v-if="form.gender && !formErrors.gender"
                                                        class="valid-feedback d-block">
                                                        Gender looks good!
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="form-group col-md-6">
                                                    <label>Phone Number</label>
                                                    <input v-model="form.phone_number" type="text" required max="15"
                                                        class="form-control"
                                                        :class="{ 'is-invalid': formErrors.phone_number, 'is-valid': form.phone_number && !formErrors.phone_number }"
                                                        placeholder="Enter Phone Number">
                                                    <InputError :message="formErrors.phone_number" class="mt-1" />
                                                    <div v-if="form.phone_number && !formErrors.phone_number"
                                                        class="valid-feedback d-block">
                                                        Phone number looks good!
                                                    </div>
                                                </div>

                                                <div class="form-group col-md-6">
                                                    <label for="designation">Job Position</label>
                                                    <input v-model="form.designation" type="text" class="form-control"
                                                        id="designation" :class="{
                                                            'is-invalid': formErrors.designation,
                                                            'is-valid': form.designation && !formErrors.designation
                                                        }" required maxlength="255" placeholder="Enter Designation">
                                                    <InputError
                                                        :message="formErrors.designation || form.errors.designation"
                                                        class="mt-2" />
                                                    <div v-if="form.designation && !formErrors.designation"
                                                        class="valid-feedback d-block">
                                                        Job Position looks good!
                                                    </div>
                                                </div>
                                            </div>



                                            <div class="row">
                                                <div class="form-group col-md-6">
                                                    <div class="form-group">
                                                        <label>Department</label>
                                                        <select required v-model="form.department_id"
                                                            class="form-control"
                                                            :class="{ 'is-invalid': formErrors.department_id, 'is-valid': form.department_id && !formErrors.department_id }">
                                                            <option value="">-- Department --</option>
                                                            <option v-for="item in props.departments" :key="item"
                                                                :value="item.id">{{ item.name }}</option>
                                                        </select>
                                                        <div v-if="form.department_id && !formErrors.department_id"
                                                            class="valid-feedback d-block">
                                                            Department looks good!
                                                        </div>
                                                        <InputError :message="formErrors.department_id" class="mt-1" />
                                                    </div>
                                                </div>

                                                <div class="form-group col-md-6">
                                                    <label>Portrait</label>
                                                    <div class="input-group">
                                                        <div class="custom-file">
                                                            <input type="file" accept="image/*"
                                                                @change="handleFileUpload" class="custom-file-input"
                                                                id="exampleInputFile"
                                                                :class="{ 'is-invalid': formErrors.portrait, 'is-valid': form.portrait && !formErrors.portrait }">
                                                            <label class="custom-file-label" for="exampleInputFile">
                                                                {{ fileName || 'Choose file' }}
                                                            </label>
                                                        </div>
                                                    </div>
                                                    <div v-if="form.portrait && !formErrors.portrait"
                                                        class="valid-feedback d-block">
                                                        Portait looks good!
                                                    </div>
                                                    <InputError :message="formErrors.portrait" class="mt-1" />

                                                </div>

                                            </div>

                                            <div class="row">
                                                <div class="form-group col-md-6">
                                                    <label for="name">Password</label>
                                                    <input v-model="form.password" type="password" class="form-control"
                                                        id="password" max="255" :class="{
                                                            'is-invalid': formErrors.password,
                                                            'is-valid': form.password && !formErrors.password
                                                        }" placeholder="Enter Password">
                                                    <InputError :message="formErrors.password || form.errors.password"
                                                        class="mt-2" />

                                                    <!-- Success message -->
                                                    <div v-if="form.password && !formErrors.password"
                                                        class="valid-feedback d-block">
                                                        Strong password!
                                                    </div>
                                                </div>

                                                <div class="form-group col-md-6">
                                                    <label for="name">Confirm Password</label>
                                                    <input v-model="form.confirm_password" type="password"
                                                        class="form-control" id="paswword_confirmation" max="255"
                                                        :class="{
                                                            'is-invalid': formErrors.confirm_password,
                                                            'is-valid': form.confirm_password && !formErrors.confirm_password
                                                        }" placeholder="Confirm Password">
                                                    <InputError
                                                        :message="formErrors.confirm_password || form.errors.confirm_password"
                                                        class="mt-2" />
                                                    <div v-if="form.confirm_password && !formErrors.confirm_password"
                                                        class="valid-feedback d-block">
                                                        Password confirmation looks good!
                                                    </div>
                                                </div>
                                            </div>


                                            <label for="name">User Roles</label>
                                            <div class="row">
                                                <div class="col-sm-12">
                                                    <div class="card card-info card-outline">
                                                        <div class="card-header">
                                                            <h5 class="card-title">Assign Roles</h5>
                                                        </div>
                                                        <div class="form-group d-flex flex-wrap card-body">
                                                            <div class="custom-control custom-checkbox mr-3 mb-2"
                                                                v-for="(role, index) in roles" :key="role.id">
                                                                <input class="custom-control-input"
                                                                    :id="'role-' + role.id" type="checkbox"
                                                                    v-model="selectedRoles" :value="role.name">
                                                                <label :for="'role-' + role.id"
                                                                    class="custom-control-label">{{ role.name }}</label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>

                                        <div class="card-footer">
                                            <div class="d-flex ">
                                                <button :disabled="isLoading" :class="{ 'opacity-25': isLoading }"
                                                    type="submit" class="btn btn-info ml-auto mr-2">
                                                    <span v-if="isLoading">
                                                        <i class="fas fa-spinner fa-spin"></i> Processing...
                                                    </span>
                                                    <span v-else>
                                                        <i class="fas fa-save"></i> Submit
                                                    </span>
                                                </button>
                                                <Link :href="route('users.index')" class="btn btn-default float-right">
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
    </AuthenticatedLayout>
</template>

<style>
.content-wrapper {
    font-family: 'Poppins', 'Segoe UI', sans-serif;
}
</style>
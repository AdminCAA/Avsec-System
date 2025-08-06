
<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import { Head,Link, useForm } from '@inertiajs/vue3';

import Swal from 'sweetalert2';
import 'sweetalert2/dist/sweetalert2.min.css';
import InputError from '@/Components/InputError.vue';
import { router } from '@inertiajs/vue3';
import { ref, watch } from 'vue';

const props =defineProps({
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
    departments:{
        type:Object,
        required:true
    }
});



const formErrors = ref({
  name: '',
  email: '',
  department_id:'',
  password: '',
  confirm_password: ''
});


const form = useForm({
    name:props.user.name,    
    email: props.user.email,
    department_id: props.user.department_id,
    password:"",
    confirm_password:""
});

const isLoading = ref(false);
//Create the user permission
// and redirect to the permissions index page
const selectedRoles = ref([]); // This will hold the selected permission IDs
selectedRoles.value = props.userRoles;
const errorMessage = ref('');

function updateUser() {
    isLoading.value = true;
    axios.post(route('users.update',props.user.id), {
        name: form.name, // assuming you're using reactive `form` or `ref()`
        email: form.email, // assuming you're using reactive `form` or `ref()`
        department_id: form.department_id, // assuming you're using reactive `form` or `ref()`
        roles: selectedRoles.value // Get the selected permission IDs
    })
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
                <li class="breadcrumb-item"><Link class="btn btn-info" :href="route('users.index')"><i class="fas fa-arrow-left"></i> Back</Link></li>
            </ol>
          </div>
        </div>
      </div>
    </div>
   

    <div class="content">
      <div class="container-fluid">
        <div class="d-flex justify-content-center align-items-center min-vh-60  bg-light">
            <div class="row w-100 justify-content-center">
                <div class="col-md-6">                    
                    <!-- general form elements -->
                    <div class="card card-info">
                        <div class="card-header">
                            <h3 class="card-title">Edit User</h3>
                        </div>
                        <!-- form start -->
                        <form @submit.prevent="updateUser" method="post">
                            <div class="card-body">
                                <div class="form-group">
                                    <label for="name">Name</label>
                                    <input  
                                        v-model="form.name"
                                        type="name" 
                                        class="form-control" id="name" 
                                        :class="{
                                            'is-invalid': formErrors.name,
                                            'is-valid': form.name && !formErrors.name
                                        }"
                                        required max="255" 
                                        placeholder="Enter Name">
                                        <InputError :message="formErrors.name || form.errors.name" class="mt-2" />
                                        <div v-if="form.name && !formErrors.name" class="valid-feedback d-block">
                                            Name looks good!
                                        </div>
                                </div>

                                <div class="form-group">
                                    <label for="name">Email</label>
                                    <input  
                                        v-model="form.email"
                                        type="email" 
                                        class="form-control" id="email" 
                                        :class="{
                                            'is-invalid': formErrors.email,
                                            'is-valid': form.email && !formErrors.email
                                        }"
                                        max="255" 
                                        placeholder="Enter Email">
                                        <InputError :message="formErrors.email || form.errors.email" class="mt-2" />
                                        <div v-if="form.email && !formErrors.email" class="valid-feedback d-block">
                                            Email looks good!
                                        </div>
                                </div>

                                <div class="form-group">
                                    <label>Department</label>
                                    <select required v-model="form.department_id" class="form-control"
                                        :class="{ 'is-invalid': formErrors.department_id, 'is-valid': form.department_id && !formErrors.department_id }"
                                    >
                                        <option value="">-- Department --</option>
                                        <option v-for="item in props.departments" :key="item" :value="item.id">{{ item.name }}</option>
                                    </select>
                                    <InputError :message="formErrors.status" class="mt-1" />
                                </div>


                                <div class="form-group">
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

                                <div class="form-group">
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
                                        class="btn btn-info ml-auto mr-2"
                                    >
                                        <span v-if="isLoading">
                                            <i class="fas fa-spinner fa-spin"></i> Processing...
                                        </span>
                                        <span v-else>
                                            <i class="fas fa-save"></i> Save
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

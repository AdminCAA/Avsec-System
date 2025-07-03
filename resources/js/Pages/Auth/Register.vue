<script setup>
import GuestLayout from '@/Layouts/GuestLayout.vue';
import InputError from '@/Components/InputError.vue';
import { Head, Link, useForm } from '@inertiajs/vue3';
import { watch,ref } from 'vue';

const form = useForm({
    name: '',
    email: '',
    password: '',
    password_confirmation: '',
});

const submit = () => {
    form.post(route('register'), {
        //onFinish: () => form.reset('password', 'password_confirmation'),
    });
};

const nameError = ref('');
const emailError = ref('');
const passwordError = ref('');
const confirm_passwordError = ref('');

//Real-time email validation
watch(() => form.email, (value) => {
    emailError.value = '';
    if (!value) {
        emailError.value = 'Email is required.';
    } else if (!/^\S+@\S+\.\S+$/.test(value)) {
        emailError.value = 'Enter a valid email address.';
    }
});


//Real-time password validation
watch(() => form.password, (value) => {
    passwordError.value = '';
    if (!value) {
        passwordError.value = 'Email is required.';}
    if (value.length < 8) {
        passwordError.value = "Password must be at least 8 characters.";
    } else if (!/[A-Z]/.test(value)) {
        passwordError.value = "Add at least one uppercase letter.";
    } else if (!/[a-z]/.test(value)) {
        passwordError.value = "Add at least one lowercase letter.";
    } else if (!/[0-9]/.test(value)) {
        passwordError.value = "Add at least one number.";
    } else if (!/[!@#$%^&*(),.?\":{}|<>]/.test(value)) {
        passwordError.value = "Add at least one special character.";
    } else if (value !== form.password_confirmation) {
        passwordError.value = 'Passwords do not match.';        
    }
});
// // Real-time password confirmation validation
    watch(()=>form.password_confirmation,(value)=>{
        if(!value){
            password_confirmation.value = 'Password confirmation is required.';
        }        
        if(value === form.password){
            passwordError.value = '';
        }
    })



watch(()=> form.name, (value)=>{
    nameError.value = '';
    if (!value) {
        nameError.value = 'Name is required.';
    } else if (value.length < 3) {
        nameError.value = 'Name must be at least 3 characters.';
    }
    else if (value.length > 50) {
        nameError.value = 'Name must be less than 50 characters.';
    }    
})



</script>

<template>
    <GuestLayout>
        <Head title="Register" />
        <div class="register-box mt-10">  
  
        <div class="card card-info">
            <div class="card-header">
                <h2 class="card-title">Register</h2>
            </div>
            <div class="card-body register-card-body">      
                    <form @submit.prevent="submit">                           
                        <div class="input-group mb-3">
                            <input
                                id="name"
                                type="text"
                                class="form-control"
                                :class="{
                                    'is-invalid': nameError,
                                    'is-valid': form.name && !nameError
                                }"   
                                v-model="form.name"
                                required
                                min="3"
                                autofocus
                                placeholder="Full Name"
                                name="name"
                                autocomplete="name"
                            />
                            <div class="input-group-append">
                                <div class="input-group-text">
                                    <span class="fas fa-user"></span>
                                </div>
                            </div>
                            <div style="width:100%" v-if="nameError" class="text-danger text-sm mb-3">
                                {{ nameError }}
                            </div>
                            <div v-if="form.name && !nameError" class="valid-feedback d-block">
                                Name looks good!
                            </div>
                        </div>                            
                    
                        <div class="input-group mb-3">
                            <input
                                id="email"
                                type="email"
                                class="form-control"
                                :class="{
                                    'is-invalid': emailError,
                                    'is-valid': form.email && !emailError
                                }" 
                                v-model="form.email"
                                required
                                autocomplete="username"
                                placeholder="Email"
                                name="email"
                            />
                            <div class="input-group-append">
                                <div class="input-group-text">
                                    <span class="fas fa-envelope"></span>
                                </div>
                            </div>

                            <div style="width:100%" v-if="emailError" class="text-danger text-sm mb-3">
                                {{ emailError }}
                            </div>
                            <div v-if="form.email && !emailError" class="valid-feedback d-block">
                                Email looks good!
                            </div>
                        </div>

                        <div class="input-group mb-3">
                            <input type="password" 
                                class="form-control" 
                                :class="{
                                    'is-invalid': passwordError,
                                    'is-valid': form.password && !passwordError
                                }" 
                                placeholder="Password" 
                                id="password"  
                                v-model="form.password"
                                required
                                min="6"
                                autocomplete="new-password"
                            >
                            <div class="input-group-append">
                                <div class="input-group-text">
                                <span class="fas fa-lock"></span>
                                </div>
                            </div>  
                            <div style="width:100%" v-if="passwordError" class="text-danger text-sm mb-3">
                                {{ passwordError }}
                            </div>
                            <div v-if="form.password && !passwordError" class="valid-feedback d-block">
                                Password looks good!
                            </div>                           
                        </div>

                        <div class="input-group mb-3">
                            <input type="password" 
                                class="form-control" 
                                placeholder="Confirm password"
                                id="password_confirmation" 
                                name="password_confirmation"   
                                                                  
                                v-model="form.password_confirmation"
                                :class="{
                                    'is-invalid': form.password !== form.password_confirmation,
                                    'is-valid': form.password_confirmation && !confirm_passwordError
                                }" 
                                required
                                autocomplete="new-password"
                                >
                            <div class="input-group-append">
                                <div class="input-group-text">
                                <span class="fas fa-lock"></span>
                                </div>
                            </div>
                            <div style="width:100%" v-if="form.errors.password_confirmation" class="text-danger text-sm mb-3">
                                {{ form.errors.password_confirmation }}
                            </div> 
                        </div>
                        <div class="row">
                            <div class="col-6">
                                <Link
                                    :href="route('login')"
                                    class="rounded-md text-sm text-gray-600 underline hover:text-gray-900 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2"
                                >
                                    Already registered?
                                </Link>
                            </div>
                            
                            <div class="col-6 d-flex">
                                
                                <button
                                    type="submit"
                                    class="btn btn-info btn-block ml-auto mr-2"
                                    :disabled="form.processing"
                                    :class="{ 'opacity-25': form.processing }"
                                >
                                    
                                    <span v-if="form.processing">
                                            <i class="fas fa-spinner fa-spin"></i> Wait..
                                        </span>
                                        <span v-else>
                                            Register
                                    </span>                
                                </button> 

                                <Link :href="route('welcome')" class="btn btn-default float-right">
                                    Cancel
                                </Link>                
                            </div>
                        </div>                
                    </form>
                </div>
            </div>  
        </div>
    </GuestLayout>

</template>
<style scoped>
    .register-box {
        width: auto !important;
        margin-top: 50px;        
        border-radius: 10px; 
        overflow: hidden; 
    }

    label:not(.form-check-label):not(.custom-file-label) {
        font-weight: 400 !important;
    }

    .btn-block {
        display: block;
        width: 60% !important;
    }

    input.is-invalid {
        border-color: #dc3545;
    }
</style>

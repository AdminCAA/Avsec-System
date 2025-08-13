<script setup>
import Checkbox from '@/Components/Checkbox.vue';
import GuestLayout from '@/Layouts/GuestLayout.vue';
import InputError from '@/Components/InputError.vue';
import InputLabel from '@/Components/InputLabel.vue';
import PrimaryButton from '@/Components/PrimaryButton.vue';
import TextInput from '@/Components/TextInput.vue';
import { ref, watch } from 'vue';
import { Head, Link, useForm } from '@inertiajs/vue3';
import { usePage, router } from '@inertiajs/vue3';

defineProps({
    canResetPassword: {
        type: Boolean,
    },
    status: {
        type: String,
    },
});

const form = useForm({
    email: '',
    password: '',
    remember: false,
});

const submit = () => {
    form.post(route('login'), {
        onFinish: () => form.reset('password'),
    });
};




const emailError = ref('');
const passwordError = ref('');


// Real-time email validation
watch(() => form.email, (value) => {
    emailError.value = '';
    if (!value) {
        emailError.value = 'Email is required.';
    } else if (!/^\S+@\S+\.\S+$/.test(value)) {
        emailError.value = 'Enter a valid email address.';
    }
});


// Real-time password validation
watch(() => form.password, (value) => {
    passwordError.value = '';
    if (!value) {
        passwordError.value = 'Password is required.';
    } else if (value.length < 6) {
        passwordError.value = 'Password must be at least 6 characters.';
    }
});


</script>

<template>
    <GuestLayout>
        <Head title="Sign in" />
        <div v-if="status" class="mb-3 text-success fw-medium">
            {{ status }}
        </div>
<!-- /.login-box -->

<div class="login-box mt-10">  
  <!-- /.login-logo -->
  <div class="card card-info">
    <div class="card-header">
                <h2 class="card-title">Sign in</h2>
              </div>
    <div class="card-body login-card-body">
      

      <form @submit.prevent="submit" method="post">
        <div class="input-group mb-3">
          <input 
            type="email"             
            placeholder="Email"
            id="email"
            name="email"            
           
            :class="[
                'form-control',
                emailError ? 'is-invalid' : '',
                form.email && !emailError ? 'is-valid' : ''
            ]"
            v-model="form.email"            
            autofocus
            autocomplete="username">
            
          <div class="input-group-append">
            <div class="input-group-text">
              <span class="fas fa-envelope"></span>
            </div>
          </div>

          <div style="width:100%" v-if="emailError" class="text-danger text-sm mb-3">
                {{ emailError }}
          </div>
          <div style="width:100%" v-if="form.errors.email" class="text-danger text-sm mb-3">
                {{ form.errors.email }}
            </div>
          <div v-if="form.email && !emailError" class="valid-feedback d-block">
              Email looks good!
          </div>
        </div>

        <div class="input-group mb-3">
          <input 
                type="password" 
                class="form-control mt-auto" 
                placeholder="Password"
                id="password"
                name="password"    
                :class="{
                  'is-invalid': passwordError,
                  'is-valid': form.password && !passwordError
                }"                                    
                v-model="form.password"                
                autocomplete="current-password">
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
            <div style="width:100%" v-if="form.errors.password" class="text-danger text-sm mb-3">
                {{ form.errors.password }}
            </div>
        </div>
        <div class="row">
          <div class="col-6">
              <div class="form-group">                
                <div class="custom-control custom-checkbox">
                    <input class="custom-control-input" 
                    type="checkbox"                                     
                    id="remember"
                    name="remember" v-model="form.remember"
                    />
                    <label for="customCheckbox1" class="custom-control-label">Remember Me</label>
                </div>
            </div>            
          </div>
          <!-- /.col -->
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
                    Submit
                  </span>
                </button> 

                <Link :href="route('welcome')" class="btn btn-warning float-right">Cancel</Link>
            </div>
          <!-- /.col -->
        </div>
      </form>

      <!-- <div class="social-auth-links text-center mb-3">
        <p>- OR -</p>
        <a href="#" class="btn btn-block btn-primary">
          <i class="fab fa-facebook mr-2"></i> Sign in using Facebook
        </a>
        <a href="#" class="btn btn-block btn-danger">
          <i class="fab fa-google-plus mr-2"></i> Sign in using Google+
        </a>
      </div> -->
      <!-- /.social-auth-links -->

        <p>
            <Link
            v-if="canResetPassword"
            :href="route('password.request')"
            class="mb-1 rounded-md text-sm text-gray-600 underline hover:text-gray-900 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2"
        >
            Forgot your password?
        </Link>
        </p>
       

      <p class="mb-0">
        <Link :href="route('register')" class="text-center">Register now</Link>
      </p>
    </div>
    <!-- /.login-card-body -->
  </div>
</div>

    </GuestLayout>
</template>
<style scoped>
    .login-box {
        width: auto !important;
        margin-top: 50px;
        width: auto !important;    
        border-radius: 10px; 
        overflow: hidden; 
    }

    label:not(.form-check-label):not(.custom-file-label) {
        font-weight: 400 !important;
    }

    .btn-block {
        display: block;
        width: 50% !important;
    }

    input.is-invalid {
        border-color: #dc3545;
    }
</style>

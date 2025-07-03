<script setup>
import GuestLayout from '@/Layouts/GuestLayout.vue';
import { Head,Link, useForm } from '@inertiajs/vue3';

defineProps({
    status: {
        type: String,
    },
});

const form = useForm({
    email: '',
});

const submit = () => {
    form.post(route('password.email'));
};
</script>

<template>
    <GuestLayout>
        <Head title="Forgot Password" />
        <div class="register-box mt-10">  
  
  <div class="card card-info">
      <div class="card-header">
          <h2 class="card-title">Forgot Password</h2>
      </div>
      <div class="card-body register-card-body">     
        <div class="mb-4 text-sm text-gray-600">
            <p>Forgot your password? No problem. Just let us know your email
            address and we will email you a password reset link that will allow
            you to choose a new one.</p>
        </div>

        <div
            v-if="status"
            class="mb-4 text-sm font-medium text-green-600"
        >
            {{ status }}
        </div>

        <form @submit.prevent="submit">
            <div class="input-group mb-3">               
                <input
                    id="email"
                    type="email"
                    class="form-control"
                    v-model="form.email"
                    name="email"
                    :class="{ 'is-invalid': form.errors.email }"
                    placeholder="Email"
                    required
                    autofocus
                    autocomplete="username"
                />
                <div class="input-group-append">
                    <div class="input-group-text">
                        <span class="fas fa-envelope"></span>
                    </div>
                </div>
                <div style="width:100%" v-if="form.errors.email" class="text-danger text-sm mb-3">
                    {{ form.errors.email }}
                </div>
            </div>

            <div class="row">
                <div class="col-2"></div>
            <div class="col-10 d-flex ">
                <button
                    type="submit"
                    class="btn btn-info btn-block ml-auto mr-2"
                    :class="{ 'opacity-25': form.processing }"
                    :disabled="form.processing"
                >
                    Email Password Reset Link
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
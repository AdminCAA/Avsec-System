<script setup>
import GuestLayout from '@/Layouts/GuestLayout.vue';
import InputError from '@/Components/InputError.vue';
import InputLabel from '@/Components/InputLabel.vue';
import PrimaryButton from '@/Components/PrimaryButton.vue';
import TextInput from '@/Components/TextInput.vue';
import { Head, useForm } from '@inertiajs/vue3';

const props = defineProps({   
    email: {
        type: String,
        required: true,
    },
    token: {
        type: String,
        required: true,
    },
});

const form = useForm({
    token: props.token,
    email: props.email,
    password: '',
    password_confirmation: '',
});

const submit = () => {
    form.post(route('password.update'), {
        onFinish: () => form.reset('password', 'password_confirmation'),
    });
};


</script>

<template>
    <GuestLayout>
        <Head title="Reset Password" />

        <div class="card card-info mt-5">
            <div class="card-header">
                <h3 class="card-title">Reset Password</h3>
            </div>
            <div class="card-body">
                <form @submit.prevent="submit">
                    <!-- Token -->
                    <input type="hidden" name="token" v-model="form.token" />

                    <!-- Email -->
                    <div class="form-group mb-3">
                        <label for="email">Email</label>
                        <input
                            id="email"
                            type="email"
                            class="form-control"
                            v-model="form.email"                            
                            autofocus
                            autocomplete="username"
                            :class="{ 'is-invalid': form.errors.email }"
                        />
                        <div v-if="form.errors.email" class="invalid-feedback">
                            {{ form.errors.email }}
                        </div>
                    </div>

                    <!-- Password -->
                    <div class="form-group mb-3">
                        <label for="password">Password</label>
                        <input
                            id="password"
                            type="password"
                            class="form-control"
                            v-model="form.password"                            
                            autocomplete="new-password"
                            :class="{ 'is-invalid': form.errors.password }"
                        />
                        <div v-if="form.errors.password" class="invalid-feedback">
                            {{ form.errors.password }}
                        </div>
                    </div>

                    <!-- Confirm Password -->
                    <div class="form-group mb-3">
                        <label for="password_confirmation">Confirm Password</label>
                        <input
                            id="password_confirmation"
                            type="password"
                            class="form-control"
                            v-model="form.password_confirmation"                            
                            autocomplete="new-password"
                            :class="{ 'is-invalid': form.errors.password_confirmation }"
                        />
                        <div v-if="form.errors.password_confirmation" class="invalid-feedback">
                            {{ form.errors.password_confirmation }}
                        </div>
                    </div>

                    <!-- Submit -->
                    <div class="d-flex justify-content-end">
                        <button
                            type="submit"
                            class="btn btn-info"
                            :disabled="form.processing"
                        >
                            <span v-if="form.processing">
                                <i class="fas fa-spinner fa-spin"></i> Wait..
                            </span>
                            <span v-else>
                                Reset Password
                            </span>                            
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </GuestLayout>
</template>


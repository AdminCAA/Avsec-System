<script setup>
import GuestLayout from '@/Layouts/GuestLayout.vue';
import InputError from '@/Components/InputError.vue';
import InputLabel from '@/Components/InputLabel.vue';
import PrimaryButton from '@/Components/PrimaryButton.vue';
import TextInput from '@/Components/TextInput.vue';
import { Head, useForm,Link, usePage } from '@inertiajs/vue3';
import { ref } from 'vue';



const form = useForm({
    code: '',
    recovery_code: '',
});


const recovery = ref(usePage().props.recovery || false);

const submit = () => {
    form.post(route('two-factor.login'), {
        onFinish: () => form.reset(),
    });
};
</script>

<template>
    <GuestLayout>
        <Head title="Two Factor Challenge" />

        <div class="card card-info mt-5">
            <div class="card-header">
                <h3 class="card-title">Two Factor Challenge</h3>
            </div>
            <div class="card-body">

                <div v-if="!recovery" class="mb-4 text-secondary">
                    Please confirm access to your account by entering the authentication code provided by your authenticator app.
                </div>
                <div v-else class="mb-4 text-secondary">
                    Please confirm access to your account by entering one of your recovery codes provided by 2FA.
                </div>

                <form @submit.prevent="submit">
                    <div v-if="!recovery" class="mb-3">
                        <div class="mb-3">
                        <label for="code" class="form-label">Code</label>
                        <input
                            id="code"
                            type="password"
                            inputmode="numeric"
                            class="form-control"
                            v-model="form.code"                            
                            autocomplete="one-time-code"
                            placeholder="Enter your two-factor authentication code"
                            autofocus
                            :class="{ 'is-invalid': form.errors.code }"
                        />
                        <div v-if="form.errors.code" class="invalid-feedback">
                            {{ form.errors.code }}
                        </div>
                        </div>
                    </div>
                    <div v-else>
                        <div class="mb-3">
                        <label for="recovery_code" class="form-label">Recovery Code</label>
                        <input
                            id="recovery_code"
                            type="password"                            
                            class="form-control"
                            v-model="form.recovery_code"                            
                            autocomplete="one-time-code"
                            placeholder="Enter your recovery code"
                            autofocus
                            :class="{ 'is-invalid': form.errors.recovery_code }"
                        />
                        <div v-if="form.errors.recovery_code" class="invalid-feedback">
                            {{ form.errors.recovery_code }}
                        </div>
                        </div>
                    </div>

                    <div class="justify-content-start">
                        <Link  v-if="!recovery"                               
                                :href="route('two-factor.login', {'recovery': true})"
                                class="mb-1 rounded-md text-sm text-gray-600 underline hover:text-gray-900 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2"
                            >
                                Use Recovery Code
                        </Link>
                        <Link v-else
                                :href="route('two-factor.login')"
                                class="mb-1 rounded-md text-sm text-gray-600 underline hover:text-gray-900 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2"
                            >
                                Use Authentication Code
                        </Link>
                    </div>

                    <div class="d-flex justify-content-end">                                                                      
                        <button
                            type="submit"
                            class="btn btn-info ms-3"
                            :class="{ 'disabled opacity-50': form.processing }"
                            :disabled="form.processing"
                        >
                            <span v-if="form.processing">
                                <i class="fas fa-spinner fa-spin"></i> Wait..
                            </span>
                            <span v-else>
                                Login
                            </span>                            
                        </button>
                    </div>
                </form>

            </div>
        </div>
    </GuestLayout>
</template>


<script setup>
import GuestLayout from '@/Layouts/GuestLayout.vue';
import { Head, useForm,Link } from '@inertiajs/vue3';


const form = useForm({
    password: '',
});

const submit = () => {
    form.post(route('password.confirm'), {
        onFinish: () => form.reset(),
    });
};
</script>

<template>
    <GuestLayout>
        <Head title="Confirm Password" />

        <div class="card card-info mt-5">
            <div class="card-header">
                <h3 class="card-title">Confirm Password</h3>
            </div>
            <div class="card-body">

                <div class="mb-4 text-secondary">
                    This is a secure area of the application. Please confirm your
                    password before continuing.
                </div>

                <form @submit.prevent="submit">
                    <div class="mb-3">
                        <label for="password" class="form-label">Password</label>
                        <input
                            id="password"
                            type="password"
                            class="form-control"
                            v-model="form.password"                            
                            autocomplete="current-password"
                            autofocus
                            :class="{ 'is-invalid': form.errors.password }"
                        />
                        <div v-if="form.errors.password" class="invalid-feedback">
                            {{ form.errors.password }}
                        </div>
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
                                Confirm
                            </span>                          
                        </button>

                        <Link
                            :href="route('profile.edit')"
                            class="btn btn-warning ml-2 ms-3"
                            
                        >
                            Cancel
                    </Link>
                    </div>
                </form>

            </div>
        </div>
    </GuestLayout>
</template>
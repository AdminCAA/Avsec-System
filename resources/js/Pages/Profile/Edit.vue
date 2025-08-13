<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import DeleteUserForm from './Partials/DeleteUserForm.vue';
import UpdatePasswordForm from './Partials/UpdatePasswordForm.vue';
import UpdateProfileInformationForm from './Partials/UpdateProfileInformationForm.vue';
import { Head } from '@inertiajs/vue3';
import TwoFactorAuthentication from './Partials/TwoFactorAuthentication.vue';

defineProps({
    mustVerifyEmail: {
        type: Boolean,
    },
    status: {
        type: String,
    },
});
</script>

<template>
    <Head title="Profile" />

    <AuthenticatedLayout>
        <template #header>
            <h2 class="h4 fw-semibold text-dark">
                Profile
            </h2>
        </template>

        <div class="py-5">
            <div class="container">
                <div class="row ml-4 g-4">

                    <!-- Update Profile Information -->
                    <div class="col-12">
                        <div class="card shadow-sm">
                            <div class="card-header">
                                <h4 class="mb-0">Update and Secure Profile Information</h4>
                            </div>
                            <div class="card-body p-4">
                                <UpdateProfileInformationForm
                                    :must-verify-email="mustVerifyEmail"
                                    :status="status"
                                    class="w-100"
                                />
                            </div>
                        </div>
                    </div>

                    <!-- Two Factor Authentication -->
                    <div class="col-12">
                        <div class="card shadow-sm">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Two Factor Authentication</h5>
                            </div>
                            <div class="card-body p-4">
                                <TwoFactorAuthentication
                                    :must-verify-email="mustVerifyEmail"
                                    :status="status"
                                    class="w-100"
                                />
                            </div>
                        </div>
                    </div>

                    <!-- Update Password -->
                    <div class="col-12">
                        <div class="card shadow-sm">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Update Password</h5>
                            </div>
                            <div class="card-body p-4">
                                <UpdatePasswordForm class="w-100" />
                            </div>
                        </div>
                    </div>

                    <!-- Delete User -->
                    <div class="col-12">
                        <div class="card shadow-sm">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Delete User</h5>
                            </div>
                            <div class="card-body p-4">
                                <DeleteUserForm class="w-100" />
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </AuthenticatedLayout>
</template>


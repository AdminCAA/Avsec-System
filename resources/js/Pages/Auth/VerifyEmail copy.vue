<script setup>
import { computed } from 'vue';
import GuestLayout from '@/Layouts/GuestLayout.vue';
import PrimaryButton from '@/Components/PrimaryButton.vue';
import { Head, Link, useForm } from '@inertiajs/vue3';

const props = defineProps({
    status: {
        type: String,
    },
});

const form = useForm({});

const submit = () => {
    form.post(route('verification.send'));
};

const verificationLinkSent = computed(
    () => props.status === 'verification-link-sent',
);
</script>

<template>
    <GuestLayout>
        <Head title="Email Verification" />

        <div class="card card-info mt-5">
            <div class="card-header">
                <h3 class="card-title">Email Verification</h3>
            </div>
            <div class="card-body">
                <!-- Intro message -->
                <div class="mb-3 text-muted">
                    Thanks for signing up! Before getting started, could you verify your
                    email address by clicking on the link we just emailed to you? If you
                    didn't receive the email, we will gladly send you another.
                </div>

                <!-- Success message -->
                <div 
                    v-if="verificationLinkSent" 
                    class="alert alert-success py-2"
                >
                    A new verification link has been sent to the email address you
                    provided during registration.
                </div>

                <!-- Form -->
                <form @submit.prevent="submit">
                    <div class="d-flex justify-content-between align-items-center mt-4">
                        <button 
                            type="submit" 
                            class="btn btn-info"
                            :disabled="form.processing"
                            :class="{ 'opacity-25': form.processing }"
                        >
                            <span v-if="form.processing">
                                <i class="fas fa-spinner fa-spin"></i> Sending...
                            </span>
                            <span v-else>
                                Resend Verification Email
                            </span>                            
                        </button>

                        <Link 
                            :href="route('logout')" 
                            method="post" 
                            as="button" 
                            class="btn btn-outline-secondary"
                        >
                            Log Out
                        </Link>
                    </div>
                </form>
            </div>
        </div>
    </GuestLayout>
</template>


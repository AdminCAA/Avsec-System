<script setup>
import InputError from '@/Components/InputError.vue';
import InputLabel from '@/Components/InputLabel.vue';
import PrimaryButton from '@/Components/PrimaryButton.vue';
import TextInput from '@/Components/TextInput.vue';
import { useForm } from '@inertiajs/vue3';
import { ref } from 'vue';

const passwordInput = ref(null);
const currentPasswordInput = ref(null);

const form = useForm({
    current_password: '',
    password: '',
    password_confirmation: '',
});

const updatePassword = () => {
    form.put(route('user-password.update'), {
        preserveScroll: true,
        onSuccess: () => form.reset(),
        onError: () => {
            if (form.errors.password) {
                form.reset('password', 'password_confirmation');
                passwordInput.value.focus();
            }
            if (form.errors.current_password) {
                form.reset('current_password');
                currentPasswordInput.value.focus();
            }
        },
    });
};
</script>
<template>
    <section>
        <div class="card card-info mt-5">
            <div class="card-header">
                <h3 class="card-title">Update Password</h3>
            </div>
            <div class="card-body">
                <header class="mb-3">
                    <h2 class="h5 fw-medium text-dark mb-1">
                        Update Password
                    </h2>

                    <p class="small text-muted mb-0">
                        Ensure your account is using a long, random password to stay secure.
                    </p>
                </header>

                <form @submit.prevent="updatePassword" class="mt-4">
                    <!-- Current Password -->
                    <div class="mb-3">
                        <InputLabel for="current_password" value="Current Password" />

                        <TextInput
                            id="current_password"
                            ref="currentPasswordInput"
                            v-model="form.current_password"
                            type="password"
                            class="form-control mt-1"
                            autocomplete="current-password"
                        />

                        <InputError :message="form.errors.updatePassword?.current_password" class="text-danger small mt-1" />
                    </div>

                    <!-- New Password -->
                    <div class="mb-3">
                        <InputLabel for="password" value="New Password" />

                        <TextInput
                            id="password"
                            ref="passwordInput"
                            v-model="form.password"
                            type="password"
                            class="form-control mt-1"
                            autocomplete="new-password"
                        />

                        <InputError :message="form.errors.updatePassword?.password" class="text-danger small mt-1" />
                    </div>

                    <!-- Confirm Password -->
                    <div class="mb-3">
                        <InputLabel for="password_confirmation" value="Confirm Password" />

                        <TextInput
                            id="password_confirmation"
                            v-model="form.password_confirmation"
                            type="password"
                            class="form-control mt-1"
                            autocomplete="new-password"
                        />

                        <InputError :message="form.errors.updatePassword?.password_confirmation" class="text-danger small mt-1" />
                    </div>

                    <!-- Actions -->
                    <div class="d-flex align-items-center gap-3">
                        <button :disabled="form.processing"  class="btn btn-info"
                            :class="{ 'disabled opacity-50': form.processing }" 
                            @click="updatePassword"                           
                        >                          
                           <span v-if="form.processing">
                                  <i class="fas fa-spinner fa-spin"></i> Saving...
                                </span>
                                <span v-else>
                                  <i class="fas fa-save" ></i> Save
                            </span>  
                        </button>
                        <Transition enter-active-class="fade show" leave-active-class="fade">
                            <p v-if="form.recentlySuccessful" class="small text-muted mb-0">
                                Saved.
                            </p>
                        </Transition>
                    </div>
                </form>
            </div>
        </div>
    </section>
</template>

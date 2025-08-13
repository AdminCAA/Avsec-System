<script setup>
import DangerButton from '@/Components/DangerButton.vue';
import InputError from '@/Components/InputError.vue';
import InputLabel from '@/Components/InputLabel.vue';
import Modal from '@/Components/Modal.vue';
import SecondaryButton from '@/Components/SecondaryButton.vue';
import TextInput from '@/Components/TextInput.vue';
import { useForm } from '@inertiajs/vue3';
import { nextTick, ref } from 'vue';

const confirmingUserDeletion = ref(false);
const passwordInput = ref(null);

const form = useForm({
    password: '',
});

const confirmUserDeletion = () => {
    confirmingUserDeletion.value = true;

    nextTick(() => passwordInput.value.focus());
};

const deleteUser = () => {
    form.delete(route('profile.destroy'), {
        preserveScroll: true,
        onSuccess: () => closeModal(),
        onError: () => passwordInput.value.focus(),
        onFinish: () => form.reset(),
    });
};

const closeModal = () => {
    confirmingUserDeletion.value = false;

    form.clearErrors();
    form.reset();
};
</script>

<template>
    <section class="mb-4">
        <div class="card card-info mt-5">
            <div class="card-header">
                <h3 class="card-title">Delete Account</h3>
            </div>
            <div class="card-body">
                <header class="mb-3">
                    <h2 class="h5 fw-medium text-dark">
                        Delete Account
                    </h2>

                    <p class="small text-muted mb-0">
                        Once your account is deleted, all of its resources and data will be permanently deleted.
                        Before deleting your account, please download any data or information that you wish to retain.
                    </p>
                </header>

                <button @click="confirmUserDeletion" class="btn btn-danger">
                    Delete Account
                </button>

                <Modal :show="confirmingUserDeletion" @close="closeModal">
                    <div class="p-4">
                        <h2 class="h5 fw-medium text-dark">
                            Are you sure you want to delete your account?
                        </h2>

                        <p class="small text-muted mt-2">
                            Once your account is deleted, all of its resources and data will be permanently deleted.
                            Please enter your password to confirm you would like to permanently delete your account.
                        </p>

                        <div class="mt-4">
                            <InputLabel
                                for="password"
                                value="Password"
                                class="visually-hidden"
                            />

                            <TextInput
                                id="password"
                                ref="passwordInput"
                                v-model="form.password"
                                type="password"
                                class="form-control w-75"
                                placeholder="Password"
                                @keyup.enter="deleteUser"
                            />

                            <InputError :message="form.errors.password" class="text-danger small mt-1" />
                        </div>

                        <div class="mt-4 d-flex justify-content-end">
                            <SecondaryButton @click="closeModal" class="btn btn-secondary">
                                Cancel
                            </SecondaryButton>

                            <button
                                class="btn btn-danger ms-2"
                                :class="{ 'opacity-25': form.processing }"
                                :disabled="form.processing"
                                @click="deleteUser"
                            >
                                <span v-if="form.processing">
                                    <i class="fas fa-spinner fa-spin"></i> Deleting...
                                </span>
                                <span v-else>
                                    Delete Account
                                </span>                                 
                            </button>
                        </div>
                    </div>
                </Modal>
            </div>
        </div>
    </section>
</template>

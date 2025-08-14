<script setup>
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
        <h2 class="h5 fw-semibold text-dark">
            Delete Account
        </h2>
        <p class="small text-muted mb-0">
            Once your account is deleted, all of its resources and data will be permanently removed.  
            Please download any information you wish to keep before proceeding.
        </p>
    </header>

    <button @click="confirmUserDeletion" class="btn btn-danger">
        <i class="fas fa-user-times me-2"></i> Delete Account
    </button>

    <!-- Bootstrap Modal -->
    <div 
        class="modal fade" 
        tabindex="-1" 
        :class="{ show: confirmingUserDeletion }" 
        style="display: block;" 
        v-if="confirmingUserDeletion"
        @click.self="closeModal"
    >
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">
                        Are you sure you want to delete your account?
                    </h5>
                    <button type="button" class="btn-close" @click="closeModal">x</button>
                </div>
                <div class="modal-body">
                    <p class="small text-muted">
                        Once your account is deleted, all of its resources and data will be permanently deleted.  
                        Please enter your password to confirm this action.
                    </p>

                    <div class="mb-3">
                        <label for="password" class="form-label visually-hidden">Password</label>
                        <input
                            id="password"
                            ref="passwordInput"
                            v-model="form.password"
                            type="password"
                            class="form-control"
                            placeholder="Password"
                            @keyup.enter="deleteUser"
                        />
                        <div v-if="form.errors.password" class="text-danger small mt-1">
                            {{ form.errors.password }}
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning" @click="closeModal">
                        Cancel
                    </button>
                    <button 
                        type="button" 
                        class="btn btn-danger"
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
        </div>
    </div>
</div>

        </div>
    </section>
</template>

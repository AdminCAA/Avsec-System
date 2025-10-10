<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import { Head, Link, useForm } from '@inertiajs/vue3';
import Swal from 'sweetalert2';
import 'sweetalert2/dist/sweetalert2.min.css';
import InputError from '@/Components/InputError.vue';
import { ref, watch } from 'vue';
import { router } from '@inertiajs/vue3';
const props = defineProps({
    role: {
        type: Object,
        required: true
    },
    permissions: {
        type: Object,
        required: true
    },
    hasPermissions: {
        type: Array,
        required: true
    }
});
const form = useForm({
    name: props.role.name,
});

const formErrors = ref({
    name: '',
});
watch(() => form.name, (value) => {
    if (!value.trim()) {
        formErrors.value.name = 'Name is required.';
    } else if (value.trim().length < 3) {
        formErrors.value.name = 'Name must be at least 3 characters.';
    } else {
        formErrors.value.name = '';
    }
});

const isLoading = ref(false);
//Create the user permission
// and redirect to the permissions index page
const errorMessage = ref(''); //For dispalying validation error messages
const selectedPermissions = ref([]); // This will hold the selected permission IDs
selectedPermissions.value = props.hasPermissions;
const updateRole = () => {
    isLoading.value = true;
    axios.post(route('roles.update', props.role.id), {
        name: form.name, // assuming you're using reactive `form` or `ref()`      
        permissions: selectedPermissions.value
    })
        .then(response => {
            Swal.fire({
                icon: "success",
                title: "Role created successfully",
                toast: true,
                position: "top-end",
                showConfirmButton: false,
                timer: 1000,
                timerProgressBar: true,
            });
            //redirect to the permissions index page
            setTimeout(() => {
                router.visit(route('roles.index'), {
                    preserveScroll: true,
                    replace: true
                });

            }, 1000);
        })
        .catch(error => {

            console.log(error);
            let message = "Something went wrong.";
            if (error.response && error.response.status === 422) {
                const errors = error.response.data.errors;
                message = Object.values(errors).flat().join("\n");
            }
            Swal.fire({
                icon: "error",
                title: "Validation failed",
                text: message,
                toast: true,
                position: "top-end",
                showConfirmButton: false,
                timer: 3000,
                timerProgressBar: true,
            });
            // Handle the error message
            if (error.response && error.response.status === 422) {
                const errors = error.response.data.errors;
                errorMessage.value = Object.values(errors).flat().join("\n");
            } else if (error.response && error.response.status === 404) {
                errorMessage.value = error.response.data.error;
            } else {
                errorMessage.value = "An unexpected error occurred.";
            }

        }).finally(() => {
            isLoading.value = false;
        });
}


</script>

<template>

    <Head title="Roles-Create" />
    <AuthenticatedLayout>
        <div class="content-wrapper">
            <div class="content-header">
                <div class="container-fluid">
                    <div class="row mb-2">
                        <div class="col-sm-6">
                            <h1 class="m-0">Roles/Edit</h1>
                        </div>
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item">
                                    <Link class="btn btn-info" :href="route('roles.index')"><i
                                        class="fas fa-arrow-left"></i> Back</Link>
                                </li>
                            </ol>
                        </div>
                    </div>
                </div>
            </div>



            <div class="content">
                <div class="container-fluid">
                    <div class="d-flex justify-content-center align-items-center min-vh-60  bg-light">
                        <div class="row w-100 justify-content-center">
                            <div class="col-md-6">
                                <!-- general form elements -->
                                <div class="card card-info">
                                    <div class="card-header">
                                        <h3 class="card-title">Edit Role</h3>
                                    </div>
                                    <!-- form start -->
                                    <form @submit.prevent="updateRole" method="post">
                                        <div class="card-body">
                                            <div class="form-group">
                                                <label for="name">Name</label>
                                                <input v-model="form.name" type="name" class="form-control" id="name"
                                                    :class="{
                                                        'is-invalid': formErrors.name,
                                                        'is-valid': form.name && !formErrors.name
                                                    }" required max="255" placeholder="Enter Name">
                                                <InputError :message="formErrors.name || form.errors.name"
                                                    class="mt-2" />
                                                <div v-if="form.name && !formErrors.name"
                                                    class="valid-feedback d-block">
                                                    Name looks good!
                                                </div>
                                            </div>
                                            <label for="name">Role Permissions</label>
                                            <div class="row">
                                                <div class="col-sm-12">
                                                    <div class="card card-info card-outline">
                                                        <div class="card-header">
                                                            <h5 class="card-title">Assign Permissions</h5>
                                                        </div>
                                                        <div class="form-group d-flex flex-wrap card-body">
                                                            <div class="custom-control custom-checkbox mr-3 mb-2"
                                                                v-for="(permission, index) in permissions"
                                                                :key="permission.id">
                                                                <input class="custom-control-input"
                                                                    :id="'permission-' + permission.id" type="checkbox"
                                                                    v-model="selectedPermissions"
                                                                    :value="permission.name">
                                                                <label :for="'permission-' + permission.id"
                                                                    class="custom-control-label">{{
                                                                    permission.name}}</label>
                                                            </div>
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="card-footer">
                                            <div class="d-flex ">
                                                <button :disabled="isLoading" :class="{ 'opacity-25': isLoading }"
                                                    type="submit" class="btn btn-info ml-auto mr-2">
                                                    <span v-if="isLoading">
                                                        <i class="fas fa-spinner fa-spin"></i> Processing...
                                                    </span>
                                                    <span v-else>
                                                        <i class="fas fa-save"></i> Save
                                                    </span>
                                                </button>

                                                <Link :href="route('roles.index')" class="btn btn-default float-right">
                                                <i class="fas fa-window-close"></i> Cancel
                                                </Link>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </AuthenticatedLayout>
</template>
<style>
.content-wrapper {
    font-family: 'Poppins', 'Segoe UI', sans-serif;
}
</style>
<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import { Head, Link, useForm } from '@inertiajs/vue3';

import Swal from 'sweetalert2';
import 'sweetalert2/dist/sweetalert2.min.css';
import InputError from '@/Components/InputError.vue';
import { router } from '@inertiajs/vue3';
import { ref, watch } from 'vue';
import 'sweetalert2/dist/sweetalert2.min.css';
import vSelect from 'vue-select'
import 'vue-select/dist/vue-select.css'


const {
    personnel,
    facilities,
    trainings,
    userTypes,
    userStatuses
} = defineProps({
    personnel: {
        type: Object,
        required: true
    },
    facilities: {
        type: Array,
        required: true
    },
    trainings: {
        type: Array,
        required: true
    },
    userTypes: {
        type: Array,
        required: true
    },
    userStatuses: {
        type: Array,
        required: true
    }
});

const genderOptions = [
    'Male', 'Female'
]


const formErrors = ref({
    name: "",
    email: "",
    facility_id: "",
    gender: "",
    user_type: "",
    nrc: "",
    phone_number: "",
    is_certified: "",
    password: "",
    confirm_password: "",
    portrait: ""
});

const form = useForm({
    name: personnel.name,
    email: personnel.email,
    facility_id: personnel.facility_id,
    gender: personnel.gender,
    user_type: personnel.user_type,
    nrc: personnel.nrc,
    phone_number: personnel.phone_number,
    is_certified: personnel.is_certified,
});

const isLoading = ref(false);
const errorMessage = ref('');
const avatarPreview = ref(null);

function updateUser() {
    let formData = new FormData();
    isLoading.value = true;
    // Append form data
    formData.append('name', form.name);
    formData.append('email', form.email);
    formData.append('nrc', form.nrc);
    formData.append('gender', form.gender);
    formData.append('facility_id', form.facility_id);
    formData.append('phone_number', form.phone_number);
    formData.append('user_type', form.user_type);
    formData.append('is_certified', form.is_certified);
    // Append password and confirm_password only if they are provided
    if (form.password) formData.append('password', form.password);
    if (form.confirm_password) formData.append('confirm_password', form.confirm_password);

    if (form.portrait) {
        formData.append('portrait', form.portrait);
    }

    axios.post(route('officers.update', personnel.id), formData)
        .then(response => {
            Swal.fire({
                icon: "success",
                title: "User created successfully",
                toast: true,
                position: "top-end",
                showConfirmButton: false,
                timer: 1000,
                timerProgressBar: true,
            });

            //redirect to the permissions index page
            setTimeout(() => {
                router.visit(route('officers.index'), {
                    preserveScroll: true,
                    replace: true
                });
            }, 1000);
        })
        .catch(error => {
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


watch(() => form.name, (value) => {
    if (!value.trim()) {
        formErrors.value.name = 'Name is required.';
    } else if (value.trim().length < 3) {
        formErrors.value.name = 'Name must be at least 3 characters.';
    } else {
        formErrors.value.name = '';
    }
});

watch(() => form.email, (value) => {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!value.trim()) {
        formErrors.value.email = 'Email is required.';
    } else if (!emailRegex.test(value)) {
        formErrors.value.email = 'Invalid email format.';
    } else {
        formErrors.value.email = '';
    }
});

watch(() => form.password, (value) => {
    formErrors.value.password = value.length < 6 ? 'Password must be at least 6 characters.' : '';
    let message = '';
    if (value.length < 8) {
        message = "Password must be at least 8 characters.";
    } else if (!/[A-Z]/.test(value)) {
        message = "Add at least one uppercase letter.";
    } else if (!/[a-z]/.test(value)) {
        message = "Add at least one lowercase letter.";
    } else if (!/[0-9]/.test(value)) {
        message = "Add at least one number.";
    } else if (!/[!@#$%^&*(),.?\":{}|<>]/.test(value)) {
        message = "Add at least one special character.";
    } else {
        message = ""; // no error
    }
    formErrors.value.password = message;
});

watch([() => form.password, () => form.confirm_password], ([pwd, confPwd]) => {
    formErrors.value.confirm_password =
        confPwd !== pwd ? 'Passwords do not match.' : '';
});


watch(() => form.nrc, (value) => {
    const nrcPattern = /^\d{1,10}\/\d{1,5}\/\d{1,5}$/;
    if (!value.trim()) {
        formErrors.value.nrc = 'NRC is required.';
    } else if (!nrcPattern.test(value)) {
        formErrors.value.nrc = 'Invalid NRC format. Example: 214129/48/1';
    } else {
        formErrors.value.nrc = '';
    }
});


watch(() => form.facility_id, (value) => {
    if (!value) {
        formErrors.value.facility_id = 'Operator is required.';
    } else {
        formErrors.value.facility_id = '';
    }
});

watch(() => form.is_certified, (value) => {
    if (!value.trim()) {
        formErrors.value.is_certified = 'Status is required.';
    } else {
        formErrors.value.is_certified = '';
    }
});


watch(() => form.user_type, (value) => {
    if (!value.trim()) {
        formErrors.value.user_type = 'User category is required.';
    } else {
        formErrors.value.user_type = '';
    }
});

watch(() => form.is_certified, (value) => {
    if (!value.trim()) {
        formErrors.value.is_certified = 'Status is required.';
    } else {
        formErrors.value.is_certified = '';
    }
});

watch(() => form.phone_number, (value) => {
    const phoneRegex = /^\d{10,15}$/; // Adjust regex as needed
    if (!value.trim()) {
        formErrors.value.phone_number = 'Phone number is required.';
    } else if (!phoneRegex.test(value)) {
        formErrors.value.phone_number = 'Invalid phone number format.';
    } else {
        formErrors.value.phone_number = '';
    }
});
watch(() => form.facility_id, (value) => {
    formErrors.value.facility_id = value ? '' : 'Facility is required.';
});

watch(() => form.gender, () => {
    if (!form.gender) {
        formErrors.value.gender = 'Gender is required.';
    } else if (!genderOptions.includes(form.gender)) {
        formErrors.value.gender = 'Please select a valid gender.';
    } else {
        formErrors.gender = '';
    }
})


// Check if a training is selected
const isSelected = (trainingId) => {
    return selectedTrainings.value[trainingId] !== undefined
}

const fileName = ref('');
const handleFileUpload = (event) => {
    const file = event.target.files[0];
    if (file) {
        form.portrait = file;
        fileName.value = file.name;
        avatarPreview.value = URL.createObjectURL(file);
    }
};

</script>

<template>

    <Head title="User-Create" />
    <AuthenticatedLayout>
        <div class="content-wrapper">
            <div class="content-header">
                <div class="container-fluid">
                    <div class="row mb-2">
                        <div class="col-sm-6">
                            <h3 class="m-0">Avsec User / Update</h3>
                        </div>
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item">
                                    <Link class="btn btn-info mr-3" :href="route('officers.index')"><i
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
                            <div class="col-md-12">

                                <!-- general form elements -->
                                <div class="card card-info">
                                    <div class="card-header">
                                        <h3 class="card-title">Update Avsec User</h3>
                                    </div>
                                    <!-- form start -->
                                    <form @submit.prevent="updateUser" method="post" enctype="multipart/form-data">
                                        <div class="card-body">
                                            <div class="col-md-2">
                                                <div class="card card-info card-outline">
                                                    <div class="card-body box-profile">
                                                        <div class="text-center">
                                                            <img class="profile-user-img img-fluid img-circle"
                                                                style="width: 150px;" :src="personnel.portrait ?
                                                                    `/storage/${personnel.portrait}`
                                                                    : '/storage/portraits/avatar.png'"
                                                                alt="User profile picture">
                                                        </div>
                                                        <h3 class="profile-username text-center">{{ personnel.name }}
                                                        </h3>
                                                        <p class="text-muted text-center">{{ personnel.user_type }}</p>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row">

                                                <div class="form-group col-md-6">

                                                    <label for="name">Names</label>
                                                    <input v-model="form.name" type="text" class="form-control"
                                                        id="name" :class="{
                                                            'is-invalid': formErrors.name,
                                                            'is-valid': form.name && !formErrors.name
                                                        }" required maxlength="255" placeholder="Enter Name">
                                                    <InputError :message="formErrors.name || form.errors.name"
                                                        class="mt-2" />
                                                    <div v-if="form.name && !formErrors.name"
                                                        class="valid-feedback d-block">
                                                        Name looks good!
                                                    </div>
                                                </div>

                                                <div class="form-group col-md-6">
                                                    <label for="name">Email</label>
                                                    <input v-model="form.email" type="email" class="form-control"
                                                        id="email" :class="{
                                                            'is-invalid': formErrors.email,
                                                            'is-valid': form.email && !formErrors.email
                                                        }" required max="255" placeholder="Enter Email">
                                                    <InputError :message="formErrors.email || form.errors.email"
                                                        class="mt-2" />
                                                    <div v-if="form.email && !formErrors.email"
                                                        class="valid-feedback d-block">
                                                        Email looks good!
                                                    </div>
                                                </div>

                                            </div>

                                            <div class="row">
                                                <div class="form-group col-md-3">
                                                    <label for="nrc">NRC</label>
                                                    <input v-model="form.nrc" type="text" name="nrc" id="nrc"
                                                        class="form-control" :class="{
                                                            'is-invalid': formErrors.nrc,
                                                            'is-valid': form.nrc && !formErrors.nrc
                                                        }" required maxlength="12" placeholder="Enter NRC">

                                                    <!-- Error Display -->
                                                    <InputError :message="formErrors.nrc" class="mt-2" />

                                                    <!-- Success Feedback -->
                                                    <div v-if="form.nrc && !formErrors.nrc"
                                                        class="valid-feedback d-block">
                                                        NRC looks good!
                                                    </div>
                                                </div>

                                                <div class="form-group col-md-3">
                                                    <label>Gender</label>
                                                    <select required v-model="form.gender" class="form-control"
                                                        :class="{ 'is-invalid': formErrors.gender, 'is-valid': form.gender && !formErrors.gender }">
                                                        <option value="">-- Select Gender --</option>
                                                        <option v-for="item in genderOptions" :key="item" :value="item">
                                                            {{ item }}</option>
                                                    </select>
                                                    <InputError :message="formErrors.gender" class="mt-1" />
                                                </div>

                                                <div class="form-group col-md-6">
                                                    <label>Phone Number</label>
                                                    <input v-model="form.phone_number" type="text" required max="15"
                                                        class="form-control"
                                                        :class="{ 'is-invalid': formErrors.phone_number, 'is-valid': form.phone_number && !formErrors.phone_number }"
                                                        placeholder="Enter Phone Number">
                                                    <InputError :message="formErrors.phone_number" class="mt-1" />
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="form-group col-md-6">
                                                    <label>Status</label>
                                                    <select required v-model="form.is_certified" class="form-control"
                                                        :class="{ 'is-invalid': formErrors.is_certified, 'is-valid': form.is_certified && !formErrors.is_certified }">
                                                        <option value="">-- Select Status --</option>
                                                        <option v-for="item in userStatuses" :key="item" :value="item">
                                                            {{ item }}</option>
                                                    </select>
                                                    <InputError :message="formErrors.is_certified" class="mt-1" />
                                                </div>

                                                <div class="form-group col-md-6">
                                                    <label> Category</label>
                                                    <select required v-model="form.user_type" class="form-control"
                                                        :class="{ 'is-invalid': formErrors.user_type, 'is-valid': form.user_type && !formErrors.user_type }">
                                                        <option value="">-- Select User Category --</option>
                                                        <option v-for="item in userTypes" :key="item" :value="item">{{
                                                            item }}</option>
                                                    </select>
                                                    <InputError :message="formErrors.user_type" class="mt-1" />
                                                </div>

                                            </div>



                                            <div class="row">
                                                <div class="form-group col-md-6">
                                                    <label>Operator</label>
                                                    <v-select v-model="form.facility_id" :options="facilities"
                                                        :reduce="facility => facility.id" label="name"
                                                        placeholder="-- Select Operator --" :class="{
                                                            'is-invalid': formErrors.facility_id,
                                                            'is-valid': form.facility_id && !formErrors.facility_id
                                                        }" />
                                                    <InputError :message="formErrors.facility_id" class="mt-1" />
                                                </div>


                                                <div class="form-group col-md-6">
                                                    <label>Portrait</label>
                                                    <div class="input-group">
                                                        <div class="custom-file">
                                                            <input type="file" accept="image/*"
                                                                @change="handleFileUpload" class="custom-file-input"
                                                                id="exampleInputFile"
                                                                :class="{ 'is-invalid': formErrors.portrait, 'is-valid': form.portrait && !formErrors.portrait }">
                                                            <label class="custom-file-label" for="exampleInputFile">
                                                                {{ fileName || 'Choose file' }}
                                                            </label>
                                                        </div>
                                                    </div>
                                                    <InputError :message="formErrors.portrait" class="mt-1" />
                                                </div>

                                            </div>

                                            <div class="row">
                                                <div class="form-group col-md-6">
                                                    <label for="name">Password</label>
                                                    <input v-model="form.password" type="password" class="form-control"
                                                        id="password" max="255" :class="{
                                                            'is-invalid': formErrors.password,
                                                            'is-valid': form.password && !formErrors.password
                                                        }" placeholder="Enter Password">
                                                    <InputError :message="formErrors.password || form.errors.password"
                                                        class="mt-2" />

                                                    <!-- Success message -->
                                                    <div v-if="form.password && !formErrors.password"
                                                        class="valid-feedback d-block">
                                                        Strong password!
                                                    </div>
                                                </div>

                                                <div class="form-group col-md-6">
                                                    <label for="name">Confirm Password</label>
                                                    <input v-model="form.confirm_password" type="password"
                                                        class="form-control" id="paswword_confirmation" max="255"
                                                        :class="{
                                                            'is-invalid': formErrors.confirm_password,
                                                            'is-valid': form.confirm_password && !formErrors.confirm_password
                                                        }" placeholder="Confirm Password">
                                                    <InputError
                                                        :message="formErrors.confirm_password || form.errors.confirm_password"
                                                        class="mt-2" />
                                                    <div v-if="form.confirm_password && !formErrors.confirm_password"
                                                        class="valid-feedback d-block">
                                                        Password confirmation looks good!
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
                                                <Link :href="route('officers.index')"
                                                    class="btn btn-default float-right">
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
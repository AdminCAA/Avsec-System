<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import { Head, Link, useForm, router } from '@inertiajs/vue3';
import Swal from 'sweetalert2';
import 'sweetalert2/dist/sweetalert2.min.css';
import InputError from '@/Components/InputError.vue';
import { ref, watch } from 'vue';
import dayjs from 'dayjs';

const { user_id, mandatorycourses } = defineProps({
  user_id: {
    type: Number,
    required: true
  },
  mandatorycourses: {
    type: Object,
    required: true
  }
});

// Status options
const statusOptions = ['Valid', 'Expired', 'Pending', 'In Progress'];

// Form initialization
const form = useForm({
  course_name: mandatorycourses.course_name || '',
  training_center: mandatorycourses.training_center || '',
  certificate_number: mandatorycourses.certificate_number || '',
  date_issued: mandatorycourses.date_issued || '',
  expiry_date: mandatorycourses.expiry_date || '',
  status: mandatorycourses.status || '',
  attachment: null,
});

// Keep track of form errors
const formErrors = ref({
  course_name: '',
  training_center: '',
  certificate_number: '',
  date_issued: '',
  expiry_date: '',
  status: '',
  attachment: ''
});

// Loading state
const isLoading = ref(false);

// Existing attachment handling
const existingAttachment = ref(mandatorycourses.attachment || '');
const fileName = ref(existingAttachment.value ? existingAttachment.value.split('/').pop() : '');

// Handle file selection
const handleFileUpload = (event) => {
  const file = event.target.files[0];
  if (file) {
    if (file.type !== 'application/pdf') {
      Swal.fire({
        icon: 'error',
        title: 'Invalid File',
        text: 'Only PDF files are allowed.',
      });
      event.target.value = '';
      return;
    }
    form.attachment = file; 
    fileName.value = file.name;
    existingAttachment.value = ''; // Clear old attachment
  }
};

// Submit form to backend
function updateMandatoryCourse() {
  const formData = new FormData();
  isLoading.value = true;

  formData.append('user_id', user_id);
  formData.append('course_name', form.course_name);
  formData.append('training_center', form.training_center);
  formData.append('certificate_number', form.certificate_number);
  formData.append('date_issued', form.date_issued);
  formData.append('expiry_date', form.expiry_date);
  formData.append('status', form.status);

  // Only append new file if selected
  if (form.attachment) {
    formData.append('attachment', form.attachment);
  }

  axios.post(route('mandatorycourses.update', mandatorycourses.id), formData)
    .then(() => {
      Swal.fire({
        icon: 'success',
        title: 'Mandatory Course updated successfully',
        toast: true,
        position: 'top-end',
        showConfirmButton: false,
        timer: 1200
      });

      setTimeout(() => {

        router.visit(
          route('officers.show', user_id) + '?tab=Mandatory+Course',
          { replace: true }
        );
      }, 1200);
    })
    .catch(error => {
      let message = 'Something went wrong.';
      if (error.response && error.response.status === 422) {
        const errors = error.response.data.errors;
        message = Object.values(errors).flat().join('\n');
      }
      Swal.fire({
        icon: 'error',
        title: 'Validation failed',
        text: message,
        toast: true,
        position: 'top-end',
        showConfirmButton: false,
        timer: 3000
      });
    })
    .finally(() => {
      isLoading.value = false;
    });
}

// --- Validations ---
watch(() => form.course_name, value => {
  formErrors.value.course_name = value.trim() ? '' : 'Course name is required.';
});
watch(() => form.training_center, value => {
  formErrors.value.training_center = value.trim() ? '' : 'Training center is required.';
});
watch(() => form.certificate_number, value => {
  formErrors.value.certificate_number = value.trim() ? '' : 'Certificate number is required.';
});
watch(() => form.date_issued, value => {
  formErrors.value.date_issued = value ? '' : 'Date issued is required.';
});
watch(() => form.expiry_date, value => {
  if (!value) {
    formErrors.value.expiry_date = 'Expiry date is required.';
  } else if (form.date_issued && dayjs(value).isBefore(dayjs(form.date_issued))) {
    formErrors.value.expiry_date = 'Expiry date cannot be before issued date.';
  } else {
    formErrors.value.expiry_date = '';
  }
});
watch(() => form.status, value => {
  formErrors.value.status = value ? '' : 'Status is required.';
});
</script>

<template>

    <Head title="Edit Mandatory Course" />
    <AuthenticatedLayout>
        <div class="content-wrapper">
            <div class="content-header">
                <div class="container-fluid">
                    <div class="row mb-2">
                        <div class="col-sm-6">
                            <h3 class="m-0"><strong>Mandatory Course / Edit</strong></h3>
                        </div>
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item">
                                    <Link class="btn btn-info mr-3" :href="route('officers.show', user_id)">
                                    <i class="fas fa-arrow-left"></i> Back
                                    </Link>
                                </li>
                            </ol>
                        </div>
                    </div>
                </div>
            </div>

            <div class="content">
                <div class="container-fluid">
                    <div class="row justify-content-center">
                        <div class="col-md-10">
                            <div class="card card-info">
                                <div class="card-header">
                                    <h3 class="card-title">Edit Mandatory Course</h3>
                                </div>

                                <form @submit.prevent="updateMandatoryCourse" enctype="multipart/form-data">
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="form-group col-md-6">
                                                <label>Course Name</label>
                                                <input v-model="form.course_name" type="text" class="form-control"
                                                    :class="{ 'is-invalid': formErrors.course_name }"
                                                    placeholder="Enter course name">
                                                <InputError :message="formErrors.course_name" />
                                            </div>

                                            <div class="form-group col-md-6">
                                                <label>Training Center</label>
                                                <input v-model="form.training_center" type="text" class="form-control"
                                                    :class="{ 'is-invalid': formErrors.training_center }"
                                                    placeholder="Enter training center">
                                                <InputError :message="formErrors.training_center" />
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="form-group col-md-6">
                                                <label>Certificate Number</label>
                                                <input v-model="form.certificate_number" type="text"
                                                    class="form-control"
                                                    :class="{ 'is-invalid': formErrors.certificate_number }"
                                                    placeholder="Enter certificate number">
                                                <InputError :message="formErrors.certificate_number" />
                                            </div>

                                            <div class="form-group col-md-3">
                                                <label>Date Issued</label>
                                                <input type="date" v-model="form.date_issued" class="form-control"
                                                    :class="{ 'is-invalid': formErrors.date_issued }">
                                                <InputError :message="formErrors.date_issued" />
                                            </div>

                                            <div class="form-group col-md-3">
                                                <label>Expiry Date</label>
                                                <input type="date" v-model="form.expiry_date" class="form-control"
                                                    :class="{ 'is-invalid': formErrors.expiry_date }">
                                                <InputError :message="formErrors.expiry_date" />
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="form-group col-md-6">
                                                <label>Status</label>
                                                <select v-model="form.status" class="form-control"
                                                    :class="{ 'is-invalid': formErrors.status }">
                                                    <option value="">-- Select Status --</option>
                                                    <option v-for="item in statusOptions" :key="item" :value="item">{{
                                                        item }}</option>
                                                </select>
                                                <InputError :message="formErrors.status" />
                                            </div>

                                            <div class="form-group col-md-6">
                                                <!-- Existing attachment as text link -->
                                                <div v-if="existingAttachment" class="mb-2">
                                                    <a :href="`/storage/${existingAttachment}`" target="_blank"
                                                        class="text-success">
                                                        View PDF
                                                    </a>
                                                </div>

                                                <div class="input-group">
                                                    <div class="custom-file">
                                                        <input type="file" accept=".pdf" @change="handleFileUpload"
                                                            class="custom-file-input" id="certificateUpload">
                                                        <label class="custom-file-label" for="certificateUpload">
                                                            {{ fileName || 'Choose PDF file' }}
                                                        </label>
                                                    </div>
                                                </div>
                                                <InputError :message="formErrors.attachment" />
                                            </div>
                                        </div>
                                    </div>

                                    <div class="card-footer text-right">
                                        <button type="submit" class="btn btn-info" :disabled="isLoading">
                                            <span v-if="isLoading">
                                                <i class="fas fa-spinner fa-spin"></i> Updating...
                                            </span>
                                            <span v-else>
                                                <i class="fas fa-save"></i> Update
                                            </span>
                                        </button>
                                        <Link :href="route('officers.show', user_id)" class="btn btn-default ml-2">
                                        <i class="fas fa-window-close"></i> Cancel
                                        </Link>
                                    </div>
                                </form>
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

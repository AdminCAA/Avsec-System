<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import { Head, Link, useForm, router } from '@inertiajs/vue3';
import Swal from 'sweetalert2';
import 'sweetalert2/dist/sweetalert2.min.css';
import InputError from '@/Components/InputError.vue';
import { ref, watch } from 'vue';
import dayjs from 'dayjs';

const { user, personnel } = defineProps({
  user: {
    type: Object,
    required: true
  },

  personnel: {
    type: Object,
    required: true
  },
});

const form = useForm({
  user_id: personnel.id,
  training_name: '',
  training_center: '',
  certificate_number: '',
  date_issued: '',
  expiry_date: '',
  status: '',
  attachment: null
});

const formErrors = ref({
  training_name: '',
  training_center: '',
  certificate_number: '',
  date_issued: '',
  expiry_date: '',
  status: '',
  attachment: ''
});

const isLoading = ref(false);
const fileName = ref('');
const statusOptions = ['Valid', 'Expired', 'Pending', 'In Progress'];

const handleFileUpload = (event) => {
  const file = event.target.files[0];
  if (file) {
    if (file.type !== 'application/pdf') {
      Swal.fire({
        icon: 'error',
        title: 'Invalid file type',
        text: 'Only PDF files are allowed.'
      });
      event.target.value = '';
      return;
    }
    form.attachment = file;
    fileName.value = file.name;
  }
};

function createSpecialisedTraining() {
  const formData = new FormData();
  isLoading.value = true;

  for (const [key, value] of Object.entries(form)) {
    formData.append(key, value);
  }

  axios.post(route('specialisedtrainings.store'), formData)
    .then(() => {
      Swal.fire({
        icon: 'success',
        title: 'Specialised training added successfully',
        toast: true,
        position: 'top-end',
        showConfirmButton: false,
        timer: 1500
      });

      setTimeout(() => {
        router.visit(
          route('officers.show', personnel.id) + '?tab=Specialised+Course',
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

// Field validations
watch(() => form.training_name, value => {
  formErrors.value.training_name = value.trim() ? '' : 'Training name is required.';
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

  <Head title="Add Specialised Training" />
  <AuthenticatedLayout>
    <div class="content-wrapper">
      <div class="content-header">
        <div class="container-fluid">
          <div class="row mb-2">
            <div class="col-sm-6">
              <h3 class="m-0"><strong>Specialised Training / Create</strong></h3>
            </div>
            <div class="col-sm-6">
              <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item">
                  <Link class="btn btn-info mr-3" :href="route('officers.show', personnel.id)">
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
                  <h3 class="card-title">Add Specialised Training</h3>
                </div>
                <form @submit.prevent="createSpecialisedTraining" enctype="multipart/form-data">
                  <div class="card-body">
                    <div class="row">
                      <div class="form-group col-md-6">
                        <label>Training Name</label>
                        <input type="text" v-model="form.training_name" class="form-control"
                          :class="{ 'is-invalid': formErrors.training_name }" placeholder="Enter training name">
                        <InputError :message="formErrors.training_name" />
                      </div>

                      <div class="form-group col-md-6">
                        <label>Training Center</label>
                        <input type="text" v-model="form.training_center" class="form-control"
                          :class="{ 'is-invalid': formErrors.training_center }" placeholder="Enter training center">
                        <InputError :message="formErrors.training_center" />
                      </div>
                    </div>

                    <div class="row">
                      <div class="form-group col-md-6">
                        <label>Certificate Number</label>
                        <input type="text" v-model="form.certificate_number" class="form-control"
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
                        <select v-model="form.status" class="form-control" :class="{ 'is-invalid': formErrors.status }">
                          <option value="">-- Select Status --</option>
                          <option v-for="item in statusOptions" :key="item" :value="item">{{ item }}</option>
                        </select>
                        <InputError :message="formErrors.status" />
                      </div>

                      <div class="form-group col-md-6">
                        <label>Certificate (PDF only)</label>
                        <div class="input-group">
                          <div class="custom-file">
                            <input type="file" accept=".pdf" @change="handleFileUpload" class="custom-file-input"
                              id="certificateUpload">
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
                        <i class="fas fa-spinner fa-spin"></i> Saving...
                      </span>
                      <span v-else>
                        <i class="fas fa-save"></i> Submit
                      </span>
                    </button>
                    <Link :href="route('personnels.show', personnel.id)" class="btn btn-default ml-2">
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

<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import { Head, Link, useForm, router } from '@inertiajs/vue3';
import { ref, watch } from 'vue';
import Swal from 'sweetalert2';
import 'sweetalert2/dist/sweetalert2.min.css';
import InputError from '@/Components/InputError.vue';

import vSelect from 'vue-select'
import 'vue-select/dist/vue-select.css'

const { facilities, statuses } = defineProps({
  facilities: {
    type: Object,
    required: true
  },
  statuses:
  {
    type: Object,
    required: true
  }
});

const form = useForm({
  name: '',
  facility_id: '',
  serial_number: '',
  status: '',
  description: '',
});

const isLoading = ref(false);
const formErrors = ref({});

function createSecurityEquipment() {
  isLoading.value = true;
  axios.post(route('security-equipments.store'), form)
    .then(() => {
      Swal.fire({
        icon: 'success',
        title: 'Security Equipment created successfully',
        toast: true,
        position: 'top-end',
        timer: 1500,
        showConfirmButton: false
      });
      setTimeout(() => {
        router.visit(route('security-equipments.index'));
      }, 1500);
    })
    .catch(error => {
      if (error.response?.status === 422) {
        const errors = error.response.data.errors;
        formErrors.value = errors;
        const message = Object.values(errors).flat().join('\n');
        Swal.fire({
          icon: 'error',
          title: 'Validation failed',
          text: message,
          toast: true,
          position: 'top-end',
          timer: 3000,
          showConfirmButton: false
        });
      }
    }).finally(() => {
      isLoading.value = false;
    });
}

// Realtime validation examples

watch(() => form.name, (value) => {
  formErrors.value.name = !value ? 'Name is required.' : '';
});

watch(() => form.facility_id, (value) => {
  formErrors.value.facility_id = !value ? 'Facility is required.' : '';
});

watch(() => form.status, (value) => {
  formErrors.value.status = !value ? 'Status is required.' : '';
});

watch(() => form.serial_number, (value) => {
  formErrors.value.serial_number = !value ? 'Serial Number is required.' : '';
});

console.log(statuses);
</script>

<template>

  <Head title="Create Security Equipment" />
  <AuthenticatedLayout>
    <div class="content-wrapper">
      <div class="content-header">
        <div class="container-fluid">
          <div class="row mb-2">
            <div class="col-sm-6">
              <h3 class="m-0">Security Equipment / Create</h3>
            </div>
          </div>
        </div>
      </div>


      <div class="content">
        <div class="container-fluid">
          <div class="d-flex justify-content-center align-items-center min-vh-60  bg-light">
            <div class="row w-100 justify-content-center">
              <div class="col-md-10 mb-4">
                <!-- general form elements -->
                <div class="card card-info">
                  <div class="card-header">
                    <h3 class="card-title">Create Security Equipment</h3>
                  </div>
                  <!-- form start -->
                  <form @submit.prevent="createSecurityEquipment">
                    <div class="card-body">
                      <!-- Name -->
                      <!-- Row 1: Name & Category -->
                      <div class="row">
                        <div class="form-group col-md-6">
                          <label>Name</label>
                          <input required v-model="form.name" type="text" class="form-control"
                            :class="{ 'is-invalid': formErrors.name, 'is-valid': form.name && !formErrors.name }"
                            placeholder="Enter Equipment Name">
                          <InputError :message="formErrors.name" class="mt-1" />
                        </div>

                        <div class="form-group col-md-6">
                          <label>Location</label>
                          <v-select v-model="form.facility_id" :options="facilities" :reduce="facility => facility.id"
                            label="name" placeholder="-- Select Location / Facility --" :input-class="{
                              'is-invalid': formErrors.facility_id,
                              'is-valid': form.facility_id && !formErrors.facility_id
                            }" />
                          <InputError :message="formErrors.facility_id" class="mt-1" />
                        </div>
                      </div>


                      <div class="row">
                        <div class="form-group col-md-6">
                          <label>Serial Number</label>
                          <input required v-model="form.serial_number" type="text" class="form-control"
                            :class="{ 'is-invalid': formErrors.serial_number, 'is-valid': form.serial_number && !formErrors.serial_number }"
                            placeholder="Enter Serial Number">
                          <InputError :message="formErrors.serial_number" class="mt-1" />
                        </div>

                        <div class="form-group col-md-6">
                          <label>Status</label>
                          <select required v-model="form.status" class="form-control"
                            :class="{ 'is-invalid': formErrors.status, 'is-valid': form.status && !formErrors.status }">
                            <option value="">-- Select Status --</option>
                            <option v-for="item in statuses" :key="item" :value="item">{{ item }}</option>
                          </select>
                          <InputError :message="formErrors.status" class="mt-1" />
                        </div>
                      </div>

                      <div class="row">
                        <div class="form-group col-md-12">
                          <label>Description</label>
                          <textarea v-model="form.description" type="text" class="form-control" :class="{
                            'is-invalid': formErrors.description,
                            'is-valid': form.description && !formErrors.description
                          }" placeholder="Description">
                                    </textarea>
                          <InputError :message="formErrors.description" class="mt-1" />
                        </div>
                      </div>
                    </div>

                    <div class="card-footer d-flex justify-content-end">
                      <button :disabled="isLoading" type="submit" class="btn btn-info mr-2">
                        <span v-if="isLoading"><i class="fas fa-spinner fa-spin"></i> Saving...</span>
                        <span v-else><i class="fas fa-save"></i> Submit</span>
                      </button>
                      <Link :href="route('security-equipments.index')" class="btn btn-secondary">
                      <i class="fas fa-times-circle"></i> Cancel
                      </Link>
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

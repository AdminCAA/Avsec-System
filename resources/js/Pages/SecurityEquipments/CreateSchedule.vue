<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import { Head, Link, useForm, router } from '@inertiajs/vue3';
import { ref, watch } from 'vue';
import Swal from 'sweetalert2';
import 'sweetalert2/dist/sweetalert2.min.css';
import InputError from '@/Components/InputError.vue';

import vSelect from 'vue-select'
import 'vue-select/dist/vue-select.css'

const { securityEquipment } = defineProps({
  securityEquipment: {
    type: Object,
    required: true
  }
});

const form = useForm({
  id: securityEquipment.id,
  last_performed_date: '',
  next_due_date: '',
  status: '',
  maintenance_type: '',
  frequency: '',
  assigned_to: '',
  description: '',
});

const isLoading = ref(false);
const formErrors = ref({});
const today = new Date().toISOString().split('T')[0];
const statuses = [
  { value: 'scheduled', label: 'Scheduled' },
  { value: 'completed', label: 'Completed' },
  { value: 'cancelled', label: 'Cancelled' }
];

const frequencyOptions = [
  { value: 'weekly', label: 'Weekly' },
  { value: 'monthly', label: 'Monthly' },
  { value: 'yearly', label: 'Yearly' }
];

const maintenanceType = [
  { value: 'replacement', label: 'Replacement' },
  { value: 'repair', label: 'Repair' },
  { value: 'inspection', label: 'Inspection' },
  { value: 'upgrade', label: 'Upgrade' }
]

function createMaintenanceSchedule() {
  isLoading.value = true;
  axios.post(route('security-equipments.storeSchedule'), form)
    .then(() => {
      Swal.fire({
        icon: 'success',
        title: 'Schedule created successfully',
        toast: true,
        position: 'top-end',
        timer: 1500,
        showConfirmButton: false
      });
      setTimeout(() => {
        router.visit(route('security-equipments.edit', securityEquipment.id));
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

watch(() => form.scheduled_date, (value) => {
  formErrors.value.scheduled_date = !value?.trim() ? 'Scheduled Date is required.'
    : value.length < 3
      ? 'Scheduled Date must be at least 3 characters.'
      : '';
});



</script>

<template>

  <Head title="Create Quality Control" />
  <AuthenticatedLayout>
    <div class="content-wrapper">
      <div class="content-header">
        <div class="container-fluid">
          <div class="row mb-2">
            <div class="col-sm-6">
              <h3 class="m-0">Maintenance Schedule / Create</h3>
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
                    <h3 class="card-title">Create Maintenance Schedule</h3>
                  </div>
                  <!-- form start -->
                  <form @submit.prevent="createMaintenanceSchedule">
                    <div class="card-body">
                      <div class="row">
                        <div class="form-group col-md-6">
                          <label>Last Performed Date</label>
                          <input required v-model="form.last_performed_date" :min="today" type="date"
                            class="form-control" :class="{
                              'is-invalid': formErrors.last_performed_date,
                              'is-valid': form.last_performed_date && !formErrors.last_performed_date
                            }" placeholder="Scheduled Date" />
                          <InputError :message="formErrors.next_due_date" class="mt-1" />
                        </div>
                        <div class="form-group col-md-6">
                          <label>Next Due Date</label>
                          <input required v-model="form.next_due_date" :min="today" type="date" class="form-control"
                            :class="{
                              'is-invalid': formErrors.next_due_date,
                              'is-valid': form.next_due_date && !formErrors.next_due_date
                            }" placeholder="Scheduled Date" />
                          <InputError :message="formErrors.next_due_date" class="mt-1" />
                        </div>
                      </div>

                      <div class="row">
                        <div class="form-group col-md-6">
                          <label>Status</label>
                          <select v-model="form.status" :class="['form-control', {
                            'is-invalid': formErrors.status,
                            'is-valid': form.status && !formErrors.status
                          }]" required>
                            <option value="">-- Select Status --</option>
                            <option v-for="status in statuses" :key="status.value" :value="status.value">
                              {{ status.label }}
                            </option>
                          </select>
                          <InputError :message="formErrors.status" class="mt-1" />
                        </div>

                        <div class="form-group col-md-6">
                          <label>Frequency</label>
                          <select v-model="form.frequency" :class="['form-control', {
                            'is-invalid': formErrors.frequency,
                            'is-valid': form.frequency && !formErrors.frequency
                          }]" required>
                            <option value="">-- Select Frequency --</option>
                            <option v-for="frequency in frequencyOptions" :key="frequency.value"
                              :value="frequency.value">
                              {{ frequency.label }}
                            </option>
                          </select>
                          <InputError :message="formErrors.frequency" class="mt-1" />
                        </div>
                      </div>

                      <div class="row">
                        <div class="form-group col-md-6">
                          <label>Maintenance Type</label>
                          <select v-model="form.maintenance_type" :class="['form-control', {
                            'is-invalid': formErrors.maintenance_type,
                            'is-valid': form.maintenance_type && !formErrors.maintenance_type
                          }]" required>
                            <option value="">-- Select Maintenance Type --</option>
                            <option v-for="type in maintenanceType" :key="type.value" :value="type.value">
                              {{ type.label }}
                            </option>
                          </select>
                          <InputError :message="formErrors.frequency" class="mt-1" />
                        </div>

                        <div class="form-group col-md-6">
                          <label>Company / Person Name</label>
                          <input required v-model="form.assigned_to" type="text" class="form-control"
                            :class="{ 'is-invalid': formErrors.assigned_to, 'is-valid': form.assigned_to && !formErrors.assigned_to }"
                            placeholder="Enter Company / Person Name">
                          <InputError :message="formErrors.assigned_to" class="mt-1" />
                        </div>
                      </div>

                      <div class="row">
                        <div class="form-group col-md-12">
                          <label>Maintenance Description</label>
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
                      <Link :href="route('security-equipments.edit', securityEquipment.id)" class="btn btn-secondary">
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

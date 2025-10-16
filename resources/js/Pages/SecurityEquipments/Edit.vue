<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import { Head,usePage, Link, useForm, router } from '@inertiajs/vue3';
import { ref, watch } from 'vue';
import dayjs from 'dayjs';
import Swal from 'sweetalert2';
import 'sweetalert2/dist/sweetalert2.min.css';
import InputError from '@/Components/InputError.vue';

import vSelect from 'vue-select'
import 'vue-select/dist/vue-select.css'

const { facilities, statuses, securityEquipment, maintainanceSchedules } = defineProps({
  securityEquipment: {
    type: Object,
    required: true
  },
  facilities: {
    type: Object,
    required: true
  },
  statuses:
  {
    type: Object,
    required: true
  },
  maintainanceSchedules: {
    type: Object,
    required: true
  }
});

const page = usePage()
  const roles = page.props.auth.user.roles;
  const hasRoles = (roles) => {
    const userRoles = page.props.auth.user?.roles ?? []
    // If a single role is passed as a string, wrap it in an array
    const requiredRoles = Array.isArray(roles) ? roles : [roles]
    return requiredRoles.some(role => userRoles.includes(role))
  }

const selectedRowId = ref(null);

const selectRow = (id) => {
  selectedRowId.value = id;
};

const form = useForm({
  name: securityEquipment.name,
  facility_id: securityEquipment.facility_id,
  serial_number: securityEquipment.serial_number,
  status: securityEquipment.status,
  description: securityEquipment.description,
});


const isLoading = ref(false);
const formErrors = ref({});

function editSecurityEquipment() {
  isLoading.value = true;
  axios.post(route('security-equipments.update', securityEquipment.id), form)
    .then(() => {
      Swal.fire({
        icon: 'success',
        title: 'Security Equipment updated successfully',
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


const deleteMaintenaceSchedule = (id) => {
  Swal.fire({
    title: 'Are you sure?',
    text: 'This action cannot be undone.',
    icon: 'warning',
    showCancelButton: true,
    confirmButtonColor: '#d33',
    cancelButtonColor: '#3085d6',
    confirmButtonText: 'Yes, delete it!'
  })
    .then((result) => {
      if (result.isConfirmed) {
        axios.delete(route('security-equipments.deleteMaintenanceSchedule', id), { data: {} })
          .then(response => {
            Swal.fire({
              icon: 'success',
              title: 'Maintenance schedule deleted successfully',
              toast: true,
              position: 'top-end',
              showConfirmButton: false,
              timer: 1000,
              timerProgressBar: true,
            });
            //redirect to the permissions index page
            setTimeout(() => {
              router.visit(route('security-equipments.edit', securityEquipment.id), {
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
            if (error.response && error.response.status === 404) {
              message = error.response.data.error;
            }
            if (error.response && error.response.status === 403) {
              message = error.response.data.errors;
            }
            Swal.fire({
              icon: "error",
              title: "Processing failed",
              text: message,
              toast: true,
              position: "top-end",
              showConfirmButton: false,
              timer: 1000,
              timerProgressBar: true,
            });
          });
      }
    })
}
</script>

<template>

  <Head title="Edit Security Equipment" />
  <AuthenticatedLayout>
    <div class="content-wrapper">
      <div class="content-header">
        <div class="container-fluid">
          <div class="row mb-2">
            <div class="col-sm-6">
              <h3 class="m-0">Security Equipment / Edit</h3>
            </div>
          </div>
        </div>
      </div>


      <div class="content">
        <div class="container-fluid">
          <div class="d-flex justify-content-center align-items-center min-vh-60  bg-light">
            <div class="row w-100 justify-content-center">
              <div class="col-md-5 mb-4">
                <!-- general form elements -->
                <div class="card card-info">
                  <div class="card-header">
                    <h3 class="card-title">Edit Security Equipment</h3>
                  </div>
                  <!-- form start -->
                  <form @submit.prevent="editSecurityEquipment">
                    <div class="card-body">
                      <!-- Name -->
                      <!-- Row 1: Name & Category -->
                      <div class="row">
                        <div class="form-group col-md-12">
                          <label>Name</label>
                          <input required v-model="form.name" type="text" class="form-control"
                            :class="{ 'is-invalid': formErrors.name, 'is-valid': form.name && !formErrors.name }"
                            placeholder="Enter Equipment Name">
                          <InputError :message="formErrors.name" class="mt-1" />
                        </div>

                        <div class="form-group col-md-12">
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
                        <div class="form-group col-md-12">
                          <label>Serial Number</label>
                          <input required v-model="form.serial_number" type="text" class="form-control"
                            :class="{ 'is-invalid': formErrors.serial_number, 'is-valid': form.serial_number && !formErrors.serial_number }"
                            placeholder="Enter Serial Number">
                          <InputError :message="formErrors.serial_number" class="mt-1" />
                        </div>

                        <div class="form-group col-md-12">
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
                        <span v-else><i class="fas fa-save"></i> Save</span>
                      </button>
                      <Link :href="route('security-equipments.index')" class="btn btn-secondary">
                      <i class="fas fa-times-circle"></i> Cancel
                      </Link>
                    </div>
                  </form>
                </div>
              </div>
              <div class="col-md-7 mb-4">
                <div class="card card-info">
                  <div class="card-header">
                    <h3 class="card-title">Security Equipment Maintenance Schedules</h3>
                  </div>

                  <!-- /.card-header -->
                  <div class="card-body">
                    <div class="row">
                      <div class="form-group d-flex justify-content-end col-md-12">
                        <Link :href="route('security-equipments.createSchedule', securityEquipment.id)"
                          class="btn btn-info">
                        <i class="fas fa-plus"></i> Add Schedule
                        </Link>
                      </div>
                    </div>
                    <!-- <div class="row mb-3">
                  <div class="col-md-3">
                    <div class="form-group">
                            <div class="input-group input-group-sm">
                                <input 
                                    type="search" 
                                    class="form-control form-control-lg" 
                                    placeholder="Search for facility here.." 
                                    v-model="search">
                                <div class="input-group-append">
                                    <button type="submit" class="btn btn-lg btn-default">
                                        <i class="fa fa-search"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                  </div>
                 </div> -->
                    <table v-if="maintainanceSchedules.length > 0" id="example2"
                      class="table table-sm table-bordered table-hover table-striped">
                      <thead>
                        <tr>
                          <th>#</th>
                          <th>L/M.Date</th>
                          <th>Next Due</th>
                          <th>Type</th>
                          <th>Status</th>
                          <!-- <th>Frequency</th>   -->
                          <th>Done By</th>

                          <th>Created</th>
                          <th>Actions</th>
                        </tr>
                      </thead>
                      <tbody>
                        <tr v-for="(schedule, index) in maintainanceSchedules" :key="schedule.id"
                          :class="{ 'table table-selected': selectedRowId === schedule.id }"
                          @click="selectRow(schedule.id)">
                          <td>{{ index + 1 }}</td>
                          <td>{{ dayjs(schedule.last_performed_date).format('DD-MM-YYYY') }}</td>
                          <td>{{ dayjs(schedule.next_due_date).format('DD-MM-YYYY') }}</td>

                          <td>{{ schedule.maintenance_type }}</td>
                          <td>{{ schedule.status }}</td>

                          <td>
                            {{ schedule.assigned_to }}
                          </td>

                          <td>{{ dayjs(schedule.created_at).format('DD-MM-YYYY') }}</td>

                          <td>
                            <div class="d-flex justify-content-end">

                              <Link class="btn btn-info btn-sm mr-2" :href="route('security-equipments.editSchedule', schedule.id)">
                          <i class="fas fa-edit"></i> <span>Edit</span>
                        </Link>
                              <button class="btn btn-danger btn-sm" @click="deleteMaintenaceSchedule(schedule.id)">
                                <i class="fas fa-trash"></i> <span></span>
                              </button>
                            </div>
                          </td>
                        </tr>

                      </tbody>
                    </table>
                  </div>
                  <!-- /.card-body -->
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

.table .table-selected {
  background-color: #4962df !important;
  /* or any other color */
  color: white !important;
  /* or any other color */
}


.table td,
.table th {
  vertical-align: middle;
}

.table th {
  text-align: center;
  background-color: #B2C6D5;
}
</style>

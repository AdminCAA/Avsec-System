<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import { Head, Link, useForm, router } from '@inertiajs/vue3';
import { ref, watch } from 'vue';
import Swal from 'sweetalert2';
import 'sweetalert2/dist/sweetalert2.min.css';
import InputError from '@/Components/InputError.vue';

const { facility, categories, departments } = defineProps({
  facility: {
    type: Object,
    required: true
  },
  categories: {
    type: Array,
    required: true
  },
  departments: {
    type: Object,
    required: true
  }
});

const form = useForm({
  name: facility.name || '',
  department_id: facility.department_id || '',
  description: facility.description || '',
  category: facility.category || '',
  location: facility.location || '',
  address: facility.address || '',
  contact_number: facility.contact_number || '',
  email: facility.email || '',
});



const isLoading = ref(false);
const formErrors = ref({});
function updateFacility() {
  isLoading.value = true;
  axios.post(route('facilities.update', facility.id), form)
    .then(() => {
      Swal.fire({
        icon: 'success',
        title: 'Operator updated successfully',
        toast: true,
        position: 'top-end',
        timer: 1500,
        showConfirmButton: false
      });
      setTimeout(() => {
        router.visit(route('facilities.index'));
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
  formErrors.value.name = !value?.trim()
    ? 'Name is required.'
    : value.length < 3
      ? 'Name must be at least 3 characters.'
      : '';
});

watch(() => form.email, (value) => {
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  formErrors.value.email = value && !emailRegex.test(value)
    ? 'Invalid email format.'
    : '';
});

</script>

<template>

  <Head title="Edit Operator" />
  <AuthenticatedLayout>
    <div class="content-wrapper">
      <div class="content-header">
        <div class="container-fluid">
          <div class="row mb-2">
            <div class="col-sm-6">
              <h3 class="m-0"><strong>Operator / Edit</strong></h3>
            </div>
            <div class="col-sm-6">
              <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item">
                  <Link class="btn btn-info" :href="route('facilities.index')"><i class="fas fa-arrow-left"></i> Back
                  </Link>
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
              <div class="col-md-10 mb-4">
                <div class="card card-info">
                  <div class="card-header">
                    <h3 class="card-title">Edit Operator</h3>
                  </div>
                  <form @submit.prevent="updateFacility">
                    <div class="card-body">
                      <!-- Row 1: Name & Category -->
                      <div class="row">
                        <div class="form-group col-md-6">
                          <label>Name</label>
                          <input required v-model="form.name" type="text" class="form-control"
                            :class="{ 'is-invalid': formErrors.name, 'is-valid': form.name && !formErrors.name }"
                            placeholder="Enter Operator Name">
                          <InputError :message="formErrors.name" class="mt-1" />
                        </div>

                        <div class="form-group col-md-6">
                          <label>Category</label>
                          <select required v-model="form.category" class="form-control"
                            :class="{ 'is-invalid': formErrors.category, 'is-valid': form.category && !formErrors.category }">
                            <option value="">-- Select --</option>
                            <option v-for="option in categories" :key="option" :value="option">{{ option }}</option>
                          </select>
                          <InputError :message="formErrors.category" class="mt-1" />
                        </div>
                      </div>


                      <!-- Row 2: Description -->
                      <div class="row">

                        <div class="form-group col-md-6">
                          <label>Area Departments</label>
                          <select required v-model="form.department_id" class="form-control"
                            :class="{ 'is-invalid': formErrors.department_id, 'is-valid': form.department_id && !formErrors.department_id }">
                            <option value="">-- Area Department --</option>
                            <option v-for="item in departments" :key="item" :value="item.id">{{ item.name }}</option>
                          </select>
                          <InputError :message="formErrors.status" class="mt-1" />
                        </div>

                        <div class="form-group col-md-6">
                          <label>Description</label>
                          <textarea v-model="form.description" class="form-control" rows="2"
                            placeholder="Optional"></textarea>
                        </div>
                      </div>

                      <!-- Row 3: Location & Address -->
                      <div class="row">
                        <div class="form-group col-md-6">
                          <label>Location</label>
                          <input v-model="form.location" type="text" class="form-control" placeholder="Location">
                        </div>

                        <div class="form-group col-md-6">
                          <label>Address</label>
                          <input v-model="form.address" type="text" class="form-control" placeholder="Physical Address">
                        </div>
                      </div>

                      <!-- Row 4: Contact & Email -->
                      <div class="row">
                        <div class="form-group col-md-6">
                          <label>Email</label>
                          <input v-model="form.email" type="email" class="form-control"
                            :class="{ 'is-invalid': formErrors.email, 'is-valid': form.email && !formErrors.email }"
                            placeholder="example@domain.com">
                          <InputError :message="formErrors.email" class="mt-1" />
                        </div>

                        <div class="form-group col-md-6">
                          <label>Contact Number</label>
                          <input v-model="form.contact_number" type="text" class="form-control"
                            placeholder="Phone Number">
                        </div>
                      </div>
                    </div>

                    <div class="card-footer d-flex justify-content-end">
                      <button :disabled="isLoading" type="submit" class="btn btn-info mr-2">
                        <span v-if="isLoading"><i class="fas fa-spinner fa-spin"></i> Saving...</span>
                        <span v-else><i class="fas fa-save"></i> Save</span>
                      </button>
                      <Link :href="route('facilities.index')" class="btn btn-secondary">
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
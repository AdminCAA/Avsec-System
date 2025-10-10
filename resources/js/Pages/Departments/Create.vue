<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import { Head, Link, useForm, router } from '@inertiajs/vue3';
import { ref, watch } from 'vue';
import Swal from 'sweetalert2';
import 'sweetalert2/dist/sweetalert2.min.css';
import InputError from '@/Components/InputError.vue';

const props = defineProps({

});

const form = useForm({
  name: '',
  description: '', 
});



const isLoading = ref(false);
const formErrors = ref({});

function createDepartment() {
  isLoading.value = true;

  axios.post(route('departments.store'), form)
    .then(() => {
      Swal.fire({
        icon: 'success',
        title: 'Department created successfully',
        toast: true,
        position: 'top-end',
        timer: 1000,
        showConfirmButton: false
      });
      setTimeout(() => {
        router.visit(route('departments.index'));
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

</script>

<template>
  <Head title="Create Department" />
  <AuthenticatedLayout>
    <div class="content-wrapper">    
        <div class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
            <div class="col-sm-6">
                <h3 class="m-0">Department / Create</h3>
            </div>
            <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item"><Link class="btn btn-info" :href="route('departments.index')"><i class="fas fa-arrow-left"></i> Back</Link></li>
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
                    <!-- general form elements -->
                    <div class="card card-info">
                        <div class="card-header">
                            <h3 class="card-title">Create Department</h3>
                        </div>
                        <!-- form start -->                        
                        <form @submit.prevent="createDepartment">
                            <div class="card-body">
                              <!-- Name -->
                               <!-- Row 1: Name & Category -->
                              <div class="row">
                                <div class="form-group col-md-6">
                                  <label>Name</label>
                                  <input required
                                    v-model="form.name" 
                                    type="text" 
                                    class="form-control"
                                    :class="{ 'is-invalid': formErrors.name, 'is-valid': form.name && !formErrors.name }"
                                    placeholder="Enter Department Name">
                                  <InputError :message="formErrors.name" class="mt-1" />
                                </div>

                                <div class="form-group col-md-6">
                                  <label>Description</label>
                                  <textarea v-model="form.description" class="form-control" rows="2" placeholder="Optional"></textarea>
                                </div>
                              </div>                                                                                         
                            </div>

                            <div class="card-footer d-flex justify-content-end">
                              <button :disabled="isLoading" type="submit" class="btn btn-info mr-2">
                                <span v-if="isLoading"><i class="fas fa-spinner fa-spin"></i> Saving...</span>
                                <span v-else><i class="fas fa-save"></i> Submit</span>
                              </button>
                              <Link :href="route('departments.index')" class="btn btn-secondary">
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
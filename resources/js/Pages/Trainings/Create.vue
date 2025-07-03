<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import { Head, Link, useForm, router } from '@inertiajs/vue3';
import { ref, watch } from 'vue';
import Swal from 'sweetalert2';
import 'sweetalert2/dist/sweetalert2.min.css';
import InputError from '@/Components/InputError.vue';


const form = useForm({
  name: '',     
  description:'',
});

const isLoading = ref(false);
const formErrors = ref({});

function createTraining() {
  isLoading.value = true;  
  axios.post(route('trainings.store'), form)
    .then(() => {
      Swal.fire({
        icon: 'success',
        title: 'Training record created successfully',
        toast: true,
        position: 'top-end',
        timer: 1500,
        showConfirmButton: false
      });
      setTimeout(() => {
        router.visit(route('trainings.index'));
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
    if (!value.trim()) {
        formErrors.value.name = 'Name is required.';
    } else if (value.trim().length < 3) {
        formErrors.value.name = 'Name must be at least 3 characters.';
    } else {
        formErrors.value.name = '';
    }
});
       
</script>

<template>
  <Head title="Create Training" />
  <AuthenticatedLayout>
    <div class="content-wrapper">    
        <div class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h3 class="m-0">Training  / Create</h3>
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
                            <h3 class="card-title">Create Training Record</h3>
                        </div>
                        <!-- form start -->                        
                        <form @submit.prevent="createTraining">
                            <div class="card-body">
                              <!-- Name -->
                               <!-- Row 1: Name & Category -->
                               <div class="row">
                                    <div class="form-group col-md-12">
                                    <label>Training Name</label>
                                    <input required
                                        v-model="form.name" 
                                        type="text" 
                                        class="form-control"
                                        :class="{ 'is-invalid': formErrors.name, 'is-valid': form.name && !formErrors.name }"
                                        placeholder="Enter Training Name">
                                    <InputError :message="formErrors.name" class="mt-1" />
                                    </div>                                                                                                    
                                </div>                            
                             

                              

                                <div class="row">
                                    <div class="form-group col-md-12">
                                    <label>Description</label>
                                    <textarea
                                        v-model="form.description" 
                                        type="text" 
                                        class="form-control"
                                        :class="{ 
                                            'is-invalid': formErrors.description, 
                                            'is-valid': form.description && !formErrors.description 
                                        }"
                                        placeholder="Description">
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
                              <Link :href="route('trainings.index')" class="btn btn-secondary">
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

</style>

<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import { Head, Link, useForm, router } from '@inertiajs/vue3';
import { ref, watch } from 'vue';
import Swal from 'sweetalert2';
import 'sweetalert2/dist/sweetalert2.min.css';
import InputError from '@/Components/InputError.vue';
import 'vue-select/dist/vue-select.css'


const segments = window.location.pathname.split('/');
const id  = segments[2];
const form = useForm({
    title: '',
    user_id: '',
    user_name: '',
    selected_checklist_question_id: id,  
    followup_comments: '',
    followup_date: '',
});

const isLoading = ref(false);
const formErrors = ref({});

function createFollowupControl() {
  isLoading.value = true;  
  axios.post(route('followups.store',id), form)
    .then(() => {
      Swal.fire({
        icon: 'success',
        title: 'Followup created successfully',
        toast: true,
        position: 'top-end',
        timer: 1500,
        showConfirmButton: false
      });
      setTimeout(() => {
        router.visit(route('securityconcerns.edit', id), {
          preserveScroll: true,
          replace: true
        });
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
    watch(() => form.title, (value) => {
    formErrors.value.title = !value?.trim()? 'Title is required.'
        : value.length < 3
        ? 'Title must be at least 3 characters.'
        : '';
    });

    watch(() => form.followup_date, (value) => {
    formErrors.value.followup_date = !value?.trim()? 'Followup Date is required.'
        : value.length < 3
        ? 'Follow Date must be at least 3 characters.'
        : '';
    });
</script>

<template>
  <Head title="Create Follow-Up" />
  <AuthenticatedLayout>
    <div class="content-wrapper">    
        <div class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h3 class="m-0">Follow-Up / Create</h3>
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
                            <h3 class="card-title">Create Follow up</h3>
                        </div>
                        <!-- form start -->                        
                        <form @submit.prevent="createFollowupControl">
                            <div class="card-body">
                              <!-- Name -->
                               <!-- Row 1: Name & Category -->
                                <div class="row">
                                    <div class="form-group col-md-6">
                                    <label>Title</label>
                                    <input required
                                        v-model="form.title" 
                                        type="text" 
                                        class="form-control"
                                        :class="{ 'is-invalid': formErrors.title, 'is-valid': form.title && !formErrors.title }"
                                        placeholder="Enter Title">
                                    <InputError :message="formErrors.title" class="mt-1" />
                                    </div>

                                    <div class="form-group col-md-6">
                                    <label>Date</label>
                                    <input 
                                        required 
                                        v-model="form.followup_date"                                         
                                        type="date"
                                        class="form-control"
                                        :class="{ 
                                        'is-invalid': formErrors.followup_date, 
                                        'is-valid': form.followup_date && !formErrors.followup_date 
                                        }"
                                        placeholder="Start Date"
                                    />
                                    <InputError :message="formErrors.followup_date" class="mt-1" />
                                    </div>
                                </div>                            
                                

                                 <!-- Row 2: Description -->
                              <div class="row">
                                <div class="form-group col-md-12">
                                  <label>Follow up Remarks</label>
                                  <textarea v-model="form.followup_comments" class="form-control" rows="2" placeholder="Optional"></textarea>
                                </div>
                              </div>                                                                               
                              
                            </div>

                            <div class="card-footer d-flex justify-content-end">
                              <button :disabled="isLoading" type="submit" class="btn btn-info mr-2">
                                <span v-if="isLoading"><i class="fas fa-spinner fa-spin"></i> Saving...</span>
                                <span v-else><i class="fas fa-save"></i> Save</span>
                              </button>
                              <Link :href="route('securityconcerns.edit',id)" class="btn btn-secondary">
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

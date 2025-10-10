<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import { Head, Link, useForm, router } from '@inertiajs/vue3';
import { ref, watch } from 'vue';
import Swal from 'sweetalert2';
import 'sweetalert2/dist/sweetalert2.min.css';
import InputError from '@/Components/InputError.vue';

import vSelect from 'vue-select'
import 'vue-select/dist/vue-select.css'

const {auditCategories, auditQuestion} = defineProps({
  auditCategories: {
    type: Object,
    required: true
  },
  auditQuestion: {
        type: Object,
        required: true
    },
});

const form = useForm({
  question: auditQuestion.question,
  audit_area_category_id: auditQuestion.audit_area_category_id,    
});

const isLoading = ref(false);
const formErrors = ref({});

function editAuditQuestion() {
  isLoading.value = true;  
  axios.post(route('audit-questions.update', auditQuestion.id), form)
    .then(() => {
      Swal.fire({
        icon: 'success',
        title: 'Audit Question updated successfully',
        toast: true,
        position: 'top-end',
        timer: 1500,
        showConfirmButton: false
      });
      setTimeout(() => {
        router.visit(route('audit-questions.index'));
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
watch(() => form.question, (value) => {
  formErrors.value.question = !value?.trim()? 'Audit Question is required.'
    : value.length < 3
    ? 'Question must be at least 3 characters.'
    : '';
});

watch(() => form.audit_area_category_id, (value) => {
  formErrors.value.audit_area_category_id = !value? 'Audit Area is required.'
    : value.length < 3
    ? 'Audit area  must be at least 3 characters.'
    : '';
});
</script>

<template>
  <Head title="Edit Audit Question" />
  <AuthenticatedLayout>
    <div class="content-wrapper">    
        <div class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h3 class="m-0"><strong>Audit Question / Edit</strong></h3>
                    </div>                
                </div>
            </div>
        </div>

        <div class="content">
            <div class="container-fluid">
                <div class="d-flex justify-content-center align-items-center min-vh-60  bg-light">
                    <div class="row w-100 justify-content-center">
                        <div class="col-md-8 mb-4">                    
                            <!-- general form elements -->
                            <div class="card card-info">
                                <div class="card-header">
                                    <h3 class="card-title">Edit Audit Question</h3>
                                </div>
                                <!-- form start -->                        
                                <form @submit.prevent="editAuditQuestion">
                                    <div class="card-body">
                                    <!-- Name -->
                                    <!-- Row 1: Name & Category -->
                                        <div class="row">
                                            <div class="form-group col-md-12">
                                            <label>Question</label>
                                            <textarea required
                                                v-model="form.question" 
                                                type="text" 
                                                class="form-control"
                                                :class="{ 
                                                    'is-invalid': formErrors.question, 
                                                    'is-valid': form.question && !formErrors.question 
                                                }"
                                                placeholder="Enter Question">
                                            </textarea>

                                            <InputError :message="formErrors.question" class="mt-1" />
                                            </div>

                                            <div class="form-group col-md-12">                                    
                                            <label>Audit Area Category</label>                                        
                                            <v-select
                                                v-model="form.audit_area_category_id"
                                                :options="auditCategories"
                                                :reduce="audityCategory => audityCategory.id"
                                                label="name"
                                                placeholder="-- Select Audi Area Category --"
                                                :class="{
                                                    'is-invalid': formErrors.audit_area_category_id,
                                                    'is-valid': form.audit_area_category_id && !formErrors.audit_area_category_id
                                                }"
                                            />
                                            <InputError :message="formErrors.audit_area_category_id" class="mt-1" />
                                            </div>
                                        </div>                                                                                                                                                                                                                                                        
                                    </div>

                                    <div class="card-footer d-flex justify-content-end">
                                    <button :disabled="isLoading" type="submit" class="btn btn-info mr-2">
                                        <span v-if="isLoading"><i class="fas fa-spinner fa-spin"></i> Saving...</span>
                                        <span v-else><i class="fas fa-save"></i> Save</span>
                                    </button>
                                    <Link :href="route('audit-questions.index')" class="btn btn-secondary">
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

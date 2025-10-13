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
  reference: auditQuestion.reference,
  risk_description: auditQuestion.risk_description,
});

const isLoading = ref(false);
const formErrors = ref({});

function editAuditQuestion() {
  if (!form.question || !form.audit_area_category_id ) {
    Swal.fire({
      icon: 'error',
      title: 'Please fix the validation errors before submitting.',
      toast: true,
      position: 'top-end',
      timer: 3000,
      showConfirmButton: false
    });
    return;
  }

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

watch(() => form.risk_description, (value) => {
  formErrors.value.risk_description = value && value.length < 3
    ? 'Risk description must be at least 3 characters.'
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
                                            <div v-if="form.question && !formErrors.question"
                                              class="valid-feedback d-block">
                                              Question looks good!
                                            </div>
                                            </div>
                                            

                                            <div class="form-group col-md-6">                                    
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
                                                <div v-if="form.audit_area_category_id && !formErrors.audit_area_category_id"
                                                  class="valid-feedback d-block">
                                                  Audit Area Category looks good!
                                                </div>
                                            </div>

                                            <div class="form-group col-md-6">
                                              <label>Reference</label>
                                              <input
                                                v-model="form.reference" 
                                                type="text" 
                                                class="form-control"
                                                :class="{ 
                                                    'is-invalid': formErrors.reference, 
                                                    'is-valid': form.reference && !formErrors.reference 
                                                }"
                                                  placeholder="Enter Reference (Optional)"/>                                    
                                          
                                              <InputError :message="formErrors.reference || form.errors.reference"
                                              class="mt-2" />
                                              <div v-if="form.reference && !formErrors.reference"
                                                  class="valid-feedback d-block">
                                                  Reference looks good!
                                              </div>
                                            </div>

                                          <div class="form-group col-md-12">
                                              <label>Risk Description</label>
                                              <textarea
                                                v-model="form.risk_description" 
                                                type="text" 
                                                class="form-control"
                                                :class="{ 
                                                    'is-invalid': formErrors.risk_description, 
                                                    'is-valid': form.risk_description && !formErrors.risk_description 
                                                }"
                                                placeholder="Enter Risk Description (Optional)">
                                              </textarea>

                                            <InputError :message="formErrors.risk_description || form.errors.risk_description"
                                                class="mt-2" />
                                            <div v-if="form.risk_description && !formErrors.risk_description"
                                                class="valid-feedback d-block">
                                              Risk Description looks good!
                                            </div>
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

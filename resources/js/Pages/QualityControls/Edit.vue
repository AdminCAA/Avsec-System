<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import { Head, Link, useForm, router } from '@inertiajs/vue3';
import { ref, watch ,computed} from 'vue';
import Swal from 'sweetalert2';
import 'sweetalert2/dist/sweetalert2.min.css';
import InputError from '@/Components/InputError.vue';

import vSelect from 'vue-select'
import 'vue-select/dist/vue-select.css'

const { 
    qualityControl,
    facilities,
    qualityControlTypes,
    hasChecklistQuestions,
    auditQuestions,
    groupedAuditQuestions
} = defineProps({ 
    groupedAuditQuestions: {
        type: Object,
        required: true
  },
    auditQuestions:{
        type:Object,
        required:true
    },
    qualityControl:{
        type: Object,
        required: true
    },
  facilities: {
    type: Object,
    required: true
  },
  qualityControlTypes: {
    type: Array,
    required: true
  },
  hasChecklistQuestions: {
    type: Array,
    required: true
  },
  
});
const statusOptions = [
  { label: 'In Progress', value: 'In Progress' },
  { label: 'Pending', value: 'Pending' }, 
  { label: 'Completed', value: 'Completed' },  
  { label: 'Overdue', value: 'Overdue' },  
];
const form = useForm({
  title: qualityControl.title,
  control_type: qualityControl.control_type,  
  description: qualityControl.description,
  facility_id: qualityControl.facility_id,
  scheduled_date: qualityControl.scheduled_date,  
  end_date: qualityControl.end_date || '', 
  status: qualityControl.status || 'Pending' 
});

const selectedCheckListQuestions = ref([]); // This will hold the selected checklist IDs
selectedCheckListQuestions.value = hasChecklistQuestions;

const isLoading = ref(false);
const formErrors = ref({});

function editQualityControl() {
  isLoading.value = true;  
  axios.post(route('quality-controls.update', qualityControl.id), {
    title: form.title || '', // Ensure title is always a string
    control_type: form.control_type || '', // Ensure control_type is always a string
    description: form.description || '', // Ensure description is always a string
    facility_id: form.facility_id || '', // Ensure facility_id is always a string
    scheduled_date: form.scheduled_date || '', // Ensure scheduled_date is always a string
    end_date: form.end_date || '',
    status: form.status || '', // Ensure status is always a string
    selectedCheckListQuestions: selectedCheckListQuestions.value 
  })
    .then(() => {
      Swal.fire({
        icon: 'success',
        title: 'Quality control updated successfully',
        toast: true,
        position: 'top-end',
        timer: 1500,
        showConfirmButton: false
      });
      setTimeout(() => {
        router.visit(route('quality-controls.index'));
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

watch(() => form.control_type, (value) => {
  formErrors.value.control_type = !value?.trim()? 'Control Type is required.'
    : value.length < 3
    ? 'Control Type must be at least 3 characters.'
    : '';
});
watch(() => form.scheduled_date, (value) => {
  formErrors.value.scheduled_date = !value?.trim()? 'Scheduled Date is required.'
    : value.length < 3
    ? 'Scheduled Date must be at least 3 characters.'
    : '';
});

watch(() => form.status, (value) => {
  formErrors.value.status = !value? 'Status is required.'
    : value.length < 3
    ? 'Status must be at least 3 characters.'
    : '';
});

watch(() => form.end_date, (value) => {
  //End date is required
  formErrors.value.end_date = !value?.trim()? 'End Date is required.'
    : value.length < 3
    ? 'End Date must be at least 3 characters.'
    : '';
  // Check if end date is after scheduled date
  if (form.scheduled_date && value && new Date(value) < new Date(form.scheduled_date)) {
    formErrors.value.end_date = 'End Date must be after Start Date.';
  } else if (formErrors.value.end_date === 'End Date must be after Scheduled Date.') {
    formErrors.value.end_date = '';
  }
});
watch(() => form.facility_id, (value) => {
  formErrors.value.facility_id = !value? 'Operator is required.'
    : value.length < 3
    ? 'Operator must be at least 3 characters.'
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
                    <h3 class="m-0">Quality Control</h3>
                </div>    
                <div class="col-sm-6">
                  <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item"><Link class="btn btn-info" :href="route('quality-controls.index')"><i class="fas fa-arrow-left"></i> Back</Link></li>
                    <li class="breadcrumb-item">
                      <Link class="btn btn-success mr-2"
                      :class="{ 'disabled': hasChecklistQuestions.length === 0 }"
                      @click.prevent="hasChecklistQuestions.length === 0"  
                      :href="route('quality-controls.show',qualityControl.id)"><i class="fas fa-play"></i> 
                        Start {{ qualityControl.control_type }}
                    </Link></li>             
                  </ol>
                </div><!-- /.col -->            
            </div>
        </div>
        </div>
   

    <div class="content">
      <div class="container-fluid">
        <div class="d-flex justify-content-center align-items-center min-vh-60  bg-light">
            <div class="row w-100 justify-content-center">
                <div class="col-md-12 mb-4">                    
                    <!-- general form elements -->
                    <div class="card card-info">
                        <div class="card-header">
                            <h3 class="card-title">Edit Quality Control</h3>
                        </div>
                        <!-- form start -->                        
                        <form @submit.prevent="editQualityControl">
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
                                    <label>Control Type</label>
                                    <select required v-model="form.control_type" class="form-control"
                                        :class="{ 'is-invalid': formErrors.control_type, 'is-valid': form.control_type && !formErrors.control_type }"
                                    >
                                        <option value="">-- Select Control Type --</option>
                                        <option v-for="item in qualityControlTypes" :key="item" :value="item">{{ item }}</option>
                                    </select>
                                    <InputError :message="formErrors.control_type" class="mt-1" />
                                    </div>
                                </div>                            
                             

                                <div class="row">
                                    <div class="form-group col-md-6">                                    
                                      <label>Operator</label>                                        
                                      <v-select
                                          v-model="form.facility_id"
                                          :options="facilities"
                                          :reduce="facility => facility.id"
                                          label="name"
                                          placeholder="-- Select Operator --"
                                          :class="{
                                          'is-invalid': formErrors.facility_id,
                                          'is-valid': form.facility_id && !formErrors.facility_id
                                          }"
                                      />
                                      <InputError :message="formErrors.facility_id" class="mt-1" />
                                    </div>

                                    <div class="form-group col-md-6">
                                    <label>Status</label>
                                    <select required v-model="form.status" class="form-control"
                                        :class="{ 'is-invalid': formErrors.status, 'is-valid': form.status && !formErrors.status }"
                                    >
                                        <option value="">-- Select Status --</option>
                                        <option v-for="item in statusOptions" :key="item" :value="item.value">{{ item.label }}</option>
                                    </select>
                                    <InputError :message="formErrors.status" class="mt-1" />
                                    </div>                                                                      
                                  </div>   

                                  <div class="row">
                                    <div class="form-group col-md-6">
                                      <label>Date</label>
                                      <input 
                                          required 
                                          v-model="form.scheduled_date"                                         
                                          type="date"
                                          class="form-control"
                                          :class="{ 
                                          'is-invalid': formErrors.scheduled_date, 
                                          'is-valid': form.scheduled_date && !formErrors.scheduled_date 
                                          }"
                                          placeholder="Start Date"
                                      />
                                      <InputError :message="formErrors.scheduled_date" class="mt-1" />
                                      </div>     
                                      
                                      <div class="form-group col-md-6">
                                    <label>End Date</label>
                                    <input 
                                        required 
                                        v-model="form.end_date" 
                                        :min="today"
                                        type="date"
                                        class="form-control"
                                        :class="{ 
                                          'is-invalid': formErrors.end_date, 
                                          'is-valid': form.end_date && !formErrors.end_date 
                                        }"
                                        placeholder="End Date"
                                    />
                                    <InputError :message="formErrors.end_date" class="mt-1" />
                                    </div>  
                                  </div>

                              <!-- Row 2: Description -->
                              <div class="row">
                                <div class="form-group col-md-12">
                                  <label>Description</label>
                                  <textarea v-model="form.description" class="form-control" rows="2" placeholder="Optional"></textarea>
                                </div>
                              </div>                                                                          
                              
                              <label class="d-flex justify-content-center" for="name">Select Quality Control Checklist Questions</label>                            
                              <div class="row">
                                  <div class="col-md-12" v-for="(questions, area) in groupedAuditQuestions"
                                  :key="area" >
                                      <div v-if="area?.toLowerCase?.().includes((qualityControl?.facility?.category ?? '').toLowerCase())" class="col-md-12"                                                                                
                                  >
                                      <div class="card card-info collapsed-card shadow-sm">
                                      <div class="card-header">
                                          <h3 style="font-weight: bold;" class="card-title">{{ area }}</h3>
                                          <div class="card-tools">
                                          <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                            <i class="fas fa-plus"></i>
                                          </button>
                                          </div>
                                      </div>

                                      <div v-for="question in questions" :key="question.id" class="card-body">
                                          <div class="custom-control custom-checkbox mr-3 mb-2">
                                          <input
                                              class="custom-control-input"
                                              :id="'question-' + question.id"
                                              type="checkbox"
                                              v-model="selectedCheckListQuestions"
                                              :value="question.id"
                                          />
                                          <label :for="'question-' + question.id" class="custom-control-label">
                                              {{ question.question }}
                                          </label>
                                          </div>
                                      </div>
                                      </div>
                                  </div>
                                  </div>
                                  
                              </div>
                            </div>

                            



                            <div class="card-footer d-flex justify-content-end">
                              <button :disabled="isLoading" type="submit" class="btn btn-info mr-2">
                                <span v-if="isLoading"><i class="fas fa-spinner fa-spin"></i> Saving...</span>
                                <span v-else><i class="fas fa-save"></i> Save</span>
                              </button>
                              <Link :href="route('quality-controls.index')" class="btn btn-secondary">
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
    .disabled {
      pointer-events: none;
      opacity: 0.6;
      cursor: not-allowed;
    }
</style>

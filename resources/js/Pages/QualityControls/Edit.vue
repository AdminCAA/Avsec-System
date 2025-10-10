<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import { Head, Link, useForm, router } from '@inertiajs/vue3';
import { ref, watch, computed } from 'vue';
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
  groupedAuditQuestions,
  users,
  hasAssignedUsers,
  departments
} = defineProps({
  groupedAuditQuestions: {
    type: Object,
    required: true
  },
  auditQuestions: {
    type: Object,
    required: true
  },
  qualityControl: {
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
  users: {
    type: Object,
    required: true
  },
  hasAssignedUsers: {
    type: Array,
    required: true
  },
  departments: {
    type: Object,
    required: true
  }

});



const selectedUsers = ref([]);

selectedUsers.value = hasAssignedUsers;

const statusOptions = [
  { label: 'In Progress', value: 'In Progress' },
  { label: 'Pending', value: 'Pending' },
  { label: 'Completed', value: 'Completed' },
  { label: 'Overdue', value: 'Overdue' },
];

const form = useForm({
  title: qualityControl.title,
  department_id: qualityControl.department_id || '',
  department_name: qualityControl.department_name || '',
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
  form.department_name = departments.find(dept => dept.id === form.department_id)?.name || '';
  axios.post(route('quality-controls.update', qualityControl.id), {
    department_id: form.department_id || '', // Ensure department_id is always a string
    department_name: form.department_name || '', // Ensure department_name is always a string
    title: form.title || '', // Ensure title is always a string
    control_type: form.control_type || '', // Ensure control_type is always a string
    description: form.description || '', // Ensure description is always a string
    facility_id: form.facility_id || '', // Ensure facility_id is always a string
    scheduled_date: form.scheduled_date || '', // Ensure scheduled_date is always a string
    end_date: form.end_date || '',
    status: form.status || '', // Ensure status is always a string
    selectedCheckListQuestions: selectedCheckListQuestions.value,
    selectedUsers: selectedUsers.value || [] // Ensure selectedUsers is always an array
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
  formErrors.value.title = !value?.trim() ? 'Title is required.'
    : value.length < 3
      ? 'Title must be at least 3 characters.'
      : '';
});

watch(() => form.control_type, (value) => {
  formErrors.value.control_type = !value?.trim() ? 'Control Type is required.'
    : value.length < 3
      ? 'Control Type must be at least 3 characters.'
      : '';
});
watch(() => form.scheduled_date, (value) => {
  formErrors.value.scheduled_date = !value?.trim() ? 'Scheduled Date is required.'
    : value.length < 3
      ? 'Scheduled Date must be at least 3 characters.'
      : '';
});

watch(() => form.status, (value) => {
  formErrors.value.status = !value ? 'Status is required.'
    : value.length < 3
      ? 'Status must be at least 3 characters.'
      : '';
});

watch(() => form.end_date, (value) => {
  //End date is required
  formErrors.value.end_date = !value?.trim() ? 'End Date is required.'
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
  formErrors.value.facility_id = !value ? 'Operator is required.'
    : value.length < 3
      ? 'Operator must be at least 3 characters.'
      : '';
});

const canStart = computed(() => {
  return hasChecklistQuestions.length > 0 && hasAssignedUsers.length > 0;
});

const handleClick = () => {
  if (!canStart) return;
  router.visit(route('quality-controls.show', qualityControl.id));
};





</script>

<template>

  <Head title="Create Quality Control" />
  <AuthenticatedLayout>
    <div class="content-wrapper">
      <div class="content-header">
        <div class="container-fluid">
          <div class="row mb-2">
            <div class="col-sm-6">
              <h3 class="m-0">
                <Link :href="route('facilities.show', qualityControl.facility_id)"><strong>{{
                  qualityControl.facility.name }}</strong> - Quality Control</Link>
              </h3>
            </div>
            <div class="col-sm-6">
              <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item">
                  <button class="btn btn-success mr-2" :class="{ 'disabled': !canStart }" @click.prevent="handleClick"
                    :href="route('quality-controls.show', qualityControl.id)">
                    <i class="fas fa-binoculars"></i>
                    Start {{ qualityControl.control_type }}
                  </button>
                </li>
                <li class="breadcrumb-item">
                  <Link class="btn btn-info" :href="route('quality-controls.index')"><i class="fas fa-arrow-left"></i>
                  Back</Link>
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
<<<<<<< HEAD
                <div class="col-md-12 mb-4">                         
                    <!-- general form elements -->
                    <div class="card card-info">
                        <div class="card-header">
                            <h3 class="card-title">Quality Control Information</h3>
                        </div>
                        <!-- form start -->                        
                        <form @submit.prevent="editQualityControl">
                            <div class="card-body">   
                              <div class="col-sm-6">
                                  <h3 class="mb-2">Quality Control Information</h3>
                              </div>                                                 
                              <div class="row">
                                  <div class="col-md-12">                                      
                                      <div class="card card-info collapsed-card shadow-sm">
                                        <div class="card-header">
                                            <h3 style="font-weight: bold;" class="card-title" data-card-widget="collapse">Basic Information</h3>
                                            <div class="card-tools">
                                            <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                              <i class="fas fa-plus"></i>
                                            </button>
                                            </div>
                                        </div>                                      
                                        <div  class="card-body">            
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
                                              <label>Target Operator</label>                                        
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
                                            <label>Departments</label>
                                            <select required v-model="form.department_id" class="form-control"
                                                :class="{ 'is-invalid': formErrors.department_id, 'is-valid': form.department_id && !formErrors.department_id }"
                                            >
                                                <option value="">-- Area Department --</option>
                                                <option v-for="item in departments" :key="item" :value="item.id">{{ item.name }}</option>
                                            </select>
                                            <InputError :message="formErrors.status" class="mt-1" />
                                            </div>


                                                                                                                
                                          </div>   

                                          <div class="row">
                                            <div class="form-group col-md-6">
                                              <label>Start Date</label>
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

                                          <div class="form-group col-md-6">
                                            <label>Description</label>
                                            <textarea v-model="form.description" class="form-control" rows="2" placeholder="Optional"></textarea>
                                          </div>
                                        </div>
                                          
                                      </div>
                                    </div>                                  
                                  </div>                                  
                              </div>
                                                                                                                                      
                              
                              <div class="col-sm-6">
                                <h3 class="mb-2">Responsible Inspectors</h3>
                              </div>                            
                              <div class="row">
                                <div class="col-md-12">                                      
                                      <div class="card card-info collapsed-card shadow-sm">
                                        <div class="card-header">
                                            <h3 style="font-weight: bold;" class="card-title" data-card-widget="collapse">Assign Inspectors</h3>
                                            <div class="card-tools">
                                            <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                              <i class="fas fa-plus"></i>
                                            </button>
                                            </div>
                                        </div>                                      
                                        <div  class="card-body">                                                      
                                          <div class="card card-info card-outline">                                                
                                            <div v-if="users.length > 0" class="form-group d-flex flex-wrap card-body">                                                                                                                                                                                                         
                                                <div 
                                                    class="custom-control custom-checkbox mr-3 mb-2" 
                                                    v-for="(user, index) in users" :key="user.id">
                                                      <input class="custom-control-input" 
                                                        :id="'user-' + user.id"
                                                        type="checkbox"                                               
                                                        v-model="selectedUsers"                                                
                                                        :value="user.id"
                                                      >
                                                      <label :for="'user-' + user.id" class="custom-control-label">
                                                        <Link :href="route('personnels.show', user.id)" class="d-flex align-items-center">
                                                            <!-- User Avatar -->                                                     
                                                          <span class="badge px-1 mr-2" style="border-radius:10px; background-color:whitesmoke ;">
                                                            <img class="profile-user-img img-fluid img-circle"
                                                                :src="user.portrait ? `/storage/${user.portrait}`: '/storage/portraits/avatar.png'"
                                                                alt="User profile picture">{{ user.name }}                              
                                                            </span>
                                                          </Link>
                                                      </label>
                                                </div>
                                            </div>                                           
                                        </div>  
                                        </div>
                                    </div>                                  
                                  </div>
                              </div>  

                              <div class="col-sm-6">
                                <h3 class="mb-2">Approving  Inspectors</h3>
                              </div>                            
                              <div class="row">
                                <div class="col-md-12">                                      
                                      <div class="card card-info collapsed-card shadow-sm">
                                        <div class="card-header">
                                            <h3 style="font-weight: bold;" class="card-title" data-card-widget="collapse">Assign Inspectors</h3>
                                            <div class="card-tools">
                                            <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                              <i class="fas fa-plus"></i>
                                            </button>
                                            </div>
                                        </div>                                      
                                        <div  class="card-body">            
                                          
                                          <div class="card card-info card-outline">    
                                            
                                            <div v-if="users.length > 0" class="form-group d-flex flex-wrap card-body">                                                                                                                                                                                                         
                                                <div 
                                                    class="custom-control custom-checkbox mr-3 mb-2" 
                                                    v-for="(user, index) in users" :key="user.id">
                                                    <input class="custom-control-input" 
                                                        :id="'user-' + user.id"
                                                        type="checkbox"                                               
                                                        v-model="selectedUsers"                                                
                                                        :value="user.id">
                                                    <label :for="'user-' + user.id" class="custom-control-label">
                                                      <Link :href="route('personnels.show', user.id)" class="d-flex align-items-center">
                                                          <!-- User Avatar -->                                                     
                                                        <span class="badge px-1 mr-2" style="border-radius:10px; background-color:whitesmoke ;">
                                                          <img class="profile-user-img img-fluid img-circle"
                                                              :src="user.portrait ? `/storage/${user.portrait}`: '/storage/portraits/avatar.png'"
                                                              alt="User profile picture">
                                                              {{ user.name }}                              
                                                          </span>

                                                         </Link>
                                                    </label>
                                                </div>
                                            </div>                                           
                                        </div>  
                                        </div>
                                    </div>                                  
                                  </div> 
                              </div>  
=======
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
                          <input required v-model="form.title" type="text" class="form-control"
                            :class="{ 'is-invalid': formErrors.title, 'is-valid': form.title && !formErrors.title }"
                            placeholder="Enter Title">
                          <InputError :message="formErrors.title" class="mt-1" />
                        </div>

                        <div class="form-group col-md-6">
                          <label>Control Type</label>
                          <select required v-model="form.control_type" class="form-control"
                            :class="{ 'is-invalid': formErrors.control_type, 'is-valid': form.control_type && !formErrors.control_type }">
                            <option value="">-- Select Control Type --</option>
                            <option v-for="item in qualityControlTypes" :key="item" :value="item">{{ item }}</option>
                          </select>
                          <InputError :message="formErrors.control_type" class="mt-1" />
                        </div>
                      </div>


                      <div class="row">
                        <div class="form-group col-md-6">
                          <label>Target Operator</label>
                          <v-select v-model="form.facility_id" :options="facilities" :reduce="facility => facility.id"
                            label="name" placeholder="-- Select Operator --" :class="{
                              'is-invalid': formErrors.facility_id,
                              'is-valid': form.facility_id && !formErrors.facility_id
                            }" />
                          <InputError :message="formErrors.facility_id" class="mt-1" />
                        </div>
                        <div class="form-group col-md-6">
                          <label>Departments</label>
                          <select required v-model="form.department_id" class="form-control"
                            :class="{ 'is-invalid': formErrors.department_id, 'is-valid': form.department_id && !formErrors.department_id }">
                            <option value="">-- Area Department --</option>
                            <option v-for="item in departments" :key="item" :value="item.id">{{ item.name }}</option>
                          </select>
                          <InputError :message="formErrors.status" class="mt-1" />
                        </div>
                      </div>

                      <div class="row">
                        <div class="form-group col-md-6">
                          <label>Start Date</label>
                          <input required v-model="form.scheduled_date" type="date" class="form-control" :class="{
                            'is-invalid': formErrors.scheduled_date,
                            'is-valid': form.scheduled_date && !formErrors.scheduled_date
                          }" placeholder="Start Date" />
                          <InputError :message="formErrors.scheduled_date" class="mt-1" />
                        </div>

                        <div class="form-group col-md-6">
                          <label>End Date</label>
                          <input required v-model="form.end_date" type="date" class="form-control" :class="{
                            'is-invalid': formErrors.end_date,
                            'is-valid': form.end_date && !formErrors.end_date
                          }" placeholder="End Date" />
                          <InputError :message="formErrors.end_date" class="mt-1" />
                        </div>
                      </div>

                      <!-- Row 2: Description -->
                      <div class="row">
                        <div class="form-group col-md-6">
                          <label>Status</label>
                          <select required v-model="form.status" class="form-control"
                            :class="{ 'is-invalid': formErrors.status, 'is-valid': form.status && !formErrors.status }">
                            <option value="">-- Select Status --</option>
                            <option v-for="item in statusOptions" :key="item" :value="item.value">{{ item.label }}
                            </option>
                          </select>
                          <InputError :message="formErrors.status" class="mt-1" />
                        </div>

                        <div class="form-group col-md-6">
                          <label>Description</label>
                          <textarea v-model="form.description" class="form-control" rows="2"
                            placeholder="Optional"></textarea>
                        </div>
                      </div>
>>>>>>> 38f8373b61a9793faa640ae28cb592a362ddca11

                      <div class="col-sm-6">
                        <h3 class="mb-2"><strong>Responsible Inspectors</strong></h3>
                      </div>
                      <div class="row">
                        <div class="col-sm-12">
                          <div class="card card-info card-outline">
                            <div class="card-header">
                              <h5 class="card-title"><strong>Assign Inspectors</strong></h5>
                            </div>
                            <div v-if="users.length > 0" class="form-group d-flex flex-wrap card-body">
                              <div class="custom-control custom-checkbox mr-3 mb-2" v-for="(user, index) in users"
                                :key="user.id">
                                <input class="custom-control-input" :id="'user-' + user.id" type="checkbox"
                                  v-model="selectedUsers" :value="user.id">
                                <label :for="'user-' + user.id" class="custom-control-label">
                                  <Link :href="route('personnels.show', user.id)" class="d-flex align-items-center">
                                  <!-- User Avatar -->
                                  <span class="badge px-1 mr-2"
                                    style="border-radius:10px; background-color:whitesmoke ;">
                                    <img class="profile-user-img img-fluid img-circle"
                                      :src="user.portrait ? `/storage/${user.portrait}` : '/storage/portraits/avatar.png'"
                                      alt="User profile picture">
                                    {{ user.name }}
                                  </span>

                                  </Link>
                                </label>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>

                      <div class="col-sm-6">
                        <h3 class="mb-2"><strong>Select Quality Control Checklist Questions</strong></h3>
                      </div>
                      <div class="row">
                        <div class="col-md-12" v-for="(questions, area) in groupedAuditQuestions" :key="area">
                          <div
                            v-if="area?.toLowerCase?.().includes((qualityControl?.facility?.category ?? '').toLowerCase())"
                            class="col-md-12">
                            <div class="card card-info collapsed-card shadow-sm">
                              <div class="card-header">
                                <h3 style="font-weight: bold;" class="card-title" data-card-widget="collapse">{{ area }}
                                </h3>
                                <div class="card-tools">
                                  <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                    <i class="fas fa-plus"></i>
                                  </button>
                                </div>
                              </div>

                              <div v-for="question in questions" :key="question.id" class="card-body">
                                <div class="custom-control custom-checkbox mr-3 mb-2">
                                  <input class="custom-control-input" :id="'question-' + question.id" type="checkbox"
                                    v-model="selectedCheckListQuestions" :value="question.id" />
                                  <label :for="'question-' + question.id" class="custom-control-label">
                                    {{ question.question }}
                                  </label>
                                </div>
                              </div>
                            </div>
<<<<<<< HEAD
                        </form>
=======
                          </div>
                        </div>
                      </div>
>>>>>>> 38f8373b61a9793faa640ae28cb592a362ddca11
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
<<<<<<< HEAD
        </div>

       
=======
          </div>
        </div>
>>>>>>> 38f8373b61a9793faa640ae28cb592a362ddca11
      </div>

    </div>
  </AuthenticatedLayout>
</template>

<style>

.content-wrapper {
  font-family: 'Poppins', 'Segoe UI', sans-serif;
}

.disabled {
  pointer-events: none;
  opacity: 0.6;
  cursor: not-allowed;
}

.img-circle {
  border-radius: 50%;
}


.profile-user-img {
  border: 1px solid #adb5bd;
  margin: 0 auto;
  padding: 3px;
  width: 30px;
}

.img-fluid {
  max-width: 100%;
  height: auto;
}


.card-title:hover {
  color: #007bff;
  cursor: pointer;
}

.card-title {
  position: relative;
  display: inline-block;
}

.card-title::after {
  content: "";
  position: absolute;
  left: 0;
  bottom: -3px;
  width: 0;
  height: 2px;
  transition: width 0.3s ease;
}

.card-title:hover::after {
  width: 100%;
}


.card-title {
  transition: transform 0.2s ease, color 0.2s ease;
}

.card-title:hover {
  transform: scale(1.05);
  color: #0056b3;
}
</style>

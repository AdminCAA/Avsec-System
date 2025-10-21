<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import { Head, Link, useForm, router } from '@inertiajs/vue3';
import { ref, watch } from 'vue';
import Swal from 'sweetalert2';
import 'sweetalert2/dist/sweetalert2.min.css';
import InputError from '@/Components/InputError.vue';

import vSelect from 'vue-select'
import 'vue-select/dist/vue-select.css'

const {criticalElementTypes, protocolQuestion} = defineProps({
  criticalElementTypes: {
    type: Object,
    required: true
  },
  protocolQuestion: {
        type: Object,
        required: true
    },
});

const answerOptions = [
  { label: 'Satisfactory', value: 'Satisfactory' },
  { label: 'Not Satisfactory', value: 'Not Satisfactory' },
  { label: 'Not Applicable', value: 'Not Applicable' },  
]

const statusOptions = [
  { label: 'Open', value: 'Open' },
  { label: 'In Progress', value: 'In Progress' },
  { label: 'Closed', value: 'Closed' },  
]

const gapIdentifiedOptions = [
  { label: 'Yes', value: 'Yes' },
  { label: 'No', value: 'No' },  
]

const page = usePage()
const roles = page.props.auth.user.roles;
const hasRoles = (roles) => {
  const userRoles = page.props.auth.user?.roles ?? []
  // If a single role is passed as a string, wrap it in an array
  const requiredRoles = Array.isArray(roles) ? roles : [roles]
  return requiredRoles.some(role => userRoles.includes(role))
}

const form = useForm({
  question: protocolQuestion.question,  
  critical_element_type_id: protocolQuestion.critical_element_type_id || '',
  pq_number: protocolQuestion.pq_number || '',
  answer: protocolQuestion.answer || '',
  status: protocolQuestion.status || '',
  answer_details: protocolQuestion.answer_details || '',
  pq_category: protocolQuestion.pq_category || '',
  ce_category: protocolQuestion.ce_category || '',
  assistance_status: protocolQuestion.assistance_status || '',
  icao_reference: protocolQuestion.icao_reference || '',
  responsible_entity: protocolQuestion.responsible_entity || '',
  estimated_completion_date: protocolQuestion.estimated_completion_date || '',
  gap_identified: protocolQuestion.gap_identified || '',
  actual_completion_date: protocolQuestion.actual_completion_date || '',
  remarks: protocolQuestion.remarks || '',
});

const isLoading = ref(false);
const formErrors = ref({});

function editProtocolQuestion() {
  if (!form.question || !form.pq_number || !form.ce_category) {
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
  axios.post(route('protocolquestions.update', protocolQuestion.id), form)
    .then(() => {
      Swal.fire({
        icon: 'success',
        title: 'Protocol updated successfully',
        toast: true,
        position: 'top-end',
        timer: 1500,
        showConfirmButton: false
      });
      setTimeout(() => {
        router.visit(route('protocolquestions.index'));
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



function deleteReference(id){
  Swal.fire({
    title: 'Are you sure?',
    text: "This action cannot be undone.",
    icon: 'warning',
    showCancelButton: true,
    confirmButtonColor: '#d33',
    cancelButtonColor: '#3085d6',
    confirmButtonText: 'Yes, delete it!'
  }).then((result) => {
    if (result.isConfirmed) {
      axios.delete(route('protocolquestions.destroyReferenceDocument', id))
        .then(() => {
          Swal.fire({
            icon: 'success',
            title: 'Reference document deleted successfully',
            toast: true,
            position: 'top-end',
            timer: 1500,
            showConfirmButton: false
          });
          // Remove the deleted document from the local state
          protocolQuestion.reference_documents = protocolQuestion.reference_documents.filter(doc => doc.id !== id);
        })
        .catch(() => {
          Swal.fire({
            icon: 'error',
            title: 'Failed to delete the reference document',
            toast: true,
            position: 'top-end',
            timer: 3000,
            showConfirmButton: false
          });
        });
    }
  });
}

function deleteEvidence(id){
  Swal.fire({
    title: 'Are you sure?',
    text: "This action cannot be undone.",
    icon: 'warning',
    showCancelButton: true,
    confirmButtonColor: '#d33',
    cancelButtonColor: '#3085d6',
    confirmButtonText: 'Yes, delete it!'
  }).then((result) => {
    if (result.isConfirmed) {
      axios.delete(route('protocolquestions.destroyEvidenceDocument', id))
        .then(() => {
          Swal.fire({
            icon: 'success',
            title: 'Evidence document deleted successfully',
            toast: true,
            position: 'top-end',
            timer: 1500,
            showConfirmButton: false
          });
          // Remove the deleted document from the local state
          protocolQuestion.evidence_documents = protocolQuestion.evidence_documents.filter(doc => doc.id !== id);
        })
        .catch(() => {
          Swal.fire({
            icon: 'error',
            title: 'Failed to delete the evidence document',
            toast: true,
            position: 'top-end',
            timer: 3000,
            showConfirmButton: false
          });
        });
    }
  });
}



/// Realtime validation examples
watch(() => form.question, (value) => {
  formErrors.value.question = !value?.trim()? 'Protocol Question is required.'
    : value.length < 3
    ? 'Protocol Question must be at least 3 characters.'
    : '';
});


// Realtime validation examples
watch(() => form.pq_number, (value) => {
  formErrors.value.pq_number = !value?.trim()? 'PQ number is required.'
    : value.length < 3
    ? 'PQ number must be at least 3 characters.'
    : '';
});

watch(() => form.ce_category, (value) => {
  formErrors.value.ce_category = !value?.trim()? 'CE is required.'
    : value.length < 3
    ? 'CE must be at least 3 characters.'
    : '';
});

watch(() => form.icao_reference, (value) => {
  formErrors.value.icao_reference = value.length < 3 ? 'ICAO reference must be at least 3 characters.'
    : '';
});


const  openDocument = (doc) => {  
  const baseUrl = `/storage/${encodeURIComponent(doc.attachment)}`;    
  let fileUrl = baseUrl;
  const page = doc.doc_page;
  if(page){
    fileUrl += `#page=${page}`;
    window.open(fileUrl, '_blank');
    return;
  }else{
    window.open(baseUrl, '_blank');
    return;
  }  
}
</script>

<template>
  <Head title="Edit Protocol Question" />
  <AuthenticatedLayout>
    <div class="content-wrapper">    
        <div class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h3 class="m-0"><strong>Protocol / Edit</strong></h3>
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
                            <div class="d-flex justify-content-end my-1">
                                    
                                    <Link title="Back to PQs" :href="route('protocolquestions.index')" class="btn btn-outline-info btn-sm d-inline-flex align-items-center gap-1 mr-1">
                                      <i class="fas fa-arrow-left"></i><span class="ml-1">Back</span> 
                                    </Link>
                                    </div>
                            <div class="card card-info">
                                <div class="card-header">
                                    <h3 class="card-title">Edit Protocol Question</h3>
                                </div>
                                <!-- form start -->                        
                                <form @submit.prevent="editProtocolQuestion">
                                    <div class="card-body">                                 
                                        <div class="row">
                                          <div class="form-group col-md-12">
                                            <label>Question</label>
                                            <textarea
                                                v-model="form.question" 
                                                type="text" 
                                                class="form-control"
                                                :class="{ 
                                                    'is-invalid': formErrors.question, 
                                                    'is-valid': form.question && !formErrors.question 
                                                }"
                                                placeholder="Enter Question">
                                            </textarea>

                                            <InputError :message="formErrors.question || form.errors.question"
                                                class="mt-2" />
                                            <div v-if="form.question && !formErrors.question"
                                                class="valid-feedback d-block">
                                                Protocol Question looks good!
                                            </div>
                                        </div>

                                        <div class="form-group col-md-6">
                                          <label>PQ Number</label>
                                          <input
                                              v-model="form.pq_number" 
                                              type="text" 
                                              class="form-control"
                                              :class="{ 
                                                  'is-invalid': formErrors.pq_number, 
                                                  'is-valid': form.pq_number && !formErrors.pq_number 
                                              }"
                                              placeholder="Enter PQ Number"
                                              />                                                                        
                                            <InputError :message="formErrors.pq_number || form.errors.pq_number"
                                              class="mt-2" />
                                            <div v-if="form.pq_number && !formErrors.pq_number"
                                                class="valid-feedback d-block">
                                                PQ Number looks good!
                                            </div>
                                        </div>
                                              
                                          <div class="form-group col-md-6">                                    
                                              <label>Critical Element</label>                                        
                                              <v-select
                                                  v-model="form.ce_category"
                                                  :options="criticalElementTypes"
                                                  :reduce="criticalElementTypes => criticalElementTypes.name"
                                                  label="name"
                                                  placeholder="-- Select Critical Element --"
                                                  :class="{
                                                    'is-invalid': formErrors.ce_category,
                                                    'is-valid': form.ce_category && !formErrors.ce_category
                                                  }"
                                              />                                                       
                                              <InputError :message="formErrors.ce_category || form.errors.ce_category"
                                                class="mt-2" />                                      
                                              <div v-if="form.ce_category && !formErrors.ce_category"
                                                  class="valid-feedback d-block">
                                                  Critical Element looks good!
                                              </div>
                                          </div>
                                          

                                          <div class="form-group col-md-6">
                                            <label>ICAO Reference</label>
                                            <input
                                                v-model="form.icao_reference" 
                                                type="text" 
                                                class="form-control"
                                                :class="{ 
                                                    'is-invalid': formErrors.icao_reference, 
                                                    'is-valid': form.icao_reference && !formErrors.icao_reference 
                                                }"
                                                placeholder="Enter ICAO Reference (Optional)"/>                                    
                                            
                                                <InputError :message="formErrors.icao_reference || form.errors.icao_reference"
                                                class="mt-2" />
                                              <div v-if="form.icao_reference && !formErrors.icao_reference"
                                                  class="valid-feedback d-block">
                                                  ICAO Reference looks good!
                                              </div>
                                          </div>  
                                          
                                          <div class="form-group col-md-3">
                                            <label>Answer</label>                                                                                          
                                              <select v-model="form.answer" class="form-control"
                                                :class="{ 'is-invalid': formErrors.answer, 'is-valid': form.answer && !formErrors.answer }">
                                                <option value="">-- Select Answer --</option>
                                                <option v-for="option in answerOptions" :key="option.value" :value="option.value">{{ option.label }}</option>
                                              </select>
                                              <InputError :message="formErrors.answer" class="mt-1" />
                                              <div v-if="form.answer && !formErrors.answer" class="valid-feedback d-block">
                                                Answer looks good!
                                              </div>                                                                                      
                                          </div> 
                                          <div class="form-group col-md-3">
                                            <label> Status</label>                                                                                          
                                              <select v-model="form.status" class="form-control"
                                                :class="{ 'is-invalid': formErrors.status, 'is-valid': form.status && !formErrors.status }">
                                                <option value="">-- Select Status --</option>
                                                <option v-for="option in statusOptions" :key="option.value" :value="option.value">{{ option.label }}</option>
                                              </select>
                                              <InputError :message="formErrors.status" class="mt-1" />
                                              <div v-if="form.status && !formErrors.status" class="valid-feedback d-block">
                                                Status looks good!
                                              </div>                                                                                      
                                          </div> 



                                        <div class="form-group col-md-12">
                                            <label>Answer Details</label>
                                            <textarea
                                                v-model="form.answer_details" 
                                                type="text" 
                                                class="form-control"
                                                :class="{ 
                                                    'is-invalid': formErrors.answer_details, 
                                                    'is-valid': form.answer_details && !formErrors.answer_details 
                                                }"
                                                placeholder="Enter Answer Details">
                                            </textarea>

                                            <InputError :message="formErrors.answer_details || form.errors.answer_details"
                                                class="mt-2" />
                                            <div v-if="form.answer_details && !formErrors.answer_details"
                                                class="valid-feedback d-block">
                                                Answer Detail looks good!
                                            </div>
                                        </div>

                                        
                                        <div class="form-group col-md-6">
                                          <label>Assistance Status</label>
                                          <input
                                              v-model="form.assistance_status" 
                                              type="text" 
                                              class="form-control"
                                              :class="{ 
                                                  'is-invalid': formErrors.assistance_status, 
                                                  'is-valid': form.assistance_status && !formErrors.assistance_status 
                                              }"
                                              placeholder="Enter Assistance Reference"/>                                    
                                          
                                              <InputError :message="formErrors.assistance_status || form.errors.assistance_status"
                                              class="mt-2" />
                                            <div v-if="form.assistance_status && !formErrors.assistance_status"
                                                class="valid-feedback d-block">
                                                Assistance Status looks good!
                                            </div>
                                          </div>  
                                          
                                        <div class="form-group col-md-6">
                                          <label>Responsible Entity</label>
                                          <input
                                              v-model="form.responsible_entity" 
                                              type="text" 
                                              class="form-control"
                                              :class="{ 
                                                  'is-invalid': formErrors.responsible_entity, 
                                                  'is-valid': form.responsible_entity && !formErrors.responsible_entity 
                                              }"
                                              placeholder="Enter Responsible Entity"/>                                    
                                          
                                              <InputError :message="formErrors.responsible_entity || form.errors.responsible_entity"
                                              class="mt-2" />
                                              <div v-if="form.responsible_entity && !formErrors.responsible_entity"
                                                  class="valid-feedback d-block">
                                                  Responsible Entity looks good!
                                              </div>
                                        </div> 

                                        <div class="form-group col-md-6">
                                            <label>Gap Identified</label>                                                                                          
                                              <select  v-model="form.gap_identified" class="form-control"
                                                :class="{ 'is-invalid': formErrors.gap_identified, 'is-valid': form.gap_identified && !formErrors.gap_identified }">
                                                <option value="">-- Select Gap Identified --</option>
                                                <option v-for="option in gapIdentifiedOptions" :key="option.value" :value="option.value">{{ option.label }}</option>
                                              </select>
                                              <InputError :message="formErrors.gap_identified" class="mt-1" />
                                              <div v-if="form.gap_identified && !formErrors.gap_identified" class="valid-feedback d-block">
                                                Gap Identified looks good!
                                              </div>                                                                                      
                                          </div>  
                                        <div class="form-group col-md-3">
                                          <label>Est. Completion Date</label>
                                          <input
                                              v-model="form.estimated_completion_date" 
                                              type="date" 
                                              class="form-control"
                                              :class="{ 
                                                  'is-invalid': formErrors.estimated_completion_date, 
                                                  'is-valid': form.estimated_completion_date && !formErrors.estimated_completion_date 
                                              }"
                                              placeholder="Est. Completion Date"/>                                    
                                          
                                              <InputError :message="formErrors.estimated_completion_date || form.errors.estimated_completion_date"
                                              class="mt-2" />
                                            <div v-if="form.estimated_completion_date && !formErrors.estimated_completion_date"
                                                class="valid-feedback d-block">
                                                Est. Completion Date looks good!
                                            </div>
                                        </div>  
                                        <div class="form-group col-md-3">
                                          <label>Completion Date</label>
                                          <input
                                              v-model="form.actual_completion_date" 
                                              type="date" 
                                              class="form-control"
                                              :class="{ 
                                                  'is-invalid': formErrors.actual_completion_date, 
                                                  'is-valid': form.actual_completion_date && !formErrors.actual_completion_date 
                                              }"
                                              />                                    
                                          
                                              <InputError :message="formErrors.actual_completion_date || form.errors.actual_completion_date"
                                              class="mt-2" />
                                            <div v-if="form.actual_completion_date && !formErrors.actual_completion_date"
                                                class="valid-feedback d-block">
                                               Completion Date looks good!
                                            </div>
                                        </div>  
                                                                                  
                                        <div class="form-group col-md-12">
                                            <label>Remarks</label>
                                            <textarea
                                                v-model="form.remarks" 
                                                type="text" 
                                                class="form-control"
                                                :class="{ 
                                                    'is-invalid': formErrors.remarks, 
                                                    'is-valid': form.remarks && !formErrors.remarks 
                                                }"
                                                placeholder="Enter Remarks">
                                            </textarea>

                                            <InputError :message="formErrors.remarks || form.errors.remarks"
                                                class="mt-2" />
                                            <div v-if="form.remarks && !formErrors.remarks"
                                                class="valid-feedback d-block">
                                                Remarks looks good!
                                            </div>
                                        </div>
                                        <div class="form-group col-md-6">
                                          <label>Evidence Documents</label>                                          
                                          <div class="custom-file">
                                            
                                            <Link title="Add Evidence" class="btn btn-outline-info btn-sm d-inline-flex align-items-center gap-1" :href="route('protocolquestions.createEvidence', protocolQuestion.id)">
                                              <i class="fas fa-plus"></i> <span class="ml-1">Add Evidence</span>
                                            </Link>
                                           
                                          </div>  
                                           <!-- List of reference documents in a table -->
                                           <table class="table table-sm table-hover table-bordered mt-3 align-middle">
                                            <thead class="table-light">
                                              <tr>
                                                <th style="width: 50px;">#</th>
                                                <th>Evidences</th>
                                                <th style="width: 120px;">Actions</th>
                                              </tr>
                                            </thead>
                                            <tbody>
                                              <tr v-for="(doc, index) in protocolQuestion.evidence_documents" :key="doc.id">
                                                <td class="text-center">{{ index + 1 }}</td>
                                                <td>
                                                  <a href="#" class="text-decoration-none d-flex align-items-center gap-2" @click.prevent="openDocument(doc)">
                                                    <i class="fas fa-folder-open text-warning"></i> 
                                                    <span style="margin-left: 4px;"> {{ doc.name }}</span>
                                                  </a>
                                                </td>
                                                <td class="text-center">

                                                      <Link 
                                                        :href="route('protocolquestions.editEvidence', doc.id)"
                                                        class="btn btn-outline-info btn-sm d-inline-flex align-items-center gap-1 mr-1"
                                                        title="Edit Document"
                                                      >
                                                        <i class="fas fa-edit"></i>
                                                        <span>Edit</span>
                                                      </Link>
                                                  <button  v-if="hasRoles(['Super Admin'])"
                                                    @click.prevent="deleteEvidence(doc.id)"
                                                    class="btn btn-outline-danger btn-sm"
                                                    title="Delete Document"
                                                  >
                                                    <i class="fas fa-trash"></i>
                                                  </button>
                                                </td>
                                              </tr>

                                              <tr v-if="!protocolQuestion.evidence_documents || protocolQuestion.evidence_documents.length === 0">
                                                <td colspan="3" class="text-center text-muted py-3">
                                                  No reference documents added.
                                                </td>
                                              </tr>
                                            </tbody>
                                          </table>  
                                        </div>

                                        <div class="form-group col-md-6">
                                          <label>Reference Documents</label>
                                          <div class="custom-file">
                                            <!-- <input type="file" class="custom-file-input" id="customFile">
                                            <label class="custom-file-label" for="customFile">Choose file</label> -->
                                            <Link title="Add Reference" class="btn btn-outline-info btn-sm d-inline-flex align-items-center gap-1" :href="route('protocolquestions.createReference', protocolQuestion.id)">
                                              <i class="fas fa-plus"></i> <span class="ml-1">Add Reference</span>
                                            </Link>

                                           
                                          </div>  
                                           <!-- List of reference documents in a table -->
                                           <table class="table table-sm table-hover table-bordered mt-3 align-middle">
                                            <thead class="table-light">
                                              <tr>
                                                <th style="width: 50px;">#</th>
                                                <th>References</th>
                                                <th style="width: 120px;">Actions</th>
                                              </tr>
                                            </thead>
                                            <tbody>
                                              <tr v-for="(doc, index) in protocolQuestion.reference_documents" :key="doc.id">
                                                <td class="text-center">{{ index + 1 }}</td>
                                                <td>
                                                  <a href="#" class="text-decoration-none d-flex align-items-center gap-2" @click.prevent="openDocument(doc)">
                                                    <i class="fas fa-folder-open text-warning"></i> 
                                                    <span style="margin-left: 4px;"> {{ doc.name }}</span>
                                                  </a>
                                                </td>
                                                <td class="text-center">

                                                      <Link 
                                                        :href="route('protocolquestions.editReference', doc.id)"
                                                        class="btn btn-outline-info btn-sm d-inline-flex align-items-center gap-1 mr-1"
                                                        title="Edit Reference"
                                                      >
                                                        <i class="fas fa-edit"></i>
                                                        <span>Edit</span>
                                                      </Link>
                                                  <button v-if="hasRoles(['Super Admin'])"
                                                    @click.prevent="deleteReference(doc.id)"
                                                    class="btn btn-outline-danger btn-sm"
                                                    title="Delete Reference"
                                                  >
                                                    <i class="fas fa-trash"></i>
                                                  </button>
                                                </td>
                                              </tr>

                                              <tr v-if="!protocolQuestion.reference_documents || protocolQuestion.reference_documents.length === 0">
                                                <td colspan="3" class="text-center text-muted py-3">
                                                  No reference documents added.
                                                </td>
                                              </tr>
                                            </tbody>
                                          </table>
                                        
                                        </div>

                                        </div>                                                                                                                                                                                                                                                        
                                    </div>

                                    <div class="card-footer d-flex justify-content-end">
                                    <button title="Save PQ" :disabled="isLoading" type="submit" class="btn btn-outline-info btn-sm d-inline-flex align-items-center gap-1 mr-1">
                                        <span v-if="isLoading"><i class="fas fa-spinner fa-spin"></i> Saving...</span>
                                        <span v-else><i class="fas fa-save"></i> Save</span>
                                    </button>
                                    <Link title="Back to PQs" :href="route('protocolquestions.index')" class="btn btn-outline-info btn-sm d-inline-flex align-items-center gap-1 mr-1">
                                      <i class="fas fa-arrow-left"></i><span class="ml-1">Back</span> 
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

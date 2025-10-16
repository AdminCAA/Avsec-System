<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import { Head, Link, useForm, router } from '@inertiajs/vue3';
import { ref, watch } from 'vue';
import Swal from 'sweetalert2';
import 'sweetalert2/dist/sweetalert2.min.css';
import InputError from '@/Components/InputError.vue';
import 'vue-select/dist/vue-select.css'

const { protocolQuestion } = defineProps({
    protocolQuestion: {
    type: Object,
    required: true
  },
});

const form = useForm({
    name: '',  
    protocol_question_id: '',  
    doc_page: '',                
    attachment: null,    
});

const isLoading = ref(false);
const formErrors = ref({});

const fileName = ref('');
const handleFileUpload = (event) => {
    const file = event.target.files[0];
    if (file) {
        form.attachment = file;
        fileName.value = file.name;
        
    }
    const allowedTypes = [
        "image/jpeg",
        "image/png",
        "image/gif",
        "application/pdf",
        "application/msword",
        "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
        "application/vnd.ms-excel",
        "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    ];
    if (!allowedTypes.includes(file.type)) {
        formErrors.value.attachment = 'Invalid file type. Allowed types: JPG, PNG, GIF, PDF, DOC, DOCX, XLS, XLSX.';
        form.attachment = null;
        fileName.value = '';
    } else if (file.size > 5 * 1024 * 1024) { // 5MB limit
        formErrors.value.attachment = 'File size exceeds the 5MB limit.';
        form.attachment = null;
        fileName.value = '';
    } else {
        formErrors.value.attachment = '';
    }    
};

function createProtocolQuestionEvidence() {
    //check validation here  
    if (!form.name) {
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
    // Prepare form data for submission
    let formData = new FormData();
    formData.append('name', form.name);
    formData.append('doc_page', form.doc_page);    
    formData.append('protocol_question_id', protocolQuestion.id);        
    // Append attachement file if present
    if (form.attachment) {
        formData.append('attachment', form.attachment);
    }


  axios.post(route('protocolquestions.storeEvidence', protocolQuestion.id), formData)
    .then(() => {
      Swal.fire({
        icon: 'success',
        title: 'Protocol Question Evidence created successfully',
        toast: true,
        position: 'top-end',
        timer: 1500,
        showConfirmButton: false
      });
      setTimeout(() => {
        router.visit(route('protocolquestions.edit', protocolQuestion.id));
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


</script>

<template>
  <Head title="Create Protocol Evidence" />
  <AuthenticatedLayout>
    <div class="content-wrapper">    
        <div class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h3 class="m-0"><strong>Protocol Evidence / Create</strong></h3>
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
                            <h3 class="card-title">Create Protocol Evidence</h3>
                        </div>
                        <!-- form start -->                        
                        <form @submit.prevent="createProtocolQuestionEvidence" enctype="multipart/form-data" >
                            <div class="card-body">
                              <!-- Name -->
                               <!-- Row 1: Name & Category -->
                                <div class="row">
                                    <div class="form-group col-md-6">
                                    <label>Evidence Name</label>
                                    <input
                                        v-model="form.name" 
                                        type="text" 
                                        class="form-control"
                                        :class="{ 
                                            'is-invalid': formErrors.name, 
                                            'is-valid': form.name && !formErrors.name 
                                        }"
                                        placeholder="Enter Evidence Name"/>                                                                        
                                        <InputError :message="formErrors.name || form.errors.name"
                                        class="mt-2" />
                                        <div v-if="form.name && !formErrors.name"
                                            class="valid-feedback d-block">
                                            Reference name looks good!
                                        </div>
                                    </div>
                                    <div class="form-group col-md-6">
                                                    <label>Upload Evidence Document</label>
                                                    <div class="input-group">
                                                        <div class="custom-file">
                                                            <input type="file" accept="image/*,.pdf,.doc,.docx,.xls,.xlsx"
                                                                @change="handleFileUpload" class="custom-file-input"
                                                                id="exampleInputFile"
                                                                :class="{ 'is-invalid': formErrors.attachment, 'is-valid': form.attachment && !formErrors.attachment }">
                                                            <label class="custom-file-label" for="exampleInputFile">
                                                                {{ fileName || 'Choose file' }}
                                                            </label>
                                                        </div>
                                                    </div>
                                                    <div v-if="form.attachment && !formErrors.attachment"
                                                        class="valid-feedback d-block">
                                                        Attachment looks good!
                                                    </div>
                                                    <InputError :message="formErrors.portrait" class="mt-1" />

                                                </div>
                                    
                                                <div class="form-group col-md-6">
                                                        <label>Ref Page number</label>
                                                        <input
                                                            v-model="form.doc_page" 
                                                            type="number" 
                                                            class="form-control"
                                                            :class="{ 
                                                                'is-invalid': formErrors.doc_page, 
                                                                'is-valid': form.doc_page && !formErrors.doc_page 
                                                            }"
                                                            placeholder="Enter Page Number"/>                                                                        
                                                            <InputError :message="formErrors.doc_page || form.errors.doc_page"
                                                            class="mt-2" />
                                                            <div v-if="form.doc_page && !formErrors.doc_page"
                                                                class="valid-feedback d-block">
                                                                Page Number looks good!
                                                            </div>
                                                        </div>                                                                                                   
                                                    </div>                                                                                                                                                                                                                                                        
                                                </div>


                            <div class="card-footer d-flex justify-content-end">
                              <button :disabled="isLoading" type="submit" class="btn btn-info mr-2">
                                <span v-if="isLoading"><i class="fas fa-spinner fa-spin"></i> Saving...</span>
                                <span v-else><i class="fas fa-save"></i> Submit</span>
                              </button>
                              <Link :href="route('protocolquestions.edit', protocolQuestion.id)" class="btn btn-secondary">
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

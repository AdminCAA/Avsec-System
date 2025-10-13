<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import { usePage, Head, Link } from '@inertiajs/vue3';
import { ref, onMounted, watch } from 'vue';
import Swal from 'sweetalert2';
import 'sweetalert2/dist/sweetalert2.min.css';
import 'vue-select/dist/vue-select.css'


const cameraInputs = ref({}); // this should be an empty object

const { qualityControl, groupedCheckListQuestions } = defineProps({
  qualityControl: {
    type: Object,
    required: true
  },

  groupedCheckListQuestions: {
    type: Object,
    required: true
  }
});

const hideButton = ref(true);


const page = usePage()
const roles = page.props.auth.user.roles;

// Function to check if the user has a specific role
const hasRoles = (roles) => {
  const userRoles = page.props.auth.user?.roles ?? []
  // If a single role is passed as a string, wrap it in an array
  const requiredRoles = Array.isArray(roles) ? roles : [roles]
  return requiredRoles.some(role => userRoles.includes(role))
}

const responseOptions = [
  { id: 1, option: 'Yes' },
  { id: 2, option: 'No' },
  { id: 3, option: 'Pass' },
  { id: 4, option: 'Fail' },
  { id: 5, option: 'Not Applicable' },
  { id: 6, option: 'Not Confirmed' },
]

const findingCategoryOptions = [
  { id: 1, option: 'Compliant' },
  { id: 2, option: 'Not Compliant(Minor)' },
  { id: 3, option: 'Not Compliant(Serious)' },
  { id: 4, option: 'Not Applicable' },
  { id: 5, option: 'Not Confirmed' },
]


const statusOptions = [
  { id: 1, option: 'Open' },
  { id: 2, option: 'Closed' },
]

const followupActionOptions = [
  { id: 1, option: 'Onsite' },
  { id: 2, option: 'Administrative' },
  { id: 3, option: 'Onsite and Administrative' },
  { id: 4, option: 'Not Applicable' },
]

const forms = ref({});
const isLoading = ref(false);
const isApproving = ref(false);
const formErrors = ref({});

function validateQuestionForm(questionId) {
  const form = getForm(questionId);
  const errors = {};
  if (!form.question_response) errors.question_response = 'Response is required';
  if (!form.finding_category) errors.finding_category = 'Finding category is required';
  if (!form.date_quality_control) errors.date_quality_control = 'Date of Quality Control is required';
  if (!form.finding_observation) errors.finding_observation = 'Finding/Observation is required';
  if (!form.status) errors.status = 'Status is required';


  if (form.evidence_file instanceof File) {
    // Size check
    if (form.evidence_file.size > 2 * 1024 * 1024) {
      errors.evidence_file = 'File size must be less than 2MB';
    }
    // Type check
    else if (!['application/pdf', 'image/jpeg', 'image/png', 'image/jpg'].includes(form.evidence_file.type)) {
      errors.evidence_file = 'Only PDF, JPG, or PNG files are allowed.';
    }
  }
  formErrors.value[questionId] = errors;

  return Object.keys(errors).length === 0;
}

function approveQualityControl(qualityControlId) {
  Swal.fire({
    title: 'Are you sure?',
    text: "You are about to approve this checklist. This action cannot be undone.",
    icon: 'warning',
    showCancelButton: true,
    confirmButtonColor: '#3085d6',
    cancelButtonColor: '#d33',
    confirmButtonText: 'Yes, approve it!'
  }).then((result) => {
    if (result.isConfirmed) {
      isApproving.value = true;
      axios.post(route('quality-controls.approve', qualityControlId))
        .then(() => {
          Swal.fire({
            icon: 'success',
            title: 'Checklist has been approved successfully',
            toast: true,
            position: 'top-end',
            timer: 1500,
            showConfirmButton: false
          })
          hideButton.value = false;
        })
        .catch(error => {
          if (error.response?.status === 422) {
            Swal.fire({
              icon: 'error',
              title: 'Error',
              text: 'No user was assigned to carry out this quality control',
              toast: true,
              position: 'top-end',
              timer: 3000,
              showConfirmButton: false
            });
          } else {
            console.error(error);
            Swal.fire({
              icon: 'error',
              title: 'Error',
              text: 'An error occurred while approving the checklist.',
              toast: true,
              position: 'top-end',
              timer: 2000,
              showConfirmButton: false
            });
          }
        })
        .finally(() => {
          isApproving.value = false;
        });
    }
  });
}


function submitQuestionForm(questionId) {
  if (validateQuestionForm(questionId)) {
    isLoading.value = true;
    let formData = new FormData();
    formData.append('question_id', questionId);
    formData.append('quality_control_id', qualityControl.id);
    formData.append('question_response', forms.value[questionId].question_response);
    formData.append('finding_observation', forms.value[questionId].finding_observation);
    formData.append('action_taken', forms.value[questionId].action_taken);
    formData.append('status', forms.value[questionId].status);
    formData.append('finding_category', forms.value[questionId].finding_category);
    formData.append('date_quality_control', forms.value[questionId].date_quality_control);
    formData.append('problem_cause', forms.value[questionId].problem_cause);
    formData.append('recommendations', forms.value[questionId].recommendations);
    formData.append('reference', forms.value[questionId].reference);
    formData.append('immediate_corrective_action', forms.value[questionId].immediate_corrective_action);
    formData.append('risk_description', forms.value[questionId].risk_description);
    formData.append('short_term_action', forms.value[questionId].short_term_action);
    formData.append('short_term_date', forms.value[questionId].short_term_date);
    formData.append('long_term_action', forms.value[questionId].long_term_action);
    formData.append('long_term_date', forms.value[questionId].long_term_date);

    formData.append('proposed_follow_up_action', forms.value[questionId].proposed_follow_up_action);
    formData.append('completion_date', forms.value[questionId].completion_date);
    formData.append('date_of_closure', forms.value[questionId].date_of_closure);
    formData.append('follow_up_date', forms.value[questionId].follow_up_date);

    if (forms.value[questionId].evidence_file instanceof File) {
      formData.append('evidence_file', forms.value[questionId].evidence_file);
    }

    if (forms.value[questionId].captured_image_file instanceof File) {
      formData.append('captured_image_file', forms.value[questionId].captured_image_file);
    }


    axios.post(route('quality-controls.saveQuestionResponse', questionId), formData).then(() => {
      Swal.fire({
        icon: 'success',
        title: 'Checklist has been saved successfully',
        toast: true,
        position: 'top-end',
        timer: 1500,
        showConfirmButton: false
      });
    })
      .catch(error => {
        if (error.response?.status === 422) {
          const errors = error.response.data.errors;
          formErrors.value[questionId] = errors;
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
  } else {
    Swal.fire({
      icon: 'error',
      title: 'Validation failed',
      text: formErrors.value[questionId].evidence_file,
      toast: true,
      position: 'top-end',
      timer: 3000,
      showConfirmButton: false
    });
  }
}

// Realtime validation examples
function getForm(questionId) {
  if (!forms.value[questionId]) {
    forms.value[questionId] = {
      question_response: '',
      finding_observation: '',
      action_taken: '',
      status: '',
      finding_category: '',
      date_quality_control: '',
      recommendations: '',
      reference: '',
      immediate_corrective_action: '',
      risk_description: '',
      short_term_action: '',
      short_term_date: '',
      long_term_action: '',
      long_term_date: '',
      date_quality_control: '',
      problem_cause: '',
      proposed_follow_up_action: '',
      short_term_action: '',
      long_term_action: '',
      completion_date: '',
      date_of_closure: '',
      follow_up_date: '',
      evidence_file: null,
      captured_image_file: null,
      captured_image_preview: null,
    };
  }
  return forms.value[questionId];
}


onMounted(() => {
  for (const [_, questions] of Object.entries(groupedCheckListQuestions)) {
    for (const question of questions) {
      forms.value[question.id] = {
        question_response: question.question_response || '',
        finding_observation: question.finding_observation || '',
        action_taken: question.action_taken || '',
        status: question.status || '',
        finding_category: question.finding_category || '',
        recommendations: question.recommendations || '',
        reference: question.reference || '',
        immediate_corrective_action: question.immediate_corrective_action || '',
        risk_description: question.risk_description || '',
        short_term_action: question.short_term_action || '',
        short_term_date: question.short_term_date || '',
        long_term_action: question.long_term_action || '',
        long_term_date: question.long_term_date || '',
        date_quality_control: question.date_quality_control || '',
        problem_cause: question.problem_cause || '',
        proposed_follow_up_action: question.proposed_follow_up_action || '',
        short_term_action: question.short_term_action || '',
        long_term_action: question.long_term_action || '',
        completion_date: question.completion_date || '',
        date_of_closure: question.date_of_closure || '',
        follow_up_date: question.follow_up_date || '',
        evidence_file: question.evidence_file || null,
        captured_image_file: question.captured_image_file || null,
      };

      //Watch for changes to this specific question’s response
      watch(() => forms.value[question.id]?.question_response,
        (newVal) => {
          if (newVal?.toLowerCase() === 'yes' 
            || newVal?.toLowerCase() === 'pass')             
          {            
            const form = getForm(question.id);
            form.finding_category =  'Compliant';
            form.status = 'Closed';
            form.finding_observation = 'Not Applicable';
            form.recommendations = 'Not Applicable';
            form.immediate_corrective_action = 'Not Applicable';
            form.proposed_follow_up_action = 'Not Applicable';
            form.risk_description = 'Not Applicable';            
          }

          if (newVal?.toLowerCase() === 'no' 
              || newVal?.toLowerCase() === 'fail' 
              || newVal?.toLowerCase() === 'not confirmed') 
          {
            const form = getForm(question.id);
            form.finding_category = '';
            form.status = 'Open';
            form.finding_observation = '';
            form.recommendations = '';
            form.immediate_corrective_action = '';
            form.proposed_follow_up_action = '';
            form.risk_description = question?.risk_description || '';
         }

         if(newVal?.toLowerCase() === 'not applicable'){
            const form = getForm(question.id);
            form.finding_category =  'Not Applicable';
            form.status = 'Closed';
            form.finding_observation = 'Not Applicable';
            form.recommendations = 'Not Applicable';
            form.immediate_corrective_action = 'Not Applicable';
            form.proposed_follow_up_action = 'Not Applicable';
            form.risk_description = 'Not Applicable';
         }
        }
      );
    }
  }




});

const fileName = ref({});
const handleFileUpload = (questionId, event) => {
  const file = event.target.files[0];

  if (!formErrors.value[questionId]) {
    formErrors.value[questionId] = {};
  }
  if (file) {
    const allowedTypes = ['application/pdf', 'image/jpeg', 'image/png', 'image/jpg'];
    getForm(questionId).evidence_file = file;
    fileName.value[questionId] = file.name;
    if (!allowedTypes.includes(file.type)) {
      formErrors.value[questionId].evidence_file = 'Only PDF, JPG, or PNG files are allowed.';
    } else {
      formErrors.value[questionId].evidence_file = '';
    }
  } else {
    fileName.value[questionId] = '';
    getForm(questionId).evidence_file = null;
  }
};


const exportToPDF = () => {
  isLoading.value = true;

  axios({
    url: route('quality-controls.exportPDF', qualityControl.id),
    method: 'GET',
    responseType: 'blob',
  })
    .then((response) => {
      const url = window.URL.createObjectURL(new Blob([response.data]));
      const link = document.createElement('a');
      link.href = url;
      link.setAttribute('download', `QualityControl_${qualityControl.id}.pdf`);
      document.body.appendChild(link);
      link.click();
    })
    .catch(() => {
      Swal.fire({
        icon: 'error',
        title: 'Error',
        text: 'Failed to generate PDF.',
        toast: true,
        position: 'top-end',
        timer: 3000,
        showConfirmButton: false,
      });
    })
    .finally(() => {
      isLoading.value = false;
    });
};

function captureImage(questionId) {
  // Check if we are on desktop (browser supports webcam)
  if (navigator.mediaDevices && navigator.mediaDevices.getUserMedia) {
    // Open webcam
    openWebcam(questionId);
  } else {
    // Fallback: trigger file input on mobile
    const input = cameraInputs.value?.[questionId];
    if (input) input.click();
  }
}

async function openWebcam(questionId) {
  try {
    const stream = await navigator.mediaDevices.getUserMedia({ video: true });

    const video = document.createElement('video');
    video.srcObject = stream;
    video.autoplay = true;

    const modal = document.createElement('div');
    modal.style.position = 'fixed';
    modal.style.top = 0;
    modal.style.left = 0;
    modal.style.width = '100%';
    modal.style.height = '100%';
    modal.style.backgroundColor = 'rgba(0,0,0,0.8)';
    modal.style.display = 'flex';
    modal.style.flexDirection = 'column';
    modal.style.justifyContent = 'center';
    modal.style.alignItems = 'center';
    modal.appendChild(video);

    const captureButton = document.createElement('button');
    captureButton.textContent = 'Capture';
    captureButton.style.marginTop = '10px';
    captureButton.className = 'btn btn-success';
    modal.appendChild(captureButton);

    document.body.appendChild(modal);

    captureButton.addEventListener('click', () => {
      const canvas = document.createElement('canvas');
      canvas.width = video.videoWidth;
      canvas.height = video.videoHeight;
      const ctx = canvas.getContext('2d');
      ctx.drawImage(video, 0, 0, canvas.width, canvas.height);
      const dataUrl = canvas.toDataURL('image/png');

      // Save to form
      getForm(questionId).evidence_file_preview = dataUrl;

      // Convert dataUrl to File object for submission if needed
      fetch(dataUrl)
        .then(res => res.blob())
        .then(blob => {
          getForm(questionId).captured_image_file = new File([blob], `capture_${Date.now()}.png`, { type: 'image/png' });
        });

      // Stop webcam
      stream.getTracks().forEach(track => track.stop());
      document.body.removeChild(modal);
    });
  } catch (err) {
    // Fallback: mobile input if webcam fails
    const input = cameraInputs.value?.[questionId];
    if (input) input.click();
  }
}

function handleCameraCapture(questionId, event) {
  const file = event.target.files[0];
  if (!file) return;

  // Preview for images
  if (file.type.startsWith('image/')) {
    const reader = new FileReader();
    reader.onload = e => {
      getForm(questionId).evidence_file_preview = e.target.result;
    };
    reader.readAsDataURL(file);
  }

  // Save to form for submission
  getForm(questionId).captured_image_file = file;
}

</script>

<template>

  <Head title="Quality Control Checklist" />
  <AuthenticatedLayout>
    <div class="content-wrapper">
      <div class="content-header">
        <div class="container-fluid">
          <div class="row mb-2">
            <div class="col-sm-12">
              <h4>
                <Link :href="route('facilities.show', qualityControl.facility.id)"><strong>{{
                  qualityControl.facility.name }}</strong> </Link> /
                <Link :href="route('quality-controls.edit', qualityControl.id)"><strong>{{ qualityControl.title
                  }}</strong> - <strong>{{ qualityControl.control_type }}</strong> </Link>

              </h4>
            </div>
          </div>
        </div>
      </div>

      <div class="content">
        <div class="container-fluid">
          <div class="d-flex justify-content-center align-items-center min-vh-60  bg-light">
            <div class="row w-100 justify-content-center">
              <div class="col-md-12 mb-4">

                <!-- Approve Checklist & Export button -->
                <div class="d-flex justify-content-end mb-3">

                  <div v-if="hasRoles(['Administrator', 'Super Admin', 'AVSEC Administrator'])">
                    <button v-show="hideButton" v-if="qualityControl.approval_status !== 'Approved'"
                      class="btn btn-success" @click.prevent="approveQualityControl(qualityControl.id)"
                      :disabled="isApproving">
                      <span v-if="isApproving">
                        <i class="fas fa-spinner fa-spin"></i> Processing, please wait...
                      </span>
                      <span v-else>
                        <i class="fas fa-check-circle"></i> Approve Checklist
                      </span>
                    </button>
                  </div>



                  <button :disabled="isLoading" @click="exportToPDF" class="btn btn-info" style="margin-left: 10px;">
                    <span v-if="isLoading">
                      <i class="fas fa-spinner fa-spin"></i> Generating PDF, Please wait...
                    </span>
                    <span v-else>
                      <i class="fas fa-file-pdf"></i> Export to PDF
                    </span>
                  </button>
                </div>

                <div class="card card-info">
                  <div class="card-header">
                    <h3 class="card-title"><strong>Quality Control Checklist</strong></h3>
                  </div>
                  <div v-for="(questions, area) in groupedCheckListQuestions" :key="area">
                    <div class="card-body">
                      <div class="row">
                        <div class="col-md-12">
                          <div
                            v-if="area?.toLowerCase?.().includes((qualityControl?.facility?.category ?? '').toLowerCase())"
                            class="col-md-12">
                            <div class="card card-info collapsed-card shadow-sm">
                              <div class="card-header">
                                <h3 style="font-weight: bold;" class="card-title" data-card-widget="collapse"><i
                                    class="fas fa-arrow-right"></i> {{
                                      area.trim() }}</h3>
                                <div class="card-tools">
                                  <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                    <i class="fas fa-plus"></i>
                                  </button>
                                </div>
                              </div>
                              <div v-for="(question, index) in questions" :key="question.id" class="card-body">
                                <form @submit.prevent="submitQuestionForm(question.id)" enctype="multipart/form-data">
                                  <div class="col-md-12">
                                    <h4>{{ question.question }}</h4>
                                    <div class="card card-success collapsed-card">
                                      <div class="card-header">
                                        <h3 class="card-title" data-card-widget="collapse">Checklist Responses # {{
                                          index + 1 }}</h3>
                                        <div class="card-tools">
                                          <button type="button" class="btn btn-tool" data-card-widget="collapse"><i
                                              class="fas fa-plus"></i>
                                          </button>
                                        </div>
                                      </div>
                                      <div class="card-body">

                                        <div class="row">
                                          <div class="form-group col-md-6">
                                            <label>Response</label>
                                            <select v-model="getForm(question.id).question_response"
                                              class="form-control" @change="validateQuestionForm(question.id)" :class="{
                                                'is-invalid': formErrors[question.id]?.question_response,
                                                'is-valid': forms[question.id]?.question_response && !formErrors[question.id]?.question_response
                                              }">
                                              <option value="">-- Select Question Response -- </option>
                                              <option v-for="item in responseOptions" :key="item.id"
                                                :value="item.option">{{ item.option }}</option>
                                            </select>
                                            <small v-if="formErrors[question.id]?.question_response"
                                              class="text-danger">{{ formErrors[question.id].question_response
                                              }}</small>
                                          </div>

                                          <div class="form-group col-md-6">
                                            <label>Finding / Observation</label>
                                            <textarea v-model="getForm(question.id).finding_observation
                                              " class="form-control" rows="2" placeholder="Findings/Observation"
                                              @change="validateQuestionForm(question.id)" :class="{
                                                'is-invalid': formErrors[question.id]?.finding_observation,
                                                'is-valid': forms[question.id].finding_observation && !formErrors[question.id]?.finding_observation
                                              }">
                                            </textarea>
                                            <small v-if="formErrors[question.id]?.finding_observation"
                                              class="text-danger">{{ formErrors[question.id].finding_observation
                                              }}</small>
                                          </div>
                                        </div>

                                        <div class="row">
                                          <div class="form-group col-md-6">
                                            <label>Finding Category</label>
                                            <select v-model="getForm(question.id).finding_category" class="form-control"
                                              @change="validateQuestionForm(question.id)" :class="{
                                                'is-invalid': formErrors[question.id]?.finding_category,
                                                'is-valid': forms[question.id].finding_category && !formErrors[question.id]?.finding_category
                                              }">
                                              <option value="">-- Select Finding Category --</option>
                                              <option v-for="item in findingCategoryOptions" :key="item.id"
                                                :value="item.option">{{ item.option }}</option>
                                            </select>
                                            <small v-if="formErrors[question.id]?.finding_category"
                                              class="text-danger">{{ formErrors[question.id].finding_category }}</small>
                                          </div>

                                          
                                          <div class="form-group col-md-6">
                                            <label>Risk Description</label>
                                            <textarea v-model="getForm(question.id).risk_description
                                              " class="form-control" rows="2" placeholder="Risk Comment"
                                              @change="validateQuestionForm(question.id)" :class="{
                                                'is-invalid': formErrors[question.id]?.risk_description,
                                                'is-valid': forms[question.id].risk_description && !formErrors[question.id]?.risk_description
                                              }">
                                            </textarea>
                                          </div>                                                                                
                                        </div>

                                        <div class="row">                                         
                                          <div class="form-group col-md-3">
                                            <label>Reference</label>
                                            <input v-model="getForm(question.id).reference" type="text"
                                              class="form-control" @change="validateQuestionForm(question.id)" :class="{
                                                'is-invalid': formErrors[question.id]?.reference,
                                                'is-valid': forms[question.id].reference && !formErrors[question.id]?.reference
                                              }" placeholder="Reference (Optional)" />
                                            <small v-if="formErrors[question.id]?.reference" class="text-danger">{{
                                              formErrors[question.id].reference }}
                                              </small>

                                          </div>
                                          <div class="form-group col-md-3">
                                            <label>Date of Quality Control</label>
                                            <input v-model="getForm(question.id).date_quality_control" type="date"
                                              class="form-control" @change="validateQuestionForm(question.id)" :class="{
                                                'is-invalid': formErrors[question.id]?.date_quality_control,
                                                'is-valid': forms[question.id].date_quality_control && !formErrors[question.id]?.date_quality_control
                                              }" placeholder="Date of Quality Control" />
                                            <small v-if="formErrors[question.id]?.date_quality_control"
                                              class="text-danger">{{ formErrors[question.id].date_quality_control
                                              }}</small>

                                          </div>
                                          <div class="form-group col-md-6">
                                            <label>Recommendations</label>
                                            <textarea v-model="getForm(question.id).recommendations"
                                              class="form-control" rows="2" placeholder="Recommendations"
                                              @change="validateQuestionForm(question.id)" :class="{
                                                'is-invalid': formErrors[question.id]?.recommendations,
                                                'is-valid': forms[question.id].recommendations && !formErrors[question.id]?.recommendations
                                              }">
                                            </textarea>
                                            <small v-if="formErrors[question.id]?.recommendations"
                                              class="text-danger">{{ formErrors[question.id].recommendations }}</small>
                                          </div>
                                        </div>

                                        <div class="row">
                                          <div class="form-group col-md-6">
                                            <label>Proposed Follow up Action</label>
                                            <select v-model="getForm(question.id).proposed_follow_up_action"
                                              class="form-control" @change="validateQuestionForm(question.id)" :class="{
                                                'is-invalid': formErrors[question.id]?.proposed_follow_up_action,
                                                'is-valid': forms[question.id]?.proposed_follow_up_action && !formErrors[question.id]?.proposed_follow_up_action
                                              }">
                                              <option value="">-- Select Proposed Followup Action --</option>
                                              <option v-for="item in followupActionOptions" :key="item.id"
                                                :value="item.option">{{ item.option }}</option>
                                            </select>
                                          </div>

                                          <div class="form-group col-md-6">
                                            <label>Immediate Corrective Actions</label>
                                            <textarea v-model="getForm(question.id).immediate_corrective_action
                                              " class="form-control" rows="2" placeholder="Immediate Corrective Action"
                                              @change="validateQuestionForm(question.id)" :class="{
                                                'is-invalid': formErrors[question.id]?.immediate_corrective_action,
                                                'is-valid': forms[question.id].immediate_corrective_action && !formErrors[question.id]?.immediate_corrective_action
                                              }">
                                        </textarea>
                                          </div>
                                        </div>

                                        <div class="row">
                                          <div class="form-group col-md-3">
                                            <label v-if="!question.evidence_file">Evidence Attachment</label>
                                            <a v-if="question.evidence_file" data-bs-toggle="tooltip"
                                              title="View Evidence Attachment"
                                              :href="`/storage/${forms[question.id].evidence_file}`" target="_blank">
                                              <i class="fas fa-paperclip"></i><span><label>Evidence Attachment</label>
                                              </span>
                                            </a>
                                            <div class="input-group">
                                              <div class="custom-file">
                                                <input type="file" accept="image/*,application/pdf"
                                                  @change="event => handleFileUpload(question.id, event)"
                                                  class="custom-file-input" id="exampleInputFile"
                                                  :class="{ 'is-invalid': formErrors[question.id]?.evidence_file, 'is-valid': forms[question.id]?.evidence_file && !formErrors[question.id]?.evidence_file }">
                                                <label class="custom-file-label" for="exampleInputFile">
                                                  {{ fileName[question.id] || 'Choose file' }}
                                                </label>
                                              </div>
                                            </div>
                                            <small v-if="formErrors[question.id]?.evidence_file" class="text-danger">{{
                                              formErrors[question.id]?.evidence_file }}</small>
                                          </div>

                                      
                                          <div class="form-group col-md-3">

                                            <!-- Label or Existing Attachment Link -->
                                            <div class="mb-2 d-flex justify-content-between align-items-center">
                                              <label class="mb-0"
                                                v-if="!question.captured_image_file || forms[question.id].evidence_file_preview">
                                                Capture Image Evidence
                                              </label>
                                              <a v-else :href="`/storage/${JSON.parse(question.captured_image_file)}`"
                                                target="_blank" class="text-decoration-none small">
                                                <i class="fas fa-paperclip"></i> View Existing Attachment
                                              </a>
                                            </div>

                                            <!-- Captured Preview -->
                                            <div v-if="forms[question.id].evidence_file_preview" class="mb-2">
                                              <div class="border rounded shadow-sm p-2" style="background: #f9f9f9;">
                                                <div class="mb-1 small text-muted">Captured Preview</div>
                                                <img :src="forms[question.id].evidence_file_preview"
                                                  alt="Captured preview" class="img-fluid rounded"
                                                  style="width: 100%; max-height: 200px; object-fit: cover;" />
                                              </div>
                                            </div>

                                            <!-- File Input (Hidden) -->
                                            <input type="file" accept="image/*" class="d-none" capture="environment"
                                              :ref="el => { if (!cameraInputs.value) cameraInputs.value = {}; if (el) cameraInputs.value[question.id] = el; }"
                                              @change="handleCameraCapture(question.id, $event)" />

                                            <!-- Capture Button -->
                                            <div class="d-flex gap-2 mt-2">
                                              <button type="button" class="btn btn-info btn-sm flex-grow-1"
                                                @click="captureImage(question.id)">
                                                <i class="fas fa-camera"></i> Capture
                                              </button>
                                            </div>

                                            <!-- Validation Error -->
                                            <small v-if="formErrors[question.id]?.captured_image_file"
                                              class="text-danger">
                                              {{ formErrors[question.id]?.captured_image_file }}
                                            </small>

                                          </div>

                                          <div class="form-group col-md-6">
                                            <label>Status</label>
                                            <select v-model="getForm(question.id).status" class="form-control"
                                              @change="validateQuestionForm(question.id)" :class="{
                                                'is-invalid': formErrors[question.id]?.status,
                                                'is-valid': forms[question.id].status && !formErrors[question.id]?.status
                                              }">
                                              <option value="">-- Select Status --</option>
                                              <option v-for="item in statusOptions" :key="item.id" :value="item.option">
                                                {{ item.option }}</option>
                                            </select>
                                          </div>
                                        </div>

                                       

                                        <div class="d-flex justify-content-end">
                                          <button :disabled="isLoading" type="submit" class="btn btn-info mr-1">
                                            <span v-if="isLoading"><i class="fas fa-spinner fa-spin"></i>
                                              Saving...</span>
                                            <span v-else><i class="fas fa-save"></i> Save</span>
                                          </button>
                                        </div>
                                      </div>
                                    </div>
                                  </div>
                                </form>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
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

.is-invalid {
  border-color: red;
}

.text-danger {
  font-size: 0.875rem;
}

.card-success:not(.card-outline)>.card-header {
  background-color: #20c997 !important;
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

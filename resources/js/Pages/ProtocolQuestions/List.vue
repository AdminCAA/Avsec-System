<script setup>
//import Swal from 'sweetalert2';
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import Pagination from '@/Components/Pagination.vue'; ``
import { Head, Link, usePage, router } from '@inertiajs/vue3';
import dayjs from 'dayjs';
import { ref, computed, watch } from 'vue';

const { protocolQuestions } = defineProps({
  protocolQuestions: {
    type: Object,
    required: true
  },
});

const selectedRowId = ref(null);

const selectRow = (id) => {
  selectedRowId.value = id;
};

let pageNumber = ref(1);
let search = ref(usePage().props.search);

let protocolQuestionsUrl = computed(() => {
  let url = new URL(route('protocolquestions.index'));
  url.searchParams.append('page', pageNumber.value);
  if (search.value) {
    url.searchParams.append('search', search.value);
  }
  return url;
});

watch(() => protocolQuestionsUrl.value, (newUrl) => {
  router.visit(newUrl, {
    preserveScroll: true,
    preserveState: true,
    replace: true
  });
})

watch(() => search.value, (newvalue) => {
  if (newvalue) {
    pageNumber.value = 1;
  }
})


const updatePageNumber = (link) => {
  pageNumber.value = link.url.split('=')[1];
  router.visit("/protocolquestions?page=" + pageNumber.value, {
    preserveScroll: true,
  });
}

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

const deleteprotocolQuestions = (id) => {
  Swal.fire({
    title: 'Are you sure?',
    text: 'This action cannot be undone.',
    icon: 'warning',
    showCancelButton: true,
    confirmButtonColor: '#d33',
    cancelButtonColor: '#3085d6',
    confirmButtonText: 'Yes, delete it!'
  })
    .then((result) => {
      if (result.isConfirmed) {
        axios.delete(route('protocolquestions.destroy', id), { data: {} })
          .then(response => {
            Swal.fire({
              icon: 'success',
              title: 'Protocol Question was deleted successfully',
              toast: true,
              position: 'top-end',
              showConfirmButton: false,
              timer: 1000,
              timerProgressBar: true,
            });
            //redirect to the permissions index page
            setTimeout(() => {
              router.visit(route('protocolquestions.index'), {
                preserveScroll: true,
                replace: true
              });
            }, 1000);
          })
          .catch(error => {
            let message = "Something went wrong.";
            if (error.response && error.response.status === 422) {
              const errors = error.response.data.errors;
              message = Object.values(errors).flat().join("\n");
            }
            if (error.response && error.response.status === 404) {
              message = error.response.data.error;
            }
            if (error.response && error.response.status === 403) {
              message = error.response.data.errors;
            }
            Swal.fire({
              icon: "error",
              title: "Processing failed",
              text: message,
              toast: true,
              position: "top-end",
              showConfirmButton: false,
              timer: 1000,
              timerProgressBar: true,
            });
          });
      }
    })
}

//SORTING LOGIC
const sortKey = ref(null);
const sortDirection = ref('asc');

const sortTable = (key) => {
  if (sortKey.value === key) {
    // toggle between asc and desc
    sortDirection.value = sortDirection.value === 'asc' ? 'desc' : 'asc';
  } else {
    sortKey.value = key;
    sortDirection.value = 'asc';
  }
};

const getNestedValue = (obj, key) => {
  return key.split('.').reduce((o, k) => (o ? o[k] : null), obj);
};

const sortedProtocolQuestions = computed(() => {
  let sorted = [...protocolQuestions.data];
  if (sortKey.value) {
    sorted.sort((a, b) => {
      let valA = getNestedValue(a, sortKey.value);
      let valB = getNestedValue(b, sortKey.value);

      // Handle null/undefined values
      if (valA == null) valA = '';
      if (valB == null) valB = '';

      // Handle date sorting
      if (sortKey.value === 'created_at') {
        valA = new Date(valA);
        valB = new Date(valB);
      }

      if (valA < valB) return sortDirection.value === 'asc' ? -1 : 1;
      if (valA > valB) return sortDirection.value === 'asc' ? 1 : -1;
      return 0;
    });
  }
  return sorted;
});


const getStatusClass = (status) => {
  switch (status) { 
    case 'Open':
      return 'status-open';   
    case 'In Progress':
      return 'status-inprogress';
    case 'Closed':
      return 'status-closed';
    case 'Overdue':
      return 'status-overdue';
    default:
      return 'status-default';
  }
}

</script>

<template>

  <Head title="Protocol Questions" />
  <AuthenticatedLayout>
    <div class="content-wrapper">
      <div class="content-header">
        <div class="container-fluid">
          <div class="row mb-2">
            <div class="col-sm-6">
              <h3 class="m-0"><strong>Protocol Questions</strong></h3>
            </div>
            <div class="col-sm-6">
              <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item">
                  <Link class="btn btn-info" :href="route('protocolquestions.create')"><i class="fas fa-plus"></i> Create
                  </Link>
                </li>
              </ol>
            </div>
          </div>
        </div>
      </div>

      <!-- Main content -->
      <div class="content">
        <div class="container-fluid">
          <div class="row">
            <div class="col-12">
              <div class="card">
                <div class="card-body">
                  <div class="row mb-3">
                    <div class="col-md-3">
                      <div class="form-group">
                        <div class="input-group input-group-sm">
                          <input type="search" class="form-control form-control-lg"
                            placeholder="Search for Protocol Question here.." v-model="search">
                          <div class="input-group-append">
                            <button type="submit" class="btn btn-lg btn-default">
                              <i class="fa fa-search"></i>
                            </button>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="table-responsive">

                    <table v-if="protocolQuestions.data.length > 0" id="example2"
                      class="table table-sm table-bordered table-hover table-striped">
                      <thead>
                        <tr>
                          <th @click="sortTable('id')" style="cursor: pointer; width: 5px;">#</th>
                          <th @click="sortTable('question')" style="cursor: pointer; width: 100px;">
                            PQ No:
                            <i v-if="sortKey === 'pq_number'"
                              :class="sortDirection === 'asc' ? 'fas fa-sort-up' : 'fas fa-sort-down'"></i>
                          </th>

                          <th @click="sortTable('question')" style="cursor: pointer; width: 350px;">
                            Question
                            <i v-if="sortKey === 'question'"
                              :class="sortDirection === 'asc' ? 'fas fa-sort-up' : 'fas fa-sort-down'"></i>
                          </th>
                          <th @click="sortTable('answer_details')" style="cursor: pointer;width: 300px;">
                            Answer Details
                            <i v-if="sortKey === 'answer_details'"
                              :class="sortDirection === 'asc' ? 'fas fa-sort-up' : 'fas fa-sort-down'"></i>
                          </th>

                          <th style="width:200px;">References</th>
                          
                          <th @click="sortTable('answer_details')" style="cursor: pointer; width: 200px;">
                            Evidences
                            <i v-if="sortKey === 'answer_details'"
                              :class="sortDirection === 'asc' ? 'fas fa-sort-up' : 'fas fa-sort-down'"></i>
                          </th>



                         

                          <th @click="sortTable('ce_category')" style="cursor: pointer; width: 100px;">
                            CE Type
                            <i v-if="sortKey === 'ce_category'"
                              :class="sortDirection === 'asc' ? 'fas fa-sort-up' : 'fas fa-sort-down'"></i>
                          </th>

                          <th @click="sortTable('icao_reference')" style="cursor: pointer; width: 100px;">
                            ICAO Ref
                            <i v-if="sortKey === 'icao_reference'"
                              :class="sortDirection === 'asc' ? 'fas fa-sort-up' : 'fas fa-sort-down'"></i>
                          </th>

                          
                          <th @click="sortTable('answer')" style="cursor: pointer; width: 100px;">
                            Answer
                            <i v-if="sortKey === 'answer'"
                              :class="sortDirection === 'asc' ? 'fas fa-sort-up' : 'fas fa-sort-down'"></i>
                          </th>
                          <th @click="sortTable('responsible_entity')" style="cursor: pointer; width: 150px;">
                            Responsible Entity
                            <i v-if="sortKey === 'responsible_entity'"
                              :class="sortDirection === 'asc' ? 'fas fa-sort-up' : 'fas fa-sort-down'"></i>
                          </th> 
                          <th @click="sortTable('status')" style="cursor: pointer; width: 80px;">
                            Status
                            <i v-if="sortKey === 'status'"
                              :class="sortDirection === 'asc' ? 'fas fa-sort-up' : 'fas fa-sort-down'"></i>
                          </th>                                                   
                          <th style="width: 160px;">Actions</th>
                        </tr>
                      </thead>
                      <tbody>
                        <tr v-for="(question, index) in sortedProtocolQuestions" :key="question.id"
                          :class="{ 'table table-selected': selectedRowId === question.id }"
                          @click="selectRow(question.id)">

                          <td>{{ (protocolQuestions.current_page - 1) * protocolQuestions.per_page + index + 1 }}</td>
                          
                          <td class="text-center">{{ question.pq_number }}</td>
                          
                          <td class="text-center">
                            <Link :href="route('protocolquestions.edit', question.id)">
                            {{ question.question }}
                            </Link>
                          </td>
                          <td class="text-center">{{ question.answer_details }}</td>
                          <td class="text-center">
                            <!-- List of reference documents in a table -->
                            <table class="table table-sm table-hover table-bordered mt-3 align-middle">                                            
                              <tbody>
                                <tr v-for="(doc, index) in question.reference_documents" :key="doc.id">                                                
                                  <td>
                                    <a href="#" class="text-decoration-none d-flex align-items-center gap-2" @click.prevent="openDocument(doc)">
                                      <i class="fas fa-folder-open text-warning"></i> 
                                      <span style="margin-left: 4px;"> {{ doc.name }}</span>
                                    </a>
                                  </td>                                               
                                </tr>
                                <tr v-if="!question.reference_documents || question.reference_documents.length === 0">
                                  <td colspan="3" class="text-center text-muted py-3">
                                    No reference added.
                                  </td>
                                </tr>
                              </tbody>
                            </table>
                          </td>
                          
                          
                          <td class="text-center">
                            <table class="table table-sm table-hover table-bordered mt-3 align-middle">                                            
                              <tbody>
                                <tr v-for="(doc, index) in question.evidence_documents" :key="doc.id">                                                
                                  <td>
                                    <a href="#" class="text-decoration-none d-flex align-items-center gap-2" @click.prevent="openDocument(doc)">
                                      <i class="fas fa-folder-open text-warning"></i> 
                                      <span style="margin-left: 4px;"> {{ doc.name }}</span>
                                    </a>
                                  </td>                                               
                                </tr>
                                <tr v-if="!question.evidence_documents || question.evidence_documents.length === 0">
                                  <td colspan="3" class="text-center text-muted py-3">
                                    No Evidence added.
                                  </td>
                                </tr>
                              </tbody>
                            </table>
                          </td>
                         
                          <td class="text-center">{{ question.ce_category }}</td>
                          <td class="text-center">{{ question.icao_reference }}</td>
                        
                          <td class="text-center">{{ question.answer }}</td>
                          <td class="text-center">{{ question.responsible_entity}}</td>   
                          <td class="text-center">      
                            <span  :class="getStatusClass(question.status)" class="badge p-2">
                              {{ question.status }}  
                            </span>                                                  
                          </td> 
                          <!-- <td>{{ dayjs(question.created_at).format('DD-MM-YYYY') }}</td> -->
                          <td>
                            <div class="d-flex justify-content-center">
                              <Link class="btn btn-info btn-sm mr-2" :href="route('protocolquestions.edit', question.id)">
                              <i class="fas fa-edit"></i> <span>Edit</span>
                              </Link>
                              <button class="btn btn-danger btn-sm" @click="deleteprotocolQuestions(question.id)">
                                <i class="fas fa-trash"></i> <span>Del</span>
                              </button>
                            </div>
                          </td>
                        </tr>
                      </tbody>
                    </table>
                  </div>

                  <div v-if="protocolQuestions.data.length > 0" class="card mt-3">
                    <Pagination :data="protocolQuestions" :updatePageNumber="updatePageNumber" />
                  </div>
                  <div v-else class="card text-center mt-4 shadow-sm border-0">
                    <div class="card-body py-5">
                      <i class="fas fa-question-circle fa-3x text-muted mb-3"></i>
                      <h5 class="text-secondary mb-2">No Protocol Questions Available</h5>
                      <p class="text-muted mb-3">
                        There are currently no protocol questions.<br />
                        Please add new questions to begin the assessment process.
                      </p>
                      <Link :href="route('protocolquestions.create')" class="btn btn-info">
                        <i class="fas fa-plus"></i> Create a Protocol Question
                      </Link>
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

.table .table-selected {
  background-color: #bebebe !important;
  /* or any other color */
  color: white !important;
  /* or any other color */
}

.table td,
.table th {
  vertical-align: middle;
}

.table th {
  text-align: center;
  background-color: #B2C6D5;
}



.status-inprogress {
  background-color: rgba(255, 193, 7, 0.1); /* warning yellow */
  border: 1px solid #ffc107;
  color: #ffc107;
}



.status-closed {
  background-color: #f6ffed;
  border: 1px solid #b7eb8f;
  color: #389e0d;
}

.status-open {
  background-color: rgba(220, 53, 69, 0.1); /* danger red */
  border: 1px solid #dc3545;
  color: #dc3545;
}

.status-default {
  background-color: rgba(108, 117, 125, 0.1); /* secondary gray */
  border: 1px solid #6c757d;
  color: #6c757d;
}
</style>

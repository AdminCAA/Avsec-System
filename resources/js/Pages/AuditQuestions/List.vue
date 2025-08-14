
<script setup>
//import Swal from 'sweetalert2';
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import Pagination from '@/Components/Pagination.vue';``
import { Head,Link, usePage, router } from '@inertiajs/vue3';
import dayjs from 'dayjs';
import { ref ,computed, watch} from 'vue';

const {auditQuestions} = defineProps({
    auditQuestions: {
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

  let auditQuestionsUrl = computed(()=>{
        let url = new URL(route('audit-questions.index'));
        url.searchParams.append('page', pageNumber.value);
        if(search.value){
            url.searchParams.append('search', search.value);
        }        
        return url;
  });

  watch(()=>auditQuestionsUrl.value, (newUrl)=>{
    router.visit(newUrl,{
        preserveScroll: true,
        preserveState: true,
        replace: true
    });
})

watch(()=>search.value, (newvalue)=>{
    if(newvalue){
    pageNumber.value = 1;
    } 
})

   

  const updatePageNumber = (link)=>{
        pageNumber.value = link.url.split('=')[1];            
        router.visit("/audit-questions?page=" +  pageNumber.value, {
            preserveScroll:true,
        });    
  }

  const deleteAuditQuestions = (id)=>{
    Swal.fire({
      title: 'Are you sure?',
      text: 'This action cannot be undone.',
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#d33',
      cancelButtonColor: '#3085d6',
      confirmButtonText: 'Yes, delete it!'
    })
    .then((result)=>{
      if (result.isConfirmed) {
        axios.delete(route('audit-questions.destroy', id),{data:{}})
        .then(response => {            
          Swal.fire({
            icon: 'success',
            title: 'Audit question deleted successfully',
            toast: true,
            position: 'top-end',
            showConfirmButton: false,
            timer: 1000,
            timerProgressBar: true,
          });
          //redirect to the permissions index page
          setTimeout(() => {
              router.visit(route('audit-questions.index'), {
              preserveScroll: true,
              replace: true
            });          
          }, 1000);        
        })
        .catch(error => {    
          let message = "Something went wrong.";
          if (error.response && error.response.status === 422){
              const errors = error.response.data.errors;
              message = Object.values(errors).flat().join("\n");
          }
          if(error.response && error.response.status === 404) {                        
            message = error.response.data.error;
          }
          if(error.response && error.response.status === 403) {                        
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

const sortedAuditQuestions = computed(() => {
  let sorted = [...auditQuestions.data];
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


</script>

<template>
    <Head title="Audit Questions" />
    <AuthenticatedLayout>
        <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h3 class="m-0">Quality Control Questions</h3>
          </div><!-- /.col -->
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><Link class="btn btn-info" :href="route('audit-questions.create')"><i class="fas fa-plus"></i> Create</Link></li>             
            </ol>
          </div><!-- /.col -->
        </div><!-- /.row -->
      </div><!-- /.container-fluid -->
    </div>
    <!-- /.content-header -->

    <!-- Main content -->
    <div class="content">
      <div class="container-fluid">
        <div class="row">
          <div class="col-12">
            <div class="card">
              
              <!-- /.card-header -->
              <div class="card-body">

                <div class="row mb-3">
                  <div class="col-md-3">
                    <div class="form-group">
                            <div class="input-group input-group-sm">
                                <input 
                                    type="search" 
                                    class="form-control form-control-lg" 
                                    placeholder="Search for audit question here.." 
                                    v-model="search">
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

                    <table v-if="auditQuestions.data.length > 0"  id="example2" class="table table-sm table-bordered table-hover table-striped">
                    <thead>
                    <tr>
                      <th @click="sortTable('id')" style="cursor: pointer">#</th>
                      <th @click="sortTable('question')" style="cursor: pointer">
                          Question 
                          <i v-if="sortKey === 'question'" :class="sortDirection === 'asc' ? 'fas fa-sort-up' : 'fas fa-sort-down'"></i>
                      </th>

                      <th @click="sortTable('audit_area_category.name')" style="cursor: pointer">
                        Audit Area
                        <i v-if="sortKey === 'audit_area_category.name'" :class="sortDirection === 'asc' ? 'fas fa-sort-up' : 'fas fa-sort-down'"></i>  
                      </th>
                                                                           
                      <th style="width: 100px;">Created</th>   
                      <th style="width: 160px;">Actions</th>             
                    </tr>
                    </thead>
                    <tbody>
                      <tr v-for="(question, index) in sortedAuditQuestions" :key="question.id"
                        :class="{ 'table table-selected': selectedRowId === question.id }" 
                        @click="selectRow(question.id)"
                        >

                      <td>{{ (auditQuestions.current_page - 1) * auditQuestions.per_page + index + 1 }}</td>
                      
                      <td>
                        <Link :href="route('audit-questions.edit', question.id)">
                          {{ question.question }}
                        </Link>
                      </td>
                      <td>{{ question.audit_area_category.name }}</td>                                                                                                  
                      <td>{{dayjs(question.created_at).format('DD-MM-YYYY')}}</td>
                      
                      <td>
                        <div class="d-flex justify-content-center">                        
                          <Link class="btn btn-info btn-sm mr-2" :href="route('audit-questions.edit', question.id)">
                            <i class="fas fa-edit"></i> <span>Edit</span>
                          </Link>
                          <button class="btn btn-danger btn-sm" @click="deleteAuditQuestions(question.id)">
                            <i class="fas fa-trash"></i> <span>Del</span>
                          </button>
                        </div>
                      </td>                    
                    </tr>  
                    </tbody>                
                  </table>
                 </div>
                

                <div v-if="auditQuestions.data.length > 0" class="card mt-3">
                  <Pagination :data="auditQuestions" :updatePageNumber="updatePageNumber"/>                               
                </div>
                <div v-else class="card mt-3">
                  <h3 class="text-center">No question found</h3>
                  <p class="text-center">Please create a question to get started.</p>                         
                </div>                
              </div>
              <!-- /.card-body -->
            </div>
            <!-- /.card -->
   
            <!-- /.card -->
          </div>
          <!-- /.col -->
        </div>
        <!-- /.row -->
      </div><!-- /.container-fluid -->
    </div>
    <!-- /.content -->
  </div>  
    </AuthenticatedLayout>
</template>
<style>
  .table .table-selected {
    background-color: #bebebe !important; /* or any other color */
    color: white !important; /* or any other color */
  }
  
  
 
  .table td, .table th {    
        vertical-align: middle;    
    }
    .table th {
        text-align: center;
        background-color: #B2C6D5;  
    }
</style>




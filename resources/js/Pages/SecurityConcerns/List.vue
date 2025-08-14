
<script setup>
//import Swal from 'sweetalert2';
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import Pagination from '@/Components/Pagination.vue';``
import { Head,Link, usePage, router } from '@inertiajs/vue3';
import dayjs from 'dayjs';
import { ref ,computed, watch} from 'vue';

const { questionsWithConcerns} = defineProps({
   
      questionsWithConcerns: {
          type: Object,
          required: true
      }    
  });


  
  const selectedRowId = ref(null);
  
  const selectRow = (id) => {
    selectedRowId.value = id;
  };

  let pageNumber = ref(1);  
  let search = ref(usePage().props.search);

  let securityConcernsUrl = computed(()=>{
        let url = new URL(route('securityconcerns.index'));
        url.searchParams.append('page', pageNumber.value);
        if(search.value){
            url.searchParams.append('search', search.value);
        }
        // if(class_id.value){
        //     url.searchParams.append('class_id', class_id.value);
        // }
        return url;
  });

  watch(()=>securityConcernsUrl.value, (newUrl)=>{
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
        router.visit("/securityconcerns?page=" +  pageNumber.value, {
            preserveScroll:true,
        });    
  }  

  // const deletesecurityConcern = (id)=>{
  //   Swal.fire({
  //     title: 'Are you sure?',
  //     text: 'This action cannot be undone.',
  //     icon: 'warning',
  //     showCancelButton: true,
  //     confirmButtonColor: '#d33',
  //     cancelButtonColor: '#3085d6',
  //     confirmButtonText: 'Yes, delete it!'
  //   })
  //   .then((result)=>{
  //     if (result.isConfirmed) {
  //       axios.delete(route('facilities.destroy', id),{data:{}})
  //       .then(response => {            
  //         Swal.fire({
  //           icon: 'success',
  //           title: 'securityConcern deleted successfully',
  //           toast: true,
  //           position: 'top-end',
  //           showConfirmButton: false,
  //           timer: 1000,
  //           timerProgressBar: true,
  //         });
  //         //redirect to the permissions index page
  //         setTimeout(() => {
  //             router.visit(route('facilities.index'), {
  //             preserveScroll: true,
  //             replace: true
  //           });          
  //         }, 1000);        
  //       })
  //       .catch(error => {    
  //         let message = "Something went wrong.";
  //         if (error.response && error.response.status === 422){
  //             const errors = error.response.data.errors;
  //             message = Object.values(errors).flat().join("\n");
  //         }
  //         if(error.response && error.response.status === 404) {                        
  //           message = error.response.data.error;
  //         }
  //         if(error.response && error.response.status === 403) {                        
  //           message = error.response.data.errors;
  //         }
  //         Swal.fire({
  //             icon: "error",
  //             title: "Processing failed",
  //             text: message,
  //             toast: true,  
  //             position: "top-end",
  //             showConfirmButton: false,
  //             timer: 1000,
  //             timerProgressBar: true,
  //         });
  //       });
  //     }
  //   })
  // }

  const getFindingCategory = (category)=>{
    switch (category) {
      case 'Not Compliant(Serious)':
        return 'Serious';
      case 'Not Compliant(Minor)':
        return 'Minor';
      case 'Not Applicable':
        return 'Not Applicable';
      case 'Not Confirmed':
        return 'Not Confirmed';            
      default:
        return category;
    }
  }  


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

const sortedQuestionsWithConcerns = computed(() => {
  let sorted = [...questionsWithConcerns.data];
  if (sortKey.value) {
    sorted.sort((a, b) => {
      let valA = getNestedValue(a, sortKey.value);
      let valB = getNestedValue(b, sortKey.value);
      
      // Handle null/undefined values
      if (valA == null) valA = '';
      if (valB == null) valB = '';


      if (valA < valB) return sortDirection.value === 'asc' ? -1 : 1;
      if (valA > valB) return sortDirection.value === 'asc' ? 1 : -1;
      return 0;
    });
  }
  return sorted;
});


</script>

<template>
    <Head title="Security Concerns" />
    <AuthenticatedLayout>
        <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h3 class="m-0">Security Concerns</h3>
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
                                    placeholder="Search for Security Concern here.." 
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
                <table   id="example2" class="table table-sm table-bordered table-hover table-striped">
                  <thead>
                  <tr>
                    <th @click="sortTable('id')" style="cursor: pointer">#</th>
                    <!-- <th>Facility</th> -->
                    <th @click="sortTable('question')" style="cursor: pointer">
                          Question 
                          <i v-if="sortKey === 'question'" :class="sortDirection === 'asc' ? 'fas fa-sort-up' : 'fas fa-sort-down'"></i>
                    </th>

                    <th @click="sortTable('quality_control.title')" style="cursor: pointer">
                        Quality Control
                        <i v-if="sortKey === 'quality_control.title'" :class="sortDirection === 'asc' ? 'fas fa-sort-up' : 'fas fa-sort-down'"></i> 
                    </th>
                    
                    <th @click="sortTable('quality_control.control_type')" style="cursor: pointer">
                        Type
                        <i v-if="sortKey === 'quality_control.control_type'" :class="sortDirection === 'asc' ? 'fas fa-sort-up' : 'fas fa-sort-down'"></i>  
                    </th>

                    <th @click="sortTable('audit_area_name')" style="cursor: pointer">
                        Target Area
                        <i v-if="sortKey === 'audit_area_name'" :class="sortDirection === 'asc' ? 'fas fa-sort-up' : 'fas fa-sort-down'"></i>  
                    </th>  
                                               
                    <th>Status</th>       
                    <th>Category</th>       
                    <th style="width: 100px;">Modified</th>                  
                    <th style="width: 110px;">Actions</th>             
                  </tr>
                  </thead>
                  <tbody>
                    <tr v-for="(securityConcern, index) in sortedQuestionsWithConcerns" :key="securityConcern.id"
                      :class="{ 'table table-selected': selectedRowId === securityConcern.id }" 
                      @click="selectRow(securityConcern.id)">

                        <td>{{ (questionsWithConcerns.current_page - 1) * questionsWithConcerns.per_page + index + 1 }}</td>                    
                        
                        <td>          
                            <Link :href="route('securityconcerns.edit', securityConcern.id)">
                                {{ securityConcern.question}}           
                            </Link>              
                        </td>
                        <td>
                            <Link :href="route('quality-controls.edit', securityConcern.quality_control_id)">{{ securityConcern.quality_control.title }}</Link>
                        </td>

                        <td>{{ securityConcern.quality_control.control_type }}</td>

                        <td>{{ securityConcern.audit_area_name }}</td>
                                          
                        
                        <td>                        
                            <span :class="securityConcern.status==='Open','bg-danger text-white'" class="badge p-2">{{ securityConcern.status }}</span>          
                        </td>
                        <td>                        
                            {{getFindingCategory(securityConcern.finding_category) }}
                        </td>
                        <td>{{dayjs(securityConcern.updated_at).format('DD-MM-YYYY')}}</td>                                       
                        <td>
                      <div class="d-flex justify-content-end">
                        <Link class="btn btn-success btn-sm mr-2" :href="route('securityconcerns.edit', securityConcern.id)">
                            <span><i class="fas fa-sync-alt"></i> Resolve</span>
                        </Link>
                        
                      </div>
                    </td>                    
                  </tr>
 
                  </tbody>                
                </table>
                <div v-if="questionsWithConcerns.data.length > 0" class="card mt-3">
                  <Pagination :data="questionsWithConcerns" :updatePageNumber="updatePageNumber"/>                               
                </div>
                <div v-else class="card mt-3">
                  <h3 class="text-center">No Security Concern found</h3>                  
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




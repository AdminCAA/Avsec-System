
<script setup>
//import Swal from 'sweetalert2';
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import Pagination from '@/Components/Pagination.vue';``
import { Head,Link, usePage, router } from '@inertiajs/vue3';
import dayjs from 'dayjs';
import { ref ,computed, watch} from 'vue';

const {facilities} = defineProps({
    facilities: {
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

  let facilitiesUrl = computed(()=>{
        let url = new URL(route('facilities.index'));
        url.searchParams.append('page', pageNumber.value);
        if(search.value){
            url.searchParams.append('search', search.value);
        }
        // if(class_id.value){
        //     url.searchParams.append('class_id', class_id.value);
        // }
        return url;
  });

  watch(()=>facilitiesUrl.value, (newUrl)=>{
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
        router.visit("/facilities?page=" +  pageNumber.value, {
            preserveScroll:true,
        });    
  }

  const deleteFacility = (id)=>{
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
        axios.delete(route('facilities.destroy', id),{data:{}})
        .then(response => {            
          Swal.fire({
            icon: 'success',
            title: 'Facility deleted successfully',
            toast: true,
            position: 'top-end',
            showConfirmButton: false,
            timer: 1000,
            timerProgressBar: true,
          });
          //redirect to the permissions index page
          setTimeout(() => {
              router.visit(route('facilities.index'), {
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
</script>

<template>
    <Head title="Operators" />
    <AuthenticatedLayout>
        <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h3 class="m-0">Aviation Operators</h3>
          </div><!-- /.col -->
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><Link class="btn btn-info" :href="route('facilities.create')"><i class="fas fa-plus"></i> Create</Link></li>             
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
                                    placeholder="Search for facility here.." 
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
                <table v-if="facilities.data.length > 0"  id="example2" class="table table-sm table-bordered table-hover table-striped">
                  <thead>
                  <tr>
                    <th>#</th>
                    <th>Operator</th>
                    <th>Category</th>                                   
                    <th>Email</th>       
                    <th>Contact</th>  
                    <th>Created</th>   
                    <th>Actions</th>             
                  </tr>
                  </thead>
                  <tbody>
                  <tr  v-for="(facility, index) in facilities.data" :key="facility.id"
                    :class="{'table table-selected': selectedRowId === facility.id }" 
                    @click="selectRow(facility.id)"                 
                  >
                    <td>{{ (facilities.current_page - 1) * facilities.per_page + index + 1 }}</td>
                    <td>{{ facility.name }}</td>

                    <td>{{ facility.category }}</td>
                    
                                       
                    <td>                        
                        {{ facility.email }}           
                    </td>
                    <td>                        
                        {{ facility.contact_number }}          
                    </td>

                    <td>{{dayjs(facility.created_at).format('DD-MM-YYYY')}}</td>
                    
                    <td>
                      <div class="d-flex justify-content-end">
                        <Link class="btn btn-success btn-sm mr-2" :href="route('facilities.show', facility.id)">
                            <i class="fas fa-clipboard-list"></i><span> Details</span>
                        </Link>
                        <Link class="btn btn-info btn-sm mr-2" :href="route('facilities.edit', facility.id)">
                          <i class="fas fa-edit"></i> <span>Edit</span>
                        </Link>
                        <button class="btn btn-danger btn-sm" @click="deleteFacility(facility.id)">
                          <i class="fas fa-trash"></i> <span>Delete</span>
                        </button>
                      </div>
                    </td>                    
                  </tr>
 
                  </tbody>                
                </table>

                <div v-if="facilities.data.length > 0" class="card mt-3">
                  <Pagination :data="facilities" :updatePageNumber="updatePageNumber"/>                               
                </div>
                <div v-else class="card mt-3">
                  <h3 class="text-center">No Operator found</h3>
                  <p class="text-center">Please create a Operator to get started.</p>                         
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
    background-color: #4962df !important; /* or any other color */
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




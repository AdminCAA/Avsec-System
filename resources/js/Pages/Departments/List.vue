
<script setup>
//import Swal from 'sweetalert2';
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import Pagination from '@/Components/Pagination.vue';``
import { Head,Link, usePage, router } from '@inertiajs/vue3';
import dayjs from 'dayjs';
import { ref ,computed, watch} from 'vue';

const {departments} = defineProps({
    departments: {
          type: Object,
          required: true
      },    
  });

  const page = usePage()
  const roles = page.props.auth.user.roles;
  const hasRoles = (roles) => {
    const userRoles = page.props.auth.user?.roles ?? []
    // If a single role is passed as a string, wrap it in an array
    const requiredRoles = Array.isArray(roles) ? roles : [roles]
    return requiredRoles.some(role => userRoles.includes(role))
  }

  const selectedRowId = ref(null);

  
  const selectRow = (id) => {
    selectedRowId.value = id;
  };

  let pageNumber = ref(1);  

  let search = ref(usePage().props.search);
  let startDate = ref(usePage().props.start_date);
  let endDate = ref(usePage().props.end_date);
 

  let qualityControlsUrl = computed(()=>{
        let url = new URL(route('quality-controls.index'));
        url.searchParams.append('page', pageNumber.value);
        if(search.value){
            url.searchParams.append('search', search.value);
        }
        // if(class_id.value){
        //     url.searchParams.append('class_id', class_id.value);
        // }
        if(startDate.value){
            url.searchParams.append('start_date', startDate.value);
        }
        if(endDate.value){
            url.searchParams.append('end_date', endDate.value);
        }        
        return url;
  });

  watch(()=>qualityControlsUrl.value, (newUrl)=>{
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

watch([startDate, endDate], () => {
  pageNumber.value = 1; // reset to first page when filters change
  
});
   

  const updatePageNumber = (link)=>{
    pageNumber.value = link.url.split('=')[1];            
    router.visit("/departments?page=" +  pageNumber.value, {
        preserveScroll:true,
    });            
  }

  const deleteDepartment = (id)=>{
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
        axios.delete(route('departments.destroy', id),{data:{}})
        .then(response => {            
          Swal.fire({
            icon: 'success',
            title: 'Department deleted successfully',
            toast: true,
            position: 'top-end',
            showConfirmButton: false,
            timer: 1000,
            timerProgressBar: true,
          });
          //redirect to the permissions index page
          setTimeout(() => {
              router.visit(route('departments.index'), {
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
    <Head title="Departments" />
    <AuthenticatedLayout>
        <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h3 class="m-0">Departments</h3>
          </div><!-- /.col -->
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><Link class="btn btn-info" :href="route('departments.create')"><i class="fas fa-plus"></i> Create</Link></li>             
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
                 <div class="table-responsive">
                <table  v-if="departments.data.length > 0"  id="example2" class="table table-sm table-bordered table-hover table-striped">
                  <thead>
                  <tr>
                    <th>#</th>
                    <th>Name</th>
                    <th>Created</th>
                    <th>Modified</th>                     
                    <th style="width: 160px;">Actions</th>             
                  </tr>
                  </thead>
                  <tbody>
                  <tr  v-for="(item, index) in departments.data" :key="item.id"
                    :class="{'table table-selected': selectedRowId === item.id }" 
                    @click="selectRow(item.id)"                 
                  >
                    <td>{{ index + 1 }}</td>
                    <td style="text-align: center;">{{ item.name }}</td>

                                                                  
                    <td style="text-align: center;">{{dayjs(item.created_at).format('DD-MM-YYYY')}}</td>
                    <td style="text-align: center;">{{dayjs(item.updated_at).format('DD-MM-YYYY')}}</td>
                    

                    
                   

                      <!-- Avatars (Mobile / Small screens) -->
                      <!-- <td class="d-lg-none">
                        <div class="d-flex">
                          <div 
                            v-for="(user, index) in item.users" 
                            :key="user.id" 
                            class="rounded-circle border border-white overflow-hidden me-n2"
                            style="width:32px; height:32px; background:#ccc; display:flex; align-items:center; justify-content:center; font-size:0.8rem; font-weight:500;"
                            :title="user.name"
                          >
                            <img 
                              v-if="user.portrait" 
                              :src="user.portrait ? `/storage/${user.portrait}` : '/storage/portraits/avatar.png'"
                              alt="User profile picture"
                              class="w-100 h-100 object-fit-cover"
                            />
                            <span v-else>
                              {{ user.name.charAt(0).toUpperCase() }}
                            </span>
                          </div>
                        </div>
                      </td>                     -->
                    <td>
                      <div class="d-flex justify-content-center">
                        <Link class="btn btn-info btn-sm mr-2" :href="route('departments.edit', item.id)">
                          <i class="fas fa-edit"></i><span> Edit</span>
                        </Link>
                        <button v-if="hasRoles(['Super Admin'])"  class="btn btn-danger btn-sm" @click="deleteDepartment(item.id)">
                          <i class="fas fa-trash"></i> <span>Del</span>
                        </button>
                      </div>
                    </td>                    
                  </tr>
 
                  </tbody>                
                </table>
              </div>

                <div v-if="departments.data.length > 0" class="card mt-3">
                  <Pagination :data="departments" :updatePageNumber="updatePageNumber"/>                               
                </div>
                <div v-else class="card mt-3">
                  <h3 class="text-center">No item found</h3>
                  <p class="text-center">Please create a item to get started.</p>                         
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

.content-wrapper {
  font-family: 'Poppins', 'Segoe UI', sans-serif;
}

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




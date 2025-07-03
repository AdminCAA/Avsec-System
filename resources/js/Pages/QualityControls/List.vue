
<script setup>
//import Swal from 'sweetalert2';
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import Pagination from '@/Components/Pagination.vue';``
import { Head,Link, usePage, router } from '@inertiajs/vue3';
import dayjs from 'dayjs';
import { ref ,computed, watch} from 'vue';

const {qualityControls} = defineProps({
    qualityControls: {
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

  let qualityControlsUrl = computed(()=>{
        let url = new URL(route('quality-controls.index'));
        url.searchParams.append('page', pageNumber.value);
        if(search.value){
            url.searchParams.append('search', search.value);
        }
        // if(class_id.value){
        //     url.searchParams.append('class_id', class_id.value);
        // }
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

   

  const updatePageNumber = (link)=>{
        pageNumber.value = link.url.split('=')[1];            
        router.visit("/quality-controles?page=" +  pageNumber.value, {
            preserveScroll:true,
        });    
  }

  const deleteQualityControl = (id)=>{
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
        axios.delete(route('quality-controls.destroy', id),{data:{}})
        .then(response => {            
          Swal.fire({
            icon: 'success',
            title: 'Quality Control deleted successfully',
            toast: true,
            position: 'top-end',
            showConfirmButton: false,
            timer: 1000,
            timerProgressBar: true,
          });
          //redirect to the permissions index page
          setTimeout(() => {
              router.visit(route('quality-controls.index'), {
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
  const getStatusClass = (status)=>{
    switch (status) {
      case 'Pending':
        return 'bg-secondary text-white';
      case 'In Progress':
        return 'bg-info text-white';
      case 'Completed':
        return 'bg-success text-white';
      case 'Overdue':
        return 'bg-danger text-white';
      case 'Follow Up Required':
        return 'bg-warning text-dark';
      case 'Closed':
        return 'bg-dark text-white';
      default:
        return 'bg-light text-dark';
    }
  }

</script>

<template>
    <Head title="Quality Controls" />
    <AuthenticatedLayout>
        <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h3 class="m-0">Quality Control Activities</h3>
          </div><!-- /.col -->
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><Link class="btn btn-info" :href="route('quality-controls.create')"><i class="fas fa-plus"></i> Create</Link></li>             
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
                                    placeholder="Search for Quality Control Here.." 
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
                <table v-if="qualityControls.data.length > 0"  id="example2" class="table table-sm table-bordered table-hover table-striped">
                  <thead>
                  <tr>
                    <th>#</th>
                    <th>Title</th>
                    <th>Type</th>
                    <th>Institution</th> 
                    <th>Status</th>
                    <th>Date</th>                           
                    <th>Created</th>   
                    <th>Actions</th>             
                  </tr>
                  </thead>
                  <tbody>
                  <tr  v-for="(item, index) in qualityControls.data" :key="item.id"
                    :class="{'table table-selected': selectedRowId === item.id }" 
                    @click="selectRow(item.id)"                 
                  >
                    <td>{{ (qualityControls.current_page - 1) * qualityControls.per_page + index + 1 }}</td>
                    <td>{{ item.title }}</td>

                    <td>{{ item.control_type }}</td>                                                           
                    <td>                        
                        {{ item.facility.name }}           
                    </td>
                    <td :class="getStatusClass(item.status)" class="text-center">                        
                        {{ item.status }}          
                    </td>
                    <td>                        
                        {{ dayjs(item.scheduled_date).format('DD-MM-YYYY') }}          
                    </td>

                    <td>{{dayjs(item.created_at).format('DD-MM-YYYY')}}</td>
                    
                    <td>
                      <div class="d-flex justify-content-end">
                        <Link class="btn btn-info btn-sm mr-2" :href="route('quality-controls.edit', item.id)">
                          <i class="fas fa-clipboard-list"></i><span> Details</span>
                        </Link>
                        <button class="btn btn-danger btn-sm" @click="deleteQualityControl(item.id)">
                          <i class="fas fa-trash"></i> <span>Delete</span>
                        </button>
                      </div>
                    </td>                    
                  </tr>
 
                  </tbody>                
                </table>

                <div v-if="qualityControls.data.length > 0" class="card mt-3">
                  <Pagination :data="qualityControls" :updatePageNumber="updatePageNumber"/>                               
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




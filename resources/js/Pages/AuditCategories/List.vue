
<script setup>
//import Swal from 'sweetalert2';
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import Pagination from '@/Components/Pagination.vue';``
import { Head,Link, router } from '@inertiajs/vue3';
import dayjs from 'dayjs';
import { ref } from 'vue';

defineProps({
    auditAreaCategories: {
          type: Object,
          required: true
      }
  });

  const selectedRowId = ref(null);
  const selectRow = (id) => {
    selectedRowId.value = id;
  };

  let pageNumber = ref(1);  


  const updatePageNumber = (link)=>{
        pageNumber.value = link.url.split('=')[1];            
        router.visit("/audit-categories?page=" +  pageNumber.value, {
            preserveScroll:true,
        });    
  }

  const deleteAuditCategory = (id)=>{
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
        axios.delete(route('audit-categories.destroy', id),{data:{}})
        .then(response => {
          Swal.fire({
            icon: 'success',
            title: 'Audit category deleted successfully',
            toast: true,
            position: 'top-end',
            showConfirmButton: false,
            timer: 1000,
            timerProgressBar: true,
          });
          //redirect to the permissions index page
          setTimeout(() => {
              router.visit(route('audit-categories.index'), {
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
    <Head title="Areas of Audit" />
    <AuthenticatedLayout>
        <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h3 class="m-0">Quality Control Areas</h3>
          </div><!-- /.col -->
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><Link class="btn btn-info" :href="route('audit-categories.create')"><i class="fas fa-plus"></i> Create</Link></li>
             
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
                <table v-if="auditAreaCategories.data.length > 0"  id="example2" class="table table-sm table-bordered table-hover table-striped">
                  <thead>
                  <tr>
                    <th>#</th>
                    <th>Name</th>
                    <th>Target Area</th>
                    <th>Created</th>
                    <th>Actions</th>                    
                  </tr>
                  </thead>
                  <tbody>
                  <tr  v-for="(item, index) in auditAreaCategories.data" :key="item.id"
                    :class="{'table table-selected': selectedRowId === item.id }" 
                    @click="selectRow(item.id)"                 
                  >
                    <td>{{ (auditAreaCategories.current_page - 1) * auditAreaCategories.per_page + index + 1 }}</td>
                    <td>{{ item.name }}</td>
                    <td>{{ item.category_name }}</td>
                    <td>{{dayjs(item.created_at).format('DD-MM-YYYY')}}</td>
                    
                    <td>
                      <div class="d-flex justify-content-end">
                        <Link class="btn btn-info btn-sm mr-2" :href="route('audit-categories.edit', item.id)">
                          <i class="fas fa-edit"></i> <span>Edit</span>
                        </Link>
                        <button class="btn btn-danger btn-sm" @click="deleteAuditCategory(item.id)">
                          <i class="fas fa-trash"></i> <span>Delete</span>
                        </button>
                      </div>
                    </td>                    
                  </tr> 
                  </tbody>                
                </table>

                <div v-if="auditAreaCategories.data.length > 0" class="card mt-3">
                  <Pagination :data="auditAreaCategories" :updatePageNumber="updatePageNumber"/>                               
                </div>
                <div v-else class="card mt-3">
                  <h3 class="text-center">No items found</h3>
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
    background-color: #3A59D1 !important; /* or any other color */
    color: white !important; /* or any other color */
  }
  .table th {
        text-align: center;
        background-color: #B2C6D5;  
    }
</style>




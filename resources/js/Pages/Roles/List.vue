
<script setup>
//import Swal from 'sweetalert2';
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import Pagination from '@/Components/Pagination.vue';``
import { Head,Link, router } from '@inertiajs/vue3';
import dayjs from 'dayjs';
import { ref,computed } from 'vue';


const {roles} = defineProps({
      roles: {
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
        router.visit("/roles?page=" +  pageNumber.value, {
            preserveScroll:true,
        });    
  }

  const deleteRole = (id)=>{
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
        axios.delete(route('roles.destroy', id),{data:{}})
        .then(response => {
            console.log(response.data);
          Swal.fire({
            icon: 'success',
            title: 'Role deleted successfully',
            toast: true,
            position: 'top-end',
            showConfirmButton: false,
            timer: 1000,
            timerProgressBar: true,
          });
          //redirect to the permissions index page
          setTimeout(() => {
              router.visit(route('roles.index'), {
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

const sortedRoles = computed(() => {
  let sorted = [...roles.data];
  if (sortKey.value) {
    sorted.sort((a, b) => {
      let valA = a[sortKey.value];
      let valB = b[sortKey.value];

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
    <Head title="Roles" />
    <AuthenticatedLayout>
        <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h3 class="m-0">Roles</h3>
          </div><!-- /.col -->
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><Link class="btn btn-info" :href="route('roles.create')"><i class="fas fa-plus"></i> Create</Link></li>
             
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
                <table v-if="roles.data.length > 0"  id="example2" class="table table-sm table-bordered table-hover table-striped">
                  <thead>
                  <tr>
                    <th @click="sortTable('id')" style="cursor: pointer">#</th>
                    <th @click="sortTable('name')" style="cursor: pointer">
                      Role Name 
                        <i v-if="sortKey === 'name'" :class="sortDirection === 'asc' ? 'fas fa-sort-up' : 'fas fa-sort-down'"></i>
                    </th>
                    <th>Permissions</th>                    
                    <th @click="sortTable('created_at')" style="cursor: pointer">
                      Created
                      <i v-if="sortKey === 'created_at'" :class="sortDirection === 'asc' ? 'fas fa-sort-up' : 'fas fa-sort-down'"></i>
                    </th>
                    <th>Actions</th>                    
                  </tr>
                  </thead>
                  <tbody>
                    <tr v-for="(role, index) in sortedRoles" :key="role.id"
                      :class="{ 'table table-selected': selectedRowId === role.id }" 
                      @click="selectRow(role.id)">
                    <td>{{ (roles.current_page - 1) * roles.per_page + index + 1 }}</td>
                    <td class="text-center">
                      <Link :href="route('roles.edit', role.id)">{{ role.name }}</Link></td>

                    <td class="text-center">                        
                        <span v-if="role.permissions && role.permissions.length > 0">
                            <span v-for="(permission, i) in role.permissions" :key="permission.id">
                                {{ permission.name }}
                                <span v-if="i < role.permissions.length - 1">, </span>
                            </span>
                        </span>
                        <span v-else>No permissions assigned</span>                 
                    </td>

                    <td class="text-center">{{dayjs(role.created_at).format('DD-MM-YYYY')}}</td>
                    
                    <td >
                      <div class="d-flex justify-content-center">
                        <Link class="btn btn-info btn-sm mr-2" :href="route('roles.edit', role.id)">
                          <i class="fas fa-edit"></i> <span>Edit</span>
                        </Link>
                        <button class="btn btn-danger btn-sm" @click="deleteRole(role.id)">
                          <i class="fas fa-trash"></i> <span>Delete</span>
                        </button>
                      </div>
                    </td>                    
                  </tr>
 
                  </tbody>                
                </table>

                <div v-if="roles.data.length > 0" class="card mt-3">
                  <Pagination :data="roles" :updatePageNumber="updatePageNumber"/>                               
                </div>
                <div v-else class="card mt-3">
                  <h3 class="text-center">No roles found</h3>
                  <p class="text-center">Please create a role to get started.</p>                         
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

    .table th {
      text-align: center;
      background-color: #B2C6D5;
      cursor: pointer;
      user-select: none;
    }
    .table th i {
      margin-left: 5px;
    }
</style>




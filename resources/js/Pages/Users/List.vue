
<script setup>
//import Swal from 'sweetalert2';
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import Pagination from '@/Components/Pagination.vue';``
import { Head,Link,usePage, router } from '@inertiajs/vue3';
import dayjs from 'dayjs';
import { ref ,computed, watch} from 'vue';

const {users, roles} = defineProps({
      users: {
          type: Object,
          required: true
      },
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
        router.visit("/users?page=" +  pageNumber.value, {
            preserveScroll:true,
        });    
  }


  let search = ref(usePage().props.search);

  let usersUrl = computed(()=>{
        let url = new URL(route('users.index'));
        url.searchParams.append('page', pageNumber.value);
        if(search.value){
            url.searchParams.append('search', search.value);
        }
        // if(class_id.value){
        //     url.searchParams.append('class_id', class_id.value);
        // }
        return url;
  });

  watch(()=>usersUrl.value, (newUrl)=>{
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

    const disableUser2FA = (id)=>{
    Swal.fire({
      title: 'Are you sure?',
      text: 'This action will disable two-factor authentication for this user.',
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#d33',
      cancelButtonColor: '#3085d6',
      confirmButtonText: 'Yes, disable it!'
    })
    .then((result)=>{
      if (result.isConfirmed) {
        axios.post(route('users.disable2fa', id),{data:{}})
        .then(response => {                          
          Swal.fire({
            icon: 'success',
            title: 'Two-factor authentication disabled successfully',
            toast: true,
            position: 'top-end',
            showConfirmButton: false,
            timer: 1000,
            timerProgressBar: true,
          });
          //redirect to the permissions index page
          setTimeout(() => {
              router.visit(route('users.index'), {
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
  

  const deleteUser = (id)=>{
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
        axios.delete(route('users.destroy', id),{data:{}})
        .then(response => {
            console.log(response.data);
          Swal.fire({
            icon: 'success',
            title: 'User deleted successfully',
            toast: true,
            position: 'top-end',
            showConfirmButton: false,
            timer: 1000,
            timerProgressBar: true,
          });
          //redirect to the permissions index page
          setTimeout(() => {
              router.visit(route('users.index'), {
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
  console.log(users);
</script>

<template>
    <Head title="Users" />
    <AuthenticatedLayout>
        <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h3 class="m-0">Users</h3>
          </div><!-- /.col -->
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><Link class="btn btn-info" :href="route('users.create')"><i class="fas fa-plus"></i> Create</Link></li>             
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
                                    placeholder="Search for users here.." 
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
                <table v-if="users.data.length > 0"  id="example2" class="table table-sm table-bordered table-hover table-striped">
                  <thead>
                  <tr>
                    <th>#</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Department</th>
                    <th>Roles</th>                    
                    <th>Created</th>
                    
                    <th>Actions</th>                    
                  </tr>
                  </thead>
                  <tbody>
                  <tr  v-for="(user, index) in users.data" :key="user.id"
                    :class="{'table table-selected': selectedRowId === user.id }" 
                    @click="selectRow(user.id)"                 
                  >
                    <td style="text-align: center;">{{ (users.current_page - 1) * users.per_page + index + 1 }}</td>
                    <td style="text-align: center;">{{ user.name }}</td>
                    <td style="text-align: center;">{{ user.email }}</td>
                    <td style="text-align: center;">{{ user.department_name ? user.department_name : 'No department assigned' }}</td>

                    <td style="text-align: center;">                        
                        <span v-if="user.roles && user.roles.length > 0">
                            <span v-for="(role, i) in user.roles" :key="role.id">
                                {{ role.name }}
                                <span v-if="i < user.roles.length - 1">, </span>
                            </span>
                        </span>
                        <span v-else>No roles assigned</span>                 
                    </td>

                    <td style="text-align: center;">{{dayjs(user.created_at).format('DD-MM-YYYY')}}</td>
                    
                    <td>
                      
                      <div class="d-flex justify-content-center">
                        <Link class="btn btn-info btn-sm mr-2" :href="route('users.edit', user.id)">
                          <i class="fas fa-edit"></i> <span>Edit</span>
                        </Link>

                        <button v-if="user.two_factor_enabled"  class="btn btn-warning btn-sm mr-2" @click="disableUser2FA(user.id)">
                          <i class="fas fa-ban"></i> <span>Disable 2FA</span>
                        </button>
                        

                        <button class="btn btn-danger btn-sm" @click="deleteUser(user.id)">
                          <i class="fas fa-trash"></i> <span>Del</span>
                        </button>
                      </div>
                    </td>                    
                  </tr>
 
                  </tbody>                
                </table>

                <div v-if="users.data.length > 0" class="card mt-3">
                  <Pagination :data="users" :updatePageNumber="updatePageNumber"/>                               
                </div>
                <div v-else class="card mt-3">
                  <h3 class="text-center">No users found</h3>
                  <p class="text-center">Please create a user to get started.</p>                         
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




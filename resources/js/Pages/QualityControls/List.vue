
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
//   const getStatusClass = (status) => {
//   switch (status) {
//     case 'Pending':
//       return 'border border-primary text-primary bg-transparent';
//     case 'In Progress':
//       return 'border border-warning text-warning bg-transparent';
//     case 'Completed':
//       return 'border border-success text-success bg-transparent';
//     case 'Overdue':
//       return 'border border-danger text-danger bg-transparent';
//     default:
//       return 'border border-secondary text-secondary bg-transparent';
//   }
// }

const getStatusClass = (status) => {
  switch (status) {
    case 'Pending':
      return 'status-pending';
    case 'In Progress':
      return 'status-inprogress';
    case 'Completed':
      return 'status-completed';
    case 'Overdue':
      return 'status-overdue';
    default:
      return 'status-default';
  }
}


  const getUserColor= (name)=> {
    let hash = 0;
    for (let i = 0; i < name.length; i++) {
      hash = name.charCodeAt(i) + ((hash << 5) - hash);
    }
    const hue = Math.abs(hash % 360); // 0–360 for color variety
    return `hsl(${hue}, 70%, 80%)`; // pastel-like background
  }


const sortKey = ref(null);
const sortDirection = ref('asc');

const getNestedValue = (obj, key) => {
  return key.split('.').reduce((o, k) => (o ? o[k] : null), obj);
};

const sortTable = (key) => {
  if (sortKey.value === key) {
    sortDirection.value = sortDirection.value === 'asc' ? 'desc' : 'asc';
  } else {
    sortKey.value = key;
    sortDirection.value = 'asc';
  }
};

const isQualityControlActive = computed((qualityControl) => {
  return qualityControl.selected_checklist_questions?.length > 0 && qualityControl.users?.length > 0;
});

const sortedQualityControls = computed(() => {
  let sorted = [...qualityControls.data];
  if (sortKey.value) {
    sorted.sort((a, b) => {
      let valA = getNestedValue(a, sortKey.value);
      let valB = getNestedValue(b, sortKey.value);

      // Handle null/undefined values
      if (valA == null) valA = '';
      if (valB == null) valB = '';

      // Handle date sorting if needed
      if (sortKey.value.includes('created_at')) {
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
                                    placeholder="Search for Quality Control Here..." 
                                    v-model="search">
                                <div class="input-group-append">
                                    <button type="submit" class="btn btn-lg btn-default">
                                        <i class="fa fa-search"></i>
                                    </button>
                                </div>                             
                            </div>
                        </div>                        
                  </div>
                  <div class="col-md-9">                    
                    <div class="row">                      
                      <div class="col-md-3">
                        <div class="form-group d-flex align-items-center gap-2">
                          <p class="mb-0 mr-1" style="white-space: nowrap;"><strong>Start Date</strong></p>
                          <input 
                            type="date" 
                            class="form-control form-control-sm" 
                            placeholder="Start Date" 
                            v-model="startDate"                            
                          >
                        </div>
                      </div>

                      <div class="col-md-3">
                        <div class="form-group d-flex align-items-center gap-2">
                          <p class="mb-0 mr-1" style="white-space: nowrap;"><strong>End Date</strong></p>
                          <input 
                            type="date" 
                            class="form-control form-control-sm" 
                            placeholder="End Date" 
                            v-model="endDate"                          
                          >
                        </div>
                      </div>
                    </div>
                  </div> 


                 </div>
                 <div class="table-responsive">
                <table  v-if="qualityControls.data.length > 0"  id="example2" class="table table-sm table-bordered table-hover table-striped">
                  <thead>
                  <tr>
                    <th @click="sortTable('id')" style="cursor: pointer">#</th>
                    <th @click="sortTable('title')" style="cursor: pointer">
                      Title 
                      <i v-if="sortKey === 'title'" :class="sortDirection === 'asc' ? 'fas fa-sort-up' : 'fas fa-sort-down'"></i>
                    </th>
                    <th @click="sortTable('control_type')" style="cursor: pointer">
                      Type 
                      <i v-if="sortKey === 'control_type'" :class="sortDirection === 'asc' ? 'fas fa-sort-up' : 'fas fa-sort-down'"></i>
                    </th>

                    <th @click="sortTable('status')" style="cursor: pointer">
                      Status
                      <i v-if="sortKey === 'status'" :class="sortDirection === 'asc' ? 'fas fa-sort-up' : 'fas fa-sort-down'"></i>
                    </th>

                    <th @click="sortTable('facility.name')" style="cursor: pointer">
                      Operator
                      <i v-if="sortKey === 'facility.name'" :class="sortDirection === 'asc' ? 'fas fa-sort-up' : 'fas fa-sort-down'"></i> 
                    </th>
                              
                    <th @click="sortTable('scheduled_date')" style="cursor: pointer;width: 100px;">Start
                      
                      <i v-if="sortKey === 'scheduled_date'" :class="sortDirection === 'asc' ? 'fas fa-sort-up' : 'fas fa-sort-down'"></i>  
                    </th>
                    <th @click="sortTable('end_date')" style="cursor: pointer; width: 100px;">
                      End
                      <i v-if="sortKey === 'end_date'" :class="sortDirection === 'asc' ? 'fas fa-sort-up' : 'fas fa-sort-down'"></i>  
                    </th>                                                            
                    <th>Inspectors</th>
                    <th style="width:110px">Checklist</th>
                    <th style="width:140px">Actions</th>             
                  </tr>
                  </thead>
                  <tbody>
                  <tr v-for="(item, index) in sortedQualityControls" :key="item.id"
                    :class="{ 'table table-selected': selectedRowId === item.id }" 
                    @click="selectRow(item.id)"
                  >
                    <td>{{ (qualityControls.current_page - 1) * qualityControls.per_page + index + 1 }}</td>
                    <td class="text-center">
                      <Link :href="route('quality-controls.edit', item.id)">
                        {{ item.title }}
                      </Link>

                    </td>

                    <td class="text-center">{{ item.control_type }}</td>    
                    <td class="text-center">      
                      <span  :class="getStatusClass(item.status)" class="badge p-2">
                        {{ item.status }}  
                      </span>                  
                                
                    </td>                                                       
                    <td class="text-center">                        
                        {{ item.facility.name }}           
                    </td>
                    
                    <td class="text-center">                        
                        {{ dayjs(item.scheduled_date).format('DD-MM-YYYY') }}          
                    </td>

                    <td class="text-center">{{dayjs(item.end_date).format('DD-MM-YYYY')}}</td>
                    <!-- Full names (Desktop / Large screens) -->
                      <td class="d-none d-lg-table-cell">
                        <span
                          v-for="user in item.users"
                          :key="user.id"
                          class="user-badge mr-1 mb-1"
                        >
                          {{ user.name }}
                        </span>
                      </td>

                      <!-- Avatars (Mobile / Small screens) -->
                      <td class="d-lg-none">
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
                      </td>    
                      <td class="text-center">
                        <Link v-if="item.selected_checklist_questions?.length > 0 && item.users?.length > 0" 
                              class="btn btn-success btn-sm mr-2"
                              :href="route('quality-controls.show', item.id)">
                              <i class="fas fa-clipboard-check"></i><span> Checklist</span>
                        </Link>
                      </td>
             
                    <td>
                      <div class="d-flex justify-content-center">                        
                        <Link class="btn btn-info btn-sm mr-1" :href="route('quality-controls.edit', item.id)">
                          <i class="fas fa-edit"></i><span> Edit</span>
                        </Link>
                        <button v-if="hasRoles(['Super Admin'])" class="btn btn-danger btn-sm" @click="deleteQualityControl(item.id)">
                          <i class="fas fa-trash"></i> <span>Del</span>
                        </button>
                      </div>
                    </td>                    
                  </tr>
 
                  </tbody>                
                </table>
              </div>

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
    
    


    .status-pending {
  background-color: rgba(0, 123, 255, 0.1); /* primary blue at 10% opacity */
  border: 1px solid #007bff;
  color: #007bff;
}

.status-inprogress {
  background-color: rgba(255, 193, 7, 0.1); /* warning yellow */
  border: 1px solid #ffc107;
  color: #ffc107;
}



.status-completed {
  background-color: #f6ffed;
  border: 1px solid #b7eb8f;
  color: #389e0d;
}

.status-overdue {
  background-color: rgba(220, 53, 69, 0.1); /* danger red */
  border: 1px solid #dc3545;
  color: #dc3545;
}

.status-default {
  background-color: rgba(108, 117, 125, 0.1); /* secondary gray */
  border: 1px solid #6c757d;
  color: #6c757d;
}




.user-badge {
  background-color: rgba(40, 167, 69, 0.1); /* light green tint */
  border: 1px solid #28a745;                /* Bootstrap green */
  color: #28a745;                           /* matching text */
  font-size: 0.8rem;
  padding: 2px 6px;
  border-radius: 4px;
  display: inline-block;
}


</style>






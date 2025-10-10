<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import { Head, Link, useForm, router } from '@inertiajs/vue3';
import { ref, watch,computed,onMounted } from 'vue';



import Swal from 'sweetalert2';
import 'sweetalert2/dist/sweetalert2.min.css';
import InputError from '@/Components/InputError.vue';
import dayjs from 'dayjs';

const {personnel, qualifications,certifications} = defineProps({
    personnel: {
        type: Object,
        required: true
    },
    qualifications: {
        type: Array,
        required: true
    },
    certifications: {
        type: Array,
        required: true
    },
});




const selectedRowId = ref(null);
  
const selectRow = (id) => {
    selectedRowId.value = id;
};

const selectedRowId2 = ref(null);
  
const selectRow2 = (id) => {
    selectedRowId2.value = id;
};


const isLoading = ref(false);
const formErrors = ref({});

const controlTypes = ['Certifications','Qualifications']
const activeTab = ref('Certifications');

const paginatedControls = computed(() => {
  switch (activeTab.value) {
    case 'Certifications': return certifications;
    case 'Qualifications': return qualifications;    
    default: return [];
  }
});

const goToPage = (url) => {
  if (!url) return;
  router.visit(url, { preserveScroll: true, preserveState: true });
};


const deleteQualification = (id)=>{
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
        axios.delete(route('qualifications.destroy', id),{data:{}})
        .then(response => {            
          Swal.fire({
            icon: 'success',
            title: 'Qualification record deleted successfully',
            toast: true,
            position: 'top-end',
            showConfirmButton: false,
            timer: 1000,
            timerProgressBar: true,
          });
          //redirect to the permissions index page
          setTimeout(() => {
              router.visit(route('personnels.show',personnel.id), {
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

const deleteCertificate = (id)=>{
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
        axios.delete(route('certifications.destroy', id),{data:{}})
        .then(response => {            
          Swal.fire({
            icon: 'success',
            title: 'Certification record deleted successfully',
            toast: true,
            position: 'top-end',
            showConfirmButton: false,
            timer: 1000,
            timerProgressBar: true,
          });
          //redirect to the permissions index page
          setTimeout(() => {
              router.visit(route('personnels.show',personnel.id), {
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
  <Head title="Personnel Details" />
  <AuthenticatedLayout>
    <div class="content-wrapper">    
        <div class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
            <div class="col-sm-6">
                <h3 class="m-0">Personnel Details</h3>
            </div>
            <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item"><Link class="btn btn-info" data-bs-toggle="tooltip"  title="Edit" :href="route('personnels.edit',personnel.id)"><i class="fas fa-edit"></i> Edit</Link></li>
                    <li class="breadcrumb-item"><Link class="btn btn-info" data-bs-toggle="tooltip"  title="Back to Personnels" :href="route('personnels.index')"><i class="fas fa-arrow-left"></i> Back</Link></li>
                </ol>
            </div>
            </div>
        </div>
        </div>
   

    <div class="content">
      <div class="container-fluid">
        <div class="d-flex justify-content-center align-items-center min-vh-60  bg-light">
            <div class="row w-100 justify-content-center">
                
              
          <div class="col-md-3">

            <!-- Profile Image -->
            <div class="card card-info card-outline">
              <div class="card-body box-profile">                
                <div class="text-center">
                    <img class="profile-user-img img-fluid img-circle" style="width:120px"
                        :src="personnel.portrait ? 
                            `/storage/${personnel.portrait}` 
                            : '/storage/portraits/avatar.png'"
                            alt="User profile picture">
                </div>
                <h3 class="profile-username text-center">{{personnel.name}}</h3><hr>
                <p class="text-muted text-center">Category:  {{personnel.user_type}}</p>
                <p class="text-muted text-center">Status:  {{personnel.is_certified}}</p>
                <p class="text-muted text-center">Gender:  {{personnel.gender}}</p>
                <p class="text-muted text-center">NRC:  {{personnel.nrc}}</p>
                <p class="text-muted text-center">Operator: <Link :href="route('facilities.show',personnel.facility_id)">{{personnel.facility_name}}</Link></p>
                <p class="text-muted text-center">Email:  {{personnel.email}}</p>
                <p class="text-muted text-center">Contact:  {{personnel.phone_number}}</p> <hr>     
                <div class="d-flex justify-content-center mb-2">
                        <Link :href="route('qualifications.create', personnel.id)" class="btn btn-info btn-sm "><i class="fas fa-file-export"></i> Export</Link>
                     </div>                                          
              </div>              
            </div>            
          </div>          
          <div class="col-md-9">
            <div class="card card-info card-outline">
              <div class="card-header p-2">
                <ul class="nav nav-pills">
                  <li class="nav-item"><a class="nav-link active" href="#certifications" data-toggle="tab"><i class="fas fa-shield-alt"></i> Certifications</a></li>
                  <li class="nav-item"><a class="nav-link" href="#qualifications" data-toggle="tab"><i class="fas fa-user-graduate"></i> Qualifications</a></li>                  
                </ul>
              </div><!-- /.card-header -->
              <div class="card-body">
                <div class="tab-content">
                  <div class="active tab-pane" id="certifications">
                    <!-- Post -->
                     <div class="d-flex justify-content-end mb-2">
                        <Link :href="route('certifications.create', personnel.id)" data-bs-toggle="tooltip" data-bs-placement="top"  title="Add Certification" class="btn btn-info btn-sm "><i class="fas fa-plus"></i> Add New</Link>
                     </div> 
                     <div class="table-responsive">

                        <table v-if="certifications.length > 0"  id="example2" class="table table-sm table-bordered table-hover table-striped">
                    <thead>
                    <tr>
                      <th>#</th>
                      <th>Name</th>
                      <th>Issuer</th>
                      <th>Number</th>                                       
                      <th>D/Issue</th>                                                        
                      <th>E/Date</th>
                      <th>Status</th>
                      <th>Score</th>                                         
                      <th>Actions</th>             
                    </tr>
                    </thead>
                    <tbody>
                    <tr  v-for="(certificate, index) in certifications" :key="certificate.id"
                      :class="{'table table-selected': selectedRowId === certificate.id }" 
                      @click="selectRow(certificate.id)"                 
                    >
                      <td>{{  index + 1 }}</td>
                      <td>
                        {{ certificate.certification_name }}
                      </td>
                      <td>{{certificate.certification_body }}</td>
                      <td>                        
                          {{ certificate.certification_number }}           
                      </td>                    
                      <td>                        
                          {{ certificate.date_issued ? dayjs(certificate.date_issued).format('DD-MM-YYYY') : 'N/A' }}           
                      </td>
                      <td>                        
                          {{ certificate.expiry_date ? dayjs(certificate.expiry_date).format('DD-MM-YYYY') : 'N/A' }}           
                      </td>
                      <td class="text-center">
                        <span class="badge p-2" :class="certificate.status === 'Active' ? 'bg-success' : 'bg-danger'">
                          {{ certificate.status }}
                        </span>
                      </td>
                      <td>{{ certificate.score }}%</td>
                                                            
                      <td>
                        <div class="d-flex justify-content-end">
                          <a v-if="certificate.certification_file"
                              class="btn btn-success btn-sm mr-2"
                              data-bs-toggle="tooltip"
                              title="View Attachment"
                              :href="`/storage/${certificate.certification_file}`" 
                              target="_blank"
                          >
                              <i class="fas fa-paperclip"></i><span></span>
                          </a>
                          <Link class="btn btn-info btn-sm mr-2" data-bs-toggle="tooltip"  title="Edit" 
                          :href="route('certifications.edit',  certificate.id )"
  >
                            <i class="fas fa-edit"></i> <span></span>
                          </Link>
                          <button class="btn btn-danger btn-sm" data-bs-toggle="tooltip"  title="Delete" @click="deleteCertificate(certificate.id)">
                            <i class="fas fa-trash"></i> <span></span>
                          </button>
                        </div>
                      </td>                    
                    </tr> 
                    </tbody>                
                      </table>
                      <div v-else class="text-center mt-4">
                              <h5>No Certification found for this personnel</h5>
                      </div> 
                     </div>
                    
                  </div>
                  
                  <div class="tab-pane" id="qualifications">
                    <div class="d-flex justify-content-end mb-2">
                        <Link :href="route('qualifications.create', personnel.id)" class="btn btn-info btn-sm "><i class="fas fa-plus"></i> Add New</Link>
                     </div>  
                     
                     <div class="table-responsive">
                      <table v-if="qualifications.length > 0"  id="example2" class="table table-sm table-bordered table-hover table-striped">
                            <thead>
                            <tr>
                                <th>#</th>
                                <th>Name</th>
                                <th>Operator</th>
                                <th>Number</th>
                                <th>Type</th>                                       
                                <th>D/Issue</th>                                                                                                                               
                                <th>Actions</th>             
                            </tr>
                            </thead>
                            <tbody>
                            <tr  v-for="(qualification, index) in qualifications" :key="qualification.id"
                                :class="{'table table-selected': selectedRowId2 === qualification.id }" 
                                @click="selectRow2(qualification.id)"                 
                            >
                                <td>{{  index + 1 }}</td>
                                <td>
                                {{ qualification.qualification_name }}
                                </td>
                                <td>{{qualification.institution }}</td>
                                <td>{{qualification.qualification_number }}</td>
                                <td>                        
                                    {{ qualification.qualification_type }}           
                                </td>                    
                                <td>                        
                                    {{ qualification.date_obtained ? dayjs(qualification.date_obtained).format('DD-MM-YYYY') : 'N/A' }}           
                                </td>
                                                
                                                                    
                                <td>
                                <div class="d-flex justify-content-end">
                                    <a 
                                        v-if="qualification.qualification_file"
                                        class="btn btn-success btn-sm mr-2"
                                        data-bs-toggle="tooltip"
                                        title="View Attachment"
                                        :href="`/storage/${qualification.qualification_file}`" 
                                        target="_blank"
                                    >
                                        <i class="fas fa-paperclip"></i>
                                        <span></span>
                                    </a>
                                    <Link class="btn btn-info btn-sm mr-2" data-bs-toggle="tooltip"  title="Edit" 
                                    :href="route('qualifications.edit',  qualification.id )">
                                    <i class="fas fa-edit"></i> <span></span>
                                    </Link>
                                    <button class="btn btn-danger btn-sm" data-bs-toggle="tooltip"  title="Delete" @click="deleteQualification(qualification.id)">
                                    <i class="fas fa-trash"></i> <span></span>
                                    </button>
                                </div>
                                </td>                    
                            </tr>            
                            </tbody>                
                        </table> 
                        <div v-else class="text-center mt-4">
                            <h5>No qualifications found for this personnel</h5>
                        </div> 
                     </div>
                                          
                  </div>
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

  .nav-pills .nav-link.active, .nav-pills .show>.nav-link {
   color: #fff !important;
    background-color: #17a2b8 !important;

}
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
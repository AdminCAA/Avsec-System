<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import { Head, Link, useForm, router } from '@inertiajs/vue3';
import { ref, watch,computed } from 'vue';
import Swal from 'sweetalert2';
import 'sweetalert2/dist/sweetalert2.min.css';
import InputError from '@/Components/InputError.vue';
import dayjs from 'dayjs';

const {facility , qualityControlCounts,audits,inspections,securityTests } = defineProps({
  facility: {
    type: Object,
    required: true
  },  
  qualityControlCounts: {
    type:Object,
    required: true
  },
  audits: Object,
  inspections: Object,
  securityTests: Object,

});


const isLoading = ref(false);
const formErrors = ref({});
const qc = facility.quality_controls || [] ;
const controlTypes = ['Audit','Inspection','Security Test']
const activeTab = ref('Audit');
const filteredQualityControls = computed(() => {
  return qc.filter(qc => qc.control_type === activeTab.value);
});

const paginatedControls = computed(() => {
  switch (activeTab.value) {
    case 'Audit': return audits;
    case 'Inspection': return inspections;
    case 'Security Test': return securityTests;
    default: return [];
  }
});

const goToPage = (url) => {
  if (!url) return;
  router.visit(url, { preserveScroll: true, preserveState: true });
};

console.log(facility)
</script>

<template>
  <Head title="Edit Facility" />
  <AuthenticatedLayout>
    <div class="content-wrapper">    
        <div class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
            <div class="col-sm-6">
                <h3 class="m-0">Institution Details</h3>
            </div>
            <div class="col-sm-6">
                <ol class="breadcrumb float-sm-right">
                    <li class="breadcrumb-item"><Link class="btn btn-info" :href="route('facilities.edit',facility.id)"><i class="fas fa-edit"></i> Edit</Link></li>
                    <li class="breadcrumb-item"><Link class="btn btn-info" :href="route('facilities.index')"><i class="fas fa-arrow-left"></i> Back</Link></li>
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

                <h3 class="profile-username text-center">{{facility.name}}</h3>
                <p class="text-muted text-center">Category:  {{facility.category}}</p>
                <p class="text-muted text-center">Email:  {{facility.email}}</p>
                <p class="text-muted text-center">Contact:  {{facility.contact_number}}</p>
                

                <ul class="list-group list-group-unbordered mb-3">
                  <li class="list-group-item">
                    <b>Audits</b> <a class="float-right">{{qualityControlCounts.audits}}</a>
                  </li>
                  <li class="list-group-item">
                    <b>Inspections</b> <a class="float-right">{{qualityControlCounts.inspections}}</a>
                  </li>
                  <li class="list-group-item">
                    <b>Tests</b> <a class="float-right">{{qualityControlCounts.securityTests}}</a>
                  </li>
                </ul>               
              </div>
              <!-- /.card-body -->
            </div>
            <!-- /.card -->

          </div>
          <!-- /.col -->
          <div class="col-md-9">
            <div class="card card-info card-outline">
              <div class="card-header p-2">
                <ul class="nav nav-pills">
                  <li class="nav-item" v-for="type in controlTypes" :key="type">
                    <a 
                      class="nav-link"
                      :class="{active:activeTab === type}"
                      href="#" 
                      @click.prevent="activeTab =  type"
                      data-toggle="tab">{{ type }}s</a></li>                 
                </ul>
              </div>
              <div class="card-body">
                <div class="tab-content">
                  <div class="tab-content mt-4">
                    <div v-if="paginatedControls.data.length">
                      <div v-for="qc in paginatedControls.data" :key="qc.id" class="card mb-3">
                        <div class="card-body">
                          <h5 class="card-title">Title: {{ qc.title }}</h5>
                          <p class="card-text">Description: {{ qc.description }}</p>
                          <p class="card-text">Date: {{ dayjs(qc.scheduled_date).format('DD-MM-YYYY') }}</p>
                          <p class="card-text"><small class="text-muted">Type: {{ qc.control_type }}</small></p>
                          <p class="card-text"><small class="text-muted">Inspectors: [Inspectors that inspected]</small></p>
                        </div>
                        <div class="col-sm-12">
                          <ol class="float-sm-right">
                            <Link class="btn btn-info" :href="route('quality-controls.edit', qc.id)">
                              <i class="fas fa-list"></i> Details
                            </Link>
                          </ol>
                        </div>
                      </div>
                    </div>
                    <div v-else>
                      <p>No {{ activeTab }} records found.</p>
                    </div>
                     <!-- Pagination Controls -->
                <nav class="mt-4">
                  <ul class="pagination">
                    <li
                      class="page-item"
                      :class="{ disabled: !paginatedControls.prev_page_url }"
                      @click="goToPage(paginatedControls.prev_page_url)"
                    >
                      <a class="page-link" href="#">Previous</a>
                    </li>
                    <li
                      class="page-item"
                      :class="{ disabled: !paginatedControls.next_page_url }"
                      @click="goToPage(paginatedControls.next_page_url)"
                    >
                      <a class="page-link" href="#">Next</a>
                    </li>
                  </ul>
                </nav>
                  </div>
                  <!-- /.tab-pane -->
                </div>
                <!-- /.tab-content -->
              </div><!-- /.card-body -->
            </div>
            <!-- /.card -->
          </div>
          <!-- /.col -->
        
        <!-- /.row -->















            </div>
    </div>

       
      </div>
    </div>
    
  </div>  
  </AuthenticatedLayout>
</template>
<style>
  .nav-pills .nav-link.active, .nav-pills .show>.nav-link {
   color: #fff !important;
    background-color: #17a2b8 !important;
}
</style>
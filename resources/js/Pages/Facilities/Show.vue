<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import { Head, Link, useForm, router } from '@inertiajs/vue3';
import { ref, watch, computed } from 'vue';
import { Chart } from 'highcharts-vue';
import Exporting from 'highcharts/modules/exporting';
import Accessibility from 'highcharts/modules/accessibility'
import Swal from 'sweetalert2';
import 'sweetalert2/dist/sweetalert2.min.css';
import InputError from '@/Components/InputError.vue';
import dayjs from 'dayjs';

<<<<<<< HEAD
const {facility , qualityControlCounts,audits,inspections,securityTests,documentReviews,usersCount,operatorStats } = defineProps({
=======
const { facility, qualityControlCounts, audits, inspections, securityTests, usersCount, operatorStats } = defineProps({
>>>>>>> 38f8373b61a9793faa640ae28cb592a362ddca11
  facility: {
    type: Object,
    required: true
  },
  qualityControlCounts: {
    type: Object,
    required: true
  },
<<<<<<< HEAD
  audits: {type: Object, required:true},
  inspections:{type: Object, required:true},
  securityTests: {type: Object, required:true},
  documentReviews: {type: Object, required:true},
  usersCount:{type: Number, required:true},  
=======
  audits: { type: Object, required: true },
  inspections: { type: Object, required: true },
  securityTests: { type: Object, required: true },
  usersCount: { type: Number, required: true },
>>>>>>> 38f8373b61a9793faa640ae28cb592a362ddca11
});


const isLoading = ref(false);
const formErrors = ref({});
<<<<<<< HEAD
const qc = facility.quality_controls || [] ;
const controlTypes = ['Audit','Inspection','Security Test', 'Document Review']
=======
const qc = facility.quality_controls || [];
const controlTypes = ['Audit', 'Inspection', 'Security Test']
>>>>>>> 38f8373b61a9793faa640ae28cb592a362ddca11
const activeTab = ref('Audit');
const filteredQualityControls = computed(() => {
  return qc.filter(qc => qc.control_type === activeTab.value);
});

const paginatedControls = computed(() => {
  switch (activeTab.value) {
    case 'Audit': return audits;
    case 'Inspection': return inspections;
    case 'Security Test': return securityTests;
    case 'Document Review': return documentReviews;
    default: return [];
  }
});

const goToPage = (url) => {
  if (!url) return;
  router.visit(url, { preserveScroll: true, preserveState: true });
};

//const categories = [facility.name || 'Facility'];

const operatorStatisticOptions = {
  accessibility: {
    enabled: false
  },
  chart: {
    type: 'column',
    backgroundColor: '#ffffff',
    spacingTop: 20,
    spacingBottom: 20,
    style: {
      fontFamily: 'Arial, sans-serif'
    }
  },
  credits: {
    enabled: false
  },
  exporting: {
    enabled: true,
    buttons: {
      contextButton: {
        menuItems: [
          'viewFullscreen',
          'printChart',
          'separator',
          'downloadPNG',
          'downloadJPEG',
          'downloadPDF',
          'downloadSVG',
          'separator',
          'downloadCSV',
          'downloadXLS'
        ],
        symbolStroke: '#3498db',
        theme: {
          fill: '#fff',
          stroke: '#ccc',
          states: {
            hover: { fill: '#f0f0f0' },
            select: { fill: '#e0e0e0' }
          }
        }
      }
    }
  },
  title: {
    text: 'Operator Quality Control Statistics',
    style: {
      fontSize: '18px',
      fontWeight: 'bold',
      color: '#2c3e50'
    }
  },
  xAxis: {
    // categories: [facility.name || 'Facility'], // Use facility name as category
    crosshair: true,
    labels: {
      style: {
        fontSize: '12px',
        color: '#2c3e50'
      }
    },
    title: {
      text: 'Operator',
      style: {
        fontWeight: 'bold',
        color: '#2c3e50'
      }
    }
  },
  yAxis: {
    min: 0,
    title: {
      text: 'Indicator Count',
      style: {
        fontWeight: 'bold',
        color: '#2c3e50'
      }
    },
    gridLineColor: '#e6e6e6'
  },
  tooltip: {
    shared: true,
    useHTML: true,
    borderRadius: 8,
    backgroundColor: '#fdfdfd',
    headerFormat: '<b>{point.key}</b><br/>',
    pointFormat:
      '<span style="color:{series.color}">\u25CF</span> {series.name}: <b>{point.y}</b><br/>'
  },
  legend: {
    align: 'center',
    verticalAlign: 'bottom',
    layout: 'horizontal',
    itemStyle: {
      fontWeight: 'normal',
      color: '#2c3e50',
      width: '100px',
      fontSize: '11px'
    }
  },
  plotOptions: {
    column: {
      pointPadding: 0.1,
      borderWidth: 0,
      groupPadding: 0.2
    },
    series: {
      dataLabels: {
        enabled: true,
        format: '{point.y}',
        style: {
          fontSize: '11px',
          fontWeight: 'bold',
          color: '#000'
        }
      }
    }
  },
  responsive: {
    rules: [
      {
        condition: {
          maxWidth: 600
        },
        chartOptions: {
          xAxis: {
            labels: {
              rotation: -45,
              style: { fontSize: '10px' }
            }
          },
          legend: {
            itemWidth: 80
          }
        }
      }
    ]
  },
  series: [
    {
      name: 'Completed',
      data: [facility.completed_count || 0],
      color: '#2ecc71' // Green      
    },
    {
      name: 'Pending',
      data: [facility.pending_count || 0],
      color: '#3498db' // Blue      
    },
    {
      name: 'In Progress',
      data: [facility.in_progress_count || 0],
      color: '#f1c40f' // Yellow      
    },
    {
      name: 'Overdue',
      data: [facility.overdue_count || 0],
      color: '#e74c3c' // Red
    }
  ]
}


const isExporting = ref(false);

const exportPdf = async () => {
  try {
    isExporting.value = true;

    // Open PDF in new tab
    const url = route('facilities.downloadPdf', facility.id);
    window.open(url, '_blank');

    // Optional: small delay to ensure UI shows loading
    setTimeout(() => {
      isExporting.value = false;
    }, 1000);
  } catch (error) {
    isExporting.value = false;
    console.error(error);
    Swal.fire('Error', 'Failed to export PDF', 'error');
  }
};

</script>

<template>

  <Head title="Edit Operator" />
  <AuthenticatedLayout>
    <div class="content-wrapper">
      <div class="content-header">
        <div class="container-fluid">
          <div class="row mb-2">
            <div class="col-sm-6">
              <h3 class="m-0"><strong>Operator Details</strong></h3>
            </div>
            <div class="col-sm-6">
              <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item">
                  <Link class="btn btn-info" :href="route('facilities.edit', facility.id)"><i class="fas fa-edit"></i>
                  Edit</Link>
                </li>

                <li class="breadcrumb-item">
                  <a :href="route('facilities.downloadPdf', facility.id)" target="_blank" class="btn btn-info">
                    <i class="fas fa-file-pdf"></i> Export PDF
                  </a>
                </li>

                <li class="breadcrumb-item">
                  <Link class="btn btn-info" :href="route('facilities.index')"><i class="fas fa-arrow-left"></i> Back
                  </Link>
                </li>
              </ol>
            </div>
<<<<<<< HEAD
            </div>
        </div>
        </div>
   

    <div class="content">
      <div class="container-fluid">
        <div class="d-flex justify-content-center align-items-center min-vh-60  bg-light">
            <div class="row w-100 justify-content-center">
                
              
          <div class="col-md-4">

            <!-- Profile Image -->
            <div class="card card-info card-outline">
              <div class="card-body box-profile">                
                <h3 class="profile-username text-center">{{facility.name}}</h3>
                <p class="text-muted text-center">Category:  {{facility.category}}</p>
                <p class="text-muted text-center">Email:  {{facility.email}}</p>
                <p class="text-muted text-center">Contact:  {{facility.contact_number}}</p>

                <ul class="list-group list-group-unbordered mb-3">
                  <li class="list-group-item">                    
                    <h5>Audits <span class="float-right badge bg-primary">{{qualityControlCounts.audits}}</span></h5>
                  </li>
                  <li class="list-group-item">                   
                    <h5>Inspections <span class="float-right badge bg-success">{{qualityControlCounts.inspections}}</span></h5>
                  </li>
                  <li class="list-group-item">                  
                    <h5>Security Tests <span class="float-right badge bg-warning">{{qualityControlCounts.securityTests}}</span></h5>
                  </li>
                  
                  <li class="list-group-item">                 
                    <h5>Certified Personnels <span class="float-right badge bg-danger">{{usersCount}}</span></h5>
                  </li>
                </ul>               
              </div>
              <!-- /.card-body -->


              <div class="col-sm-12 mb-4">
                <Chart :options="operatorStatisticOptions" />          
              </div> 
            </div>
            <!-- /.card -->

=======
>>>>>>> 38f8373b61a9793faa640ae28cb592a362ddca11
          </div>
        </div>
      </div>
      <div class="content">
        <div class="container-fluid">
          <div class="d-flex justify-content-center align-items-center min-vh-60  bg-light">
            <div class="row w-100 justify-content-center">
              <div class="col-md-4">

                <!-- Profile Image -->
                <div class="card card-info card-outline">
                  <div class="card-body box-profile">
                    <h3 class="profile-username text-center">{{ facility.name }}</h3>
                    <p class="text-muted text-center">Category: {{ facility.category }}</p>
                    <p class="text-muted text-center">Email: {{ facility.email }}</p>
                    <p class="text-muted text-center">Contact: {{ facility.contact_number }}</p>

                    <ul class="list-group list-group-unbordered mb-3">
                      <li class="list-group-item">
                        <h5>Audits <span class="float-right badge bg-primary">{{ qualityControlCounts.audits }}</span>
                        </h5>
                      </li>
                      <li class="list-group-item">
                        <h5>Inspections <span class="float-right badge bg-success">{{ qualityControlCounts.inspections
                            }}</span></h5>
                      </li>
                      <li class="list-group-item">
                        <h5>Security Tests <span class="float-right badge bg-warning">{{
                            qualityControlCounts.securityTests }}</span></h5>
                      </li>
                      <li class="list-group-item">
                        <h5>Certified Personnels <span class="float-right badge bg-danger">{{ usersCount }}</span></h5>
                      </li>
                    </ul>
                  </div>
                  <div class="col-sm-12 mb-4">
                    <Chart :options="operatorStatisticOptions" />
                  </div>

                </div>
              </div>
              <div class="col-md-8">
                <div class="card card-info card-outline">
                  <div class="card-header p-2">
                    <ul class="nav nav-pills">
                      <li class="nav-item" v-for="type in controlTypes" :key="type">
                        <a class="nav-link" :class="{ active: activeTab === type }" href="#"
                          @click.prevent="activeTab = type" data-toggle="tab">{{ type }}s</a>
                      </li>
                    </ul>
                  </div>
                  <div class="card-body">
                    <div class="tab-content">
                      <div class="tab-content mt-4">
                        <div v-if="paginatedControls.data.length">
                          <div v-for="qc in paginatedControls.data" :key="qc.id" class="card mb-3">
                            <div class="card-body">
                              <h5 class="card-title mb-2"><i class="fas fa-align-justify"></i> Title : {{ qc.title }}
                              </h5>
                              <p class="card-text"><i class="fas fa-file-alt"></i> Description : {{ qc.description }}
                              </p>
                              <p class="card-text"><i class="fas fa-calendar-alt"></i> Start Date : {{
                                dayjs(qc.scheduled_date).format('DD-MM-YYYY') }} - End Date: {{
                                  dayjs(qc.end_date).format('DD-MM-YYYY') }}</p>
                              <p class="card-text"><i class="fas fa-shield-alt"></i> Quality Control Type : {{
                                qc.control_type }}</p>
                              <p class="card-text">
                                <i class="fas fa-users"></i> Conducted By :
                                <span class="badge px-1 mr-2" style="border-radius:10px; background-color:whitesmoke ;"
                                  v-for="(user, index) in qc.users" :key="index">
                                  <img class="profile-user-img img-fluid img-circle"
                                    :src="user.portrait ? `/storage/${user.portrait}` : '/storage/portraits/avatar.png'"
                                    alt="User profile picture">
                                  {{ user.name }}
                                </span>


                              </p>
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
                            <li class="page-item" :class="{ disabled: !paginatedControls.prev_page_url }"
                              @click="goToPage(paginatedControls.prev_page_url)">
                              <a class="page-link" href="#">Previous</a>
                            </li>
                            <li class="page-item" :class="{ disabled: !paginatedControls.next_page_url }"
                              @click="goToPage(paginatedControls.next_page_url)">
                              <a class="page-link" href="#">Next</a>
                            </li>
                          </ul>
                        </nav>
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

.nav-pills .nav-link.active,
.nav-pills .show>.nav-link {
  color: #fff !important;
  background-color: #17a2b8 !important;

}

.img-circle {
  border-radius: 50%;
}

.profile-user-img {
  border: 1px solid #adb5bd;
  margin: 0 auto;
  padding: 3px;
  width: 30px;
}

.img-fluid {
  max-width: 100%;
  height: auto;
}
</style>
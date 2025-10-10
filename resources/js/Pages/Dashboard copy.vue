<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import { Head, router, Link } from '@inertiajs/vue3';
import { Chart } from 'highcharts-vue';
import { ref, computed, watch } from 'vue';

import Exporting from 'highcharts/modules/exporting';
import Accessibility from 'highcharts/modules/accessibility'

const props = defineProps({
  stats: {
    type: Object,
    required: true
  },
});



// Example Pie Chart Options

// --- CHART OPTIONS (computed so they react to new props.stats) ---
// const pieOptions = computed(() => ({
//   chart: { type: 'pie', backgroundColor: '#fff' },
//   title: { text: 'Security Concerns' },
//   series: [
//     {
//       name: 'Concerns',
//       colorByPoint: true,
//       data: [
//         { name: 'Open', y: props.stats.openSecurityConcerns, color: '#f39c12' },
//         { name: 'Closed', y: props.stats.closedSecurityConcerns, color: '#2ecc71' },
//         { name: 'Overdue', y: props.stats.overdueSecurityConcerns, color: '#e74c3c' }
//       ]
//     }
//   ]
// }));

const pieOptions = computed(() => ({
  accessibility: {
    enabled: false
  },
  chart: {
    type: 'pie',
    backgroundColor: '#ffffff'
  },
  credits: {
    enabled: false
  },
  exporting: {
    enabled: true,
    buttons: {
      contextButton: {
        menuItems: [
          'printChart',
          'separator',
          'downloadPNG',
          'downloadJPEG',
          'downloadPDF',
          'downloadSVG'
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
    text: 'Security Concerns',
    style: { fontSize: '18px', fontWeight: 'bold', color: '#333' }
  },
  tooltip: {
    pointFormat: '<b>{point.y}</b> ({point.percentage:.1f}%)'
  },
  plotOptions: {
    pie: {
      allowPointSelect: true,
      cursor: 'pointer',
      dataLabels: {
        enabled: true,
        format: '{point.name}: {point.y}',
        style: { fontSize: '12px', fontWeight: 'bold', color: '#000' }
      },
      showInLegend: true
    }
  },
  legend: {
    align: 'center',
    verticalAlign: 'bottom',
    layout: 'horizontal',
    itemStyle: { fontWeight: 'normal', color: '#333' }
  },
  series: [
    {
      name: 'Concerns',
      colorByPoint: true,
      data: [
        { name: 'Open', y: props.stats.openSecurityConcerns, color: '#f39c12' },
        { name: 'Closed', y: props.stats.closedSecurityConcerns, color: '#2ecc71' },
        { name: 'Overdue', y: props.stats.overdueSecurityConcerns, color: '#e74c3c' }
      ]
    }
  ]
}));

//Operator Histogram Options
const operatorOptions = {
  accessibility: {
    enabled: false
  },
  chart: {
    type: 'column',
    backgroundColor: '#ffffff'
  },
  credits: {
    enabled: false
  },
  exporting: {
    enabled: true,
    buttons: {
      contextButton: {
        menuItems: [
          'printChart',
          'separator',
          'downloadPNG',
          'downloadJPEG',
          'downloadPDF',
          'downloadSVG'
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
    text: 'Number of Operators by Category',
    style: { fontSize: '18px', fontWeight: 'bold', color: '#333' }
  },
  xAxis: {
    categories: Object.keys(props.stats.operators),
    crosshair: true,
    labels: {
      rotation: -30,
      style: { fontSize: '12px', color: '#333' }
    }
  },
  yAxis: {
    min: 0,
    title: {
      text: 'Operator Count',
      style: { color: '#333', fontWeight: 'bold' }
    },
    gridLineColor: '#e6e6e6'
  },
  tooltip: {
    shared: true,
    useHTML: true,
    headerFormat: '<b>{point.key}</b><br/>',
    pointFormat:
      '<span style="color:{point.color}">\u25CF</span> Count: <b>{point.y}</b><br/>'
  },
  legend: { enabled: false },
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
        style: { fontSize: '11px', fontWeight: 'bold', color: '#000' }
      }
    }
  },
  responsive: {
    rules: [
      {
        condition: { maxWidth: 600 },
        chartOptions: {
          xAxis: {
            labels: {
              rotation: -45,
              style: { fontSize: '10px' }
            }
          }
        }
      }
    ]
  },
  series: [
    {
      name: 'Operators',
      data: Object.values(props.stats.operators),
      colorByPoint: true,
      colors: [
        '#3498db', '#f39c12', '#e74c3c', '#2ecc71', '#9b59b6',
        '#1abc9c', '#34495e', '#8e44ad', '#d35400', '#27ae60'
      ]
    }
  ]
}

const categoriesStats = computed(() =>
  props.stats.operatorStats.map(item => item.operator_name)
);

const openStats = computed(() =>
  props.stats.operatorStats.map(item => item.total_open_questions)
);

const overdueStats = computed(() =>
  props.stats.operatorStats.map(item => item.total_overdue_questions)
);

const closedStats = computed(() =>
  props.stats.operatorStats.map(item => item.total_closed_questions)
);

const totalQualityControlsStats = computed(() =>
  props.stats.operatorStats.map(item => item.quality_control_count)
);

const totalSecurityConcernsStats = computed(() =>
  props.stats.operatorStats.map(item => item.total_security)
);

// const categoriesStats = props.stats.operatorStats.map(item => item.operator_name);
// const openStats = props.stats.operatorStats.map(item => item.total_open_questions)
// const overdueStats = props.stats.operatorStats.map(item => item.total_overdue_questions)
// const closedStats = props.stats.operatorStats.map(item => item.total_closed_questions)
// const totalQualityControlsStats = props.stats.operatorStats.map(item => item.quality_control_count);
// const totalSecurityConcernsStats = props.stats.operatorStats.map(item => item.total_security);

const operatorStatisticOptions = computed(() => ({
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
    categories: categoriesStats.value,
    crosshair: true,
    labels: {
      style: {
        fontSize: '12px',
        color: '#2c3e50'
      }
    },
    title: {
      text: 'Operators',
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
      color: '#2c3e50'
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
      name: 'Quality Controls',
      data: totalQualityControlsStats.value,
      color: '#3498db' // Blue
    },
    {
      name: 'Open Issues',
      data: openStats.value,
      color: '#f39c12' // Orange
    },
    {
      name: 'Overdue Issues',
      data: overdueStats.value,
      color: '#e74c3c' // Red
    },
    {
      name: 'Total Security Issues',
      data: totalSecurityConcernsStats.value,
      color: '#9b59b6' // Purple
    },
    {
      name: 'Closed Issues',
      data: closedStats.value,
      color: '#2ecc71' // Green
    }
  ]
}));

const startDate = ref('');
const endDate = ref('');
const isLoading = ref(false);


const dashboardUrl = computed(() => {
  return route('dashboard', {
    ...(startDate.value ? { start_date: startDate.value } : {}),
    ...(endDate.value ? { end_date: endDate.value } : {}),
  });
});

// Reload dashboard data when dates change
watch([startDate, endDate], () => {
  router.visit(dashboardUrl.value, {
    preserveState: true,

    replace: true,
  });
});


// const exportPdf = async () => {
//   const chartImages = [];

//   const charts = document.querySelectorAll('.highcharts-container canvas');
//   charts.forEach((canvas) => {
//     chartImages.push(canvas.toDataURL('image/png'));
//   });

//   console.log('Captured charts:', chartImages); // Check this in the browser console

//   const response = await axios.post(route('dashboard.exportPdf'), {
//     start_date: startDate.value,
//     end_date: endDate.value,
//     charts: chartImages
//   }, { responseType: 'blob' });

//   const url = window.URL.createObjectURL(new Blob([response.data]));
//   const link = document.createElement('a');
//   link.href = url;
//   link.download = 'Quality_Control_Summary_Report.pdf';
//   link.click();
// };


const exportPdf = async () => {
  try {
    isLoading.value = true; // Start loading

    const chartImages = [];
    const charts = document.querySelectorAll('.highcharts-container canvas');

    charts.forEach((canvas) => {
      chartImages.push(canvas.toDataURL('image/png'));
    });

    console.log('Captured charts:', chartImages); // Debug

    const response = await axios.post(route('dashboard.exportPdf'), {
      start_date: startDate.value,
      end_date: endDate.value,
      charts: chartImages
    }, { responseType: 'blob' });

    const url = window.URL.createObjectURL(new Blob([response.data]));
    const link = document.createElement('a');
    link.href = url;
    link.download = 'Quality_Control_Summary_Report.pdf';
    link.click();
  } catch (error) {
    console.error(error);
  } finally {
    isLoading.value = false; // Stop loading
  }
};


</script>


<template>

  <Head title="Dashboard" />
  <AuthenticatedLayout>
    <div class="content-wrapper">
      <!-- Content Header (Page header) -->
      <div class="content-header">
        <div class="container-fluid">
          <div class="row mb-2">
            <div class="col-sm-6">
              <h3 class="m-0">Dashboard</h3>
            </div><!-- /.col -->
            <!-- <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active">Starter Page</li>
            </ol>
          </div> -->
            <!-- /.col -->
          </div><!-- /.row -->
        </div><!-- /.container-fluid -->
      </div>
      <!-- /.content-header -->

      <!-- Main content -->
      <div class="content">
        <div class="container-fluid">
          <h3 class="text-center mb-4">Quality Control Statistics</h3>
          <hr/><br/>
          <!-- <div class="row">
            <div class="col-md-9">
              <div class="row g-3 align-items-end">
                
                <div class="col-md-3 col-sm-6">
                  <div class="form-group">
                    <label for="startDate" class="form-label fw-bold">Start Date</label>
                    <input id="startDate" type="date" class="form-control form-control-sm" v-model="startDate">
                  </div>
                </div>

                
                <div class="col-md-3 col-sm-6">
                  <div class="form-group">
                    <label for="endDate" class="form-label fw-bold">End Date</label>
                    <input id="endDate" type="date" class="form-control form-control-sm" v-model="endDate">
                  </div>
                </div>

               
                <div class="col-md-3 col-sm-6">
                  <button class="btn btn-danger w-100" @click="exportPdf">
                    <i class="fas fa-file-pdf"></i> Export Summary Report PDF
                  </button>

                </div>

              </div>

            </div>
          </div> -->

          <div class="row align-items-end">
            <!-- Left side: Start and End Dates -->
            <div class="col-md-6 d-flex gap-3">
              <!-- Start Date -->
              <div class="form-group flex-grow-1">
                <label for="startDate" class="form-label fw-bold">Start Date</label>
                <input id="startDate" type="date" class="form-control form-control-sm" v-model="startDate">
              </div>

              <!-- End Date -->
              <div class="form-group flex-grow-1">
                <label for="endDate" class="form-label fw-bold">End Date</label>
                <input id="endDate" type="date" class="form-control form-control-sm" v-model="endDate">
              </div>
            </div>

            <!-- Right side: Export Button -->
            <div class="col-md-6 d-flex justify-content-end" style="padding-bottom: 15px;">
              <button class="btn"
                style="background-color: #393E46; color: #fff; height: 32px; font-size: 14px; padding: 0 12px;"
                @click="exportPdf" :disabled="isLoading">
                <i class="fas fa-file-pdf" style="margin-right: 6px;"></i>
                <span v-if="!isLoading">Export Summary Report PDF</span>
                <span v-else>
                  <i class="fas fa-spinner fa-spin" style="margin-right: 6px;"></i> Generating...
                </span>
              </button>
            </div>

          </div>


          <div class="row justify-content-center">

            <!-- Audits -->
            <div class="col-lg-3 col-6 mb-4">
              <div class="small-box bg-audit text-white">
                <div class="inner">
                  <h3>{{ props.stats.totalAudits }}</h3>
                  <p>Audits</p>
                </div>
                <div class="icon">
                  <i class="fas fa-clipboard-check"></i>
                </div>
                <Link :href="route('quality-controls.listAudits')" class="small-box-footer">
                More info <i class="fas fa-arrow-circle-right"></i>
                </Link>
              </div>
            </div>

            <!-- Inspections -->
            <div class="col-lg-3 col-6 mb-4">
              <div class="small-box bg-inspection text-white">
                <div class="inner">
                  <h3>{{ props.stats.totalInspections }}</h3>
                  <p>Inspections</p>
                </div>
                <div class="icon">
                  <i class="fas fa-search"></i>
                </div>
                <Link :href="route('quality-controls.listInspections')" class="small-box-footer">
                More info <i class="fas fa-arrow-circle-right"></i>
                </Link>
              </div>
            </div>

            <!-- Security Tests -->
            <div class="col-lg-3 col-6 mb-4">
              <div class="small-box bg-security-test text-white">
                <div class="inner">
                  <h3>{{ props.stats.totalSecurityTests }}</h3>
                  <p>Security Tests</p>
                </div>
                <div class="icon">
                  <i class="fas fa-shield-alt"></i>
                </div>
                <Link :href="route('quality-controls.listSecurityTests')" class="small-box-footer">
                More info <i class="fas fa-arrow-circle-right"></i>
                </Link>
              </div>
            </div>

            <!-- Security Concerns -->
            <div class="col-lg-3 col-6 mb-4">
              <div class="small-box bg-security-concern text-white">
                <div class="inner">
                  <h3>{{ props.stats.totalSecurityConcerns }}</h3>
                  <p>Security Concerns</p>
                </div>
                <div class="icon">
                  <i class="fas fa-exclamation-triangle"></i>
                </div>
                <Link :href="route('securityconcerns.index')" class="small-box-footer">
                More info <i class="fas fa-arrow-circle-right"></i>
                </Link>
              </div>
            </div>
          </div>

          <div class="row justify-content-center">

            <!-- Pending -->
            <div class="col-lg-3 col-6 mb-4">
              <div class="small-box bg-pending text-white">
                <div class="inner">
                  <h3>{{ props.stats.pendingQualityControls }}</h3>
                  <p>Pending</p>
                </div>
                <div class="icon">
                  <i class="fas fa-hourglass-half"></i>
                </div>
                <Link :href="route('quality-controls.listPending')" class="small-box-footer">
                More info <i class="fas fa-arrow-circle-right"></i>
                </Link>
              </div>
            </div>

            <!-- In Progress -->
            <div class="col-lg-3 col-6 mb-4">
              <div class="small-box bg-inprogress text-white">
                <div class="inner">
                  <h3>{{ props.stats.inProgressQualityControls }}</h3>
                  <p>In Progress</p>
                </div>
                <div class="icon">
                  <i class="fas fa-spinner"></i>
                </div>
                <Link :href="route('quality-controls.listInProgress')" class="small-box-footer">
                More info <i class="fas fa-arrow-circle-right"></i>
                </Link>
              </div>
            </div>

            <!-- Completed -->
            <div class="col-lg-3 col-6 mb-4">
              <div class="small-box bg-completed text-white">
                <div class="inner">
                  <h3>{{ props.stats.completedQualityControls }}</h3>
                  <p>Completed</p>
                </div>
                <div class="icon">
                  <i class="fas fa-check-circle"></i>
                </div>
                <Link :href="route('quality-controls.listCompleted')" class="small-box-footer">
                More info <i class="fas fa-arrow-circle-right"></i>
                </Link>
              </div>
            </div>

            <!-- Overdue -->
            <div class="col-lg-3 col-6 mb-4">
              <div class="small-box bg-overdue text-white">
                <div class="inner">
                  <h3>{{ props.stats.overdueQualityControls }}</h3>
                  <p>Overdue</p>
                </div>
                <div class="icon">
                  <i class="fas fa-exclamation-circle"></i>
                </div>
                <Link :href="route('quality-controls.listOverdue')" class="small-box-footer">
                More info <i class="fas fa-arrow-circle-right"></i>
                </Link>
              </div>
            </div>
          </div>

          <!-- /.col-md-6 -->
          <div class="row justify-content-center">
            <div class="col-md-4 mb-4">
              <div>
                <Chart :options="pieOptions" />
              </div>
            </div>
            <div class="col-md-8 mb-4">
              <Chart :options="operatorOptions" />
            </div>
            <div class="col-md-12 mb-4">
              <Chart :options="operatorStatisticOptions" />
            </div>
          </div>

        </div><!-- /.container-fluid -->
      </div>
      <!-- /.content -->
    </div>
  </AuthenticatedLayout>
</template>
<style scoped>
.small-box {
  transition: transform 0.2s ease-in-out;
}

.small-box:hover {
  transform: translateY(-5px);
}

.small-box {
  border-radius: 0.5rem;
  position: relative;
  display: block;
  box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.2);
  transition: transform 0.2s ease-in-out, box-shadow 0.2s ease-in-out;
}

.small-box:hover {
  transform: translateY(-3px);
  box-shadow: 0 0.3rem 0.6rem rgba(0, 0, 0, 0.25);
}

.small-box .inner {
  padding: 1rem;
}

.small-box .icon {
  position: absolute;
  top: 0.5rem;
  right: 1rem;
  font-size: 2.5rem;
  opacity: 0.2;
}

.small-box-footer {
  display: block;
  padding: 0.5rem;
  background: rgba(0, 0, 0, 0.15);
  text-align: center;
  color: #fff;
  font-weight: 500;
  border-radius: 0 0 0.5rem 0.5rem;
  text-decoration: none;
}

.small-box-footer:hover {
  background: rgba(0, 0, 0, 0.25);
}

/* Custom unique background colors */
.bg-audit {
  background-color: #007bff;
}

/* Blue */
.bg-inspection {
  background-color: #28a745;
}

/* Green */
.bg-security-test {
  background-color: #f39c12;
}

/* Amber */
.bg-security-concern {
  background-color: #dc3545;
}

/* Red */

.bg-pending {
  background-color: #17a2b8;
}

/* Cyan */
.bg-inprogress {
  background-color: #6f42c1;
}

/* Purple */
.bg-completed {
  background-color: #20c997;
}

/* Teal */
.bg-overdue {
  background-color: #fd7e14;
}

/* Orange */
.small-box .icon {
  position: absolute;
  top: 0.5rem;
  right: 1rem;
  font-size: 2.5rem;
  opacity: 0.85;
  color: rgba(255, 255, 255, 0.95);
  text-shadow: 0 0 5px rgba(0, 0, 0, 0.3);
}
</style>

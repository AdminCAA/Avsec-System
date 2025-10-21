<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import Pagination from '@/Components/Pagination.vue'; ``
import { Head, Link, usePage, router } from '@inertiajs/vue3';
import dayjs from 'dayjs';
import { ref, computed, watch } from 'vue';

const { logs } = defineProps({
  logs: {
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
  const isDownloading = ref(false);
  
  const selectRow = (id) => {
    selectedRowId.value = id;
  };

let pageNumber = ref(1);
let search = ref(usePage().props.search);

let logsUrl = computed(() => {
  let url = new URL(route('logs.index'));
  url.searchParams.append('page', pageNumber.value);
  if (search.value) {
    url.searchParams.append('search', search.value);
  }

  return url;
});

watch(() => logsUrl.value, (newUrl) => {
  router.visit(newUrl, {
    preserveScroll: true,
    preserveState: true,
    replace: true
  });
})

watch(() => search.value, (newvalue) => {
  if (newvalue) {
    pageNumber.value = 1;
  }
})



const updatePageNumber = (link) => {
  pageNumber.value = link.url.split('=')[1];
  router.visit("/logs?page=" + pageNumber.value, {
    preserveScroll: true,
  });
}

const clearAllLogs = () => {
  Swal.fire({
    title: 'Are you sure?',
    text: 'This action cannot be undone.',
    icon: 'warning',
    showCancelButton: true,
    confirmButtonColor: '#d33',
    cancelButtonColor: '#3085d6',
    confirmButtonText: 'Yes, delete it!'
  })
    .then((result) => {
      if (result.isConfirmed) {        
        axios.delete(route('logs.clear'), { data: {} })
          .then(response => {
            Swal.fire({
              icon: 'success',
              title: 'All Logs deleted successfully',
              toast: true,
              position: 'top-end',
              showConfirmButton: false,
              timer: 1000,
              timerProgressBar: true,
            });
            //redirect to the permissions index page
            setTimeout(() => {
              router.visit(route('logs.index'), {
                preserveScroll: true,
                replace: true
              });
            }, 1000);
          })
          .catch(error => {
            let message = "Something went wrong.";
            if (error.response && error.response.status === 422) {
              const errors = error.response.data.errors;
              message = Object.values(errors).flat().join("\n");
            }
            if (error.response && error.response.status === 404) {
              message = error.response.data.error;
            }
            if (error.response && error.response.status === 403) {
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

const sortedLogs = computed(() => {
  let sorted = [...logs.data];
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

  <Head title="Logs" />
  <AuthenticatedLayout>
    <div class="content-wrapper">
      <div class="content-header">
        <div class="container-fluid">
          <div class="row mb-2">
            <div class="col-sm-6">
              <h3 class="m-0"><strong>System Logs</strong></h3>
            </div><!-- /.col -->
            
            <div class="col-sm-6">
              <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item">
                  <button v-if="hasRoles(['Super Admin'])" class="btn btn-danger"  @click="clearAllLogs"><i class="fas fa-trash"></i> Clear All
                  </button>
                </li>
              </ol>
            </div>
          </div>
        </div>
      </div>

      <!-- Main content -->
      <div class="content">
        <div class="container-fluid">
          <div class="row">
            <div class="col-12">
              <div class="card">
                <div class="card-body">                  
                  <div class="table-responsive">
                    <table class="table table-bordered table-striped table-hover align-middle">
                        <thead class="table-light">
                        <tr>
                            <th>#</th>
                            <th>Date/Time</th>
                            <th>Level</th>
                            <th>Message</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr v-for="(log, index) in logs.data" :key="index" 
                            :class="{ 'table table-selected': selectedRowId === index }"
                            @click="selectRow(index)">
                            <td>{{ (logs.current_page - 1) * logs.per_page + index + 1 }}</td>
                            <td>{{ log.datetime }}</td>
                            <td>
                            <span
                                class="badge"
                                :class="{
                                'bg-danger': log.level.toLowerCase() === 'error',
                                'bg-warning text-dark': log.level.toLowerCase() === 'warning',
                                'bg-success': log.level.toLowerCase() === 'info',
                                }"
                            >
                                {{ log.level }}
                            </span>
                            </td>
                            <td class="text-break">{{ log.message }}</td>
                        </tr>
                        <tr v-if="!logs.data.length">
                            <td colspan="4" class="text-center text-muted py-3">
                            No logs found.
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    </div>

                  <div v-if="logs.data.length > 0" class="card mt-3">
                    <Pagination :data="logs" :updatePageNumber="updatePageNumber" />
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

.table .table-selected {
  background-color: #bebebe !important;
  color: white !important;
}

.table td,
.table th {
  vertical-align: middle;
}

.table th {
  text-align: left;
  background-color: #B2C6D5;
}

.table th {
  text-align: left;
  background-color: #B2C6D5;
  cursor: pointer;
  user-select: none;
}

.table th i {
  margin-left: 5px;
}

#example2 th {
  font-size: 17px;
  font-weight: 700;
  color: #555657;
  text-align: center;
  vertical-align: middle;
  padding: 12px;
  letter-spacing: 0.5px;
}

.custom-btn {
  background-color: #44444E;
  border-color: #44444E;
  color: #fff;
  transition: all 0.3s ease;
}

.custom-btn:hover:not(:disabled) {
  background-color: #5a5a65;
  border-color: #5a5a65;
  color: #fff;
}

.custom-btn:disabled {
  opacity: 0.7;
  cursor: not-allowed;
}

.icon-space {
  margin-right: 10px;
}

</style>

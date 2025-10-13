<script setup>
//import Swal from 'sweetalert2';
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import Pagination from '@/Components/Pagination.vue'; ``
import { Head, Link, usePage, router } from '@inertiajs/vue3';
import dayjs from 'dayjs';
import { ref, computed, watch } from 'vue';

const { securityEquipments } = defineProps({
  securityEquipments: {
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

let securityEquipmentsUrl = computed(() => {
  let url = new URL(route('security-equipments.index'));
  url.searchParams.append('page', pageNumber.value);
  if (search.value) {
    url.searchParams.append('search', search.value);
  }
  // if(class_id.value){
  //     url.searchParams.append('class_id', class_id.value);
  // }
  return url;
});

watch(() => securityEquipmentsUrl.value, (newUrl) => {
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
  router.visit("/security-equipments?page=" + pageNumber.value, {
    preserveScroll: true,
  });
}

const deleteSecurityEquipment = (id) => {
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
        axios.delete(route('security-equipments.destroy', id), { data: {} })
          .then(response => {
            Swal.fire({
              icon: 'success',
              title: 'Security Equipment deleted successfully',
              toast: true,
              position: 'top-end',
              showConfirmButton: false,
              timer: 1000,
              timerProgressBar: true,
            });
            //redirect to the permissions index page
            setTimeout(() => {
              router.visit(route('security-equipments.index'), {
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

const getStatusClass = (status) => {
  switch (status) {
    case 'Under Maintenance':
      return 'status-under-maintenance';
    case 'Serviceable':
      return 'status-active';
    case 'Due for Maintenance':
      return 'status-due-maintenance';
    case 'Decommissioned':
      return 'status-decommissioned';
    case 'Unserviceable':
      return 'status-inactive';
    default:
      return 'status-default';
  }
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

const sortedSecurityEquipments = computed(() => {
  let sorted = [...securityEquipments.data];
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

  <Head title="Security Equipment" />
  <AuthenticatedLayout>
    <div class="content-wrapper">
      <div class="content-header">
        <div class="container-fluid">
          <div class="row mb-2">
            <div class="col-sm-6">
              <h3 class="m-0"><strong>Aviation Security Equipment</strong></h3>
            </div>
            <div class="col-sm-6">
              <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item">
                  <Link class="btn btn-info" :href="route('security-equipments.create')"><i class="fas fa-plus"></i>
                  Create</Link>
                </li>
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
                          <input type="search" class="form-control form-control-lg"
                            placeholder="Search for Equipment here.." v-model="search">
                          <div class="input-group-append">
                            <button type="submit" class="btn btn-lg btn-default">
                              <i class="fa fa-search"></i>
                            </button>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                  <table v-if="securityEquipments.data.length > 0" id="example2"
                    class="table table-sm table-bordered table-hover table-striped">
                    <thead>
                      <tr>
                        <th>#</th>
                        <th @click="sortTable('name')" style="cursor: pointer" class="text-left">
                          Name
                          <i v-if="sortKey === 'name'"
                            :class="sortDirection === 'asc' ? 'fas fa-sort-up' : 'fas fa-sort-down'"></i>
                        </th>
                        <th class="text-left">Serial</th>
                        <th class="text-left">Status</th>

                        <th @click="sortTable('facility_name')" style="cursor: pointer" class="text-left">
                          Operator
                          <i v-if="sortKey === 'facility_name'"
                            :class="sortDirection === 'asc' ? 'fas fa-sort-up' : 'fas fa-sort-down'"></i>
                        </th>


                        <th class="text-left">Created</th>
                        <th>Actions</th>
                      </tr>
                    </thead>
                    <tbody>
                      <tr v-for="(equipment, index) in sortedSecurityEquipments" :key="equipment.id"
                        :class="{ 'table table-selected': selectedRowId === equipment.id }"
                        @click="selectRow(equipment.id)">
                        <td>{{ (securityEquipments.current_page - 1) * securityEquipments.per_page + index + 1 }}</td>

                        <td>
                          <Link :href="route('security-equipments.edit', equipment.id)">{{ equipment.name }}
                          </Link>
                        </td>

                        <td>
                          {{ equipment.serial_number }}
                        </td>
                        <td class="text-left">
                          <span :class="getStatusClass(equipment.status)" class="badge p-2">
                            {{ equipment.status }}
                          </span>
                        </td>
                        <td>
                          <Link :href="route('facilities.show', equipment.facility_id)">
                          {{ equipment.facility_name }}
                          </Link>
                        </td>




                        <td>{{ dayjs(equipment.created_at).format('DD-MM-YYYY') }}</td>

                        <td>
                          <div class="d-flex justify-content-center">
                            <Link class="btn btn-info btn-sm mr-2"
                              :href="route('security-equipments.edit', equipment.id)">
                            <i class="fas fa-edit"></i> <span>Edit</span>
                            </Link>
                            <button class="btn btn-danger btn-sm" @click="deleteSecurityEquipment(equipment.id)">
                              <i class="fas fa-trash"></i> <span>Del</span>
                            </button>
                          </div>
                        </td>
                      </tr>

                    </tbody>
                  </table>

                  <div v-if="securityEquipments.data.length > 0" class="card mt-3">
                    <Pagination :data="securityEquipments" :updatePageNumber="updatePageNumber" />
                  </div>
                  <div v-else class="card mt-3">
                    <h3 class="text-center">No Security equipment found</h3>
                    <p class="text-center">Please create a equipment to get started.</p>
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
  /* or any other color */
  color: white !important;
  /* or any other color */
}


.table td,
.table th {
  vertical-align: middle;
}

.table th {
  text-align: center;
  background-color: #B2C6D5;
}



.status-under-maintenance {
  background-color: rgba(23, 162, 184, 0.1);
  /* info cyan */
  /* border: 1px solid #17a2b8; */
  color: #17a2b8;
}


.status-active {
  background-color: #f6ffed;
  /* border: 1px solid #b7eb8f; */
  color: #389e0d;
}

.status-due-maintenance {
  background-color: rgba(220, 53, 69, 0.1);
  /* danger red */
  /* border: 1px solid #dc3545; */
  color: #dc3545;
}

.status-decommissioned {
  background-color: rgba(255, 193, 7, 0.1);
  /* warning yellow */
  /* border: 1px solid #ffc107; */
  color: #ffc107;
}

.status-inactive {
  background-color: rgba(52, 58, 64, 0.1);
  /* border: 1px solid #343a40; */
  color: #343a40;
}

.status-default {
  background-color: rgba(108, 117, 125, 0.1);
  /* light gray */
  /* border: 1px solid #6c757d; */
  color: #6c757d;
}
</style>

<script setup>
//import Swal from 'sweetalert2';
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import Pagination from '@/Components/Pagination.vue'; ``
import { Head, Link, usePage, router } from '@inertiajs/vue3';
import dayjs from 'dayjs';
import { ref, computed, watch } from 'vue';

const { personnels } = defineProps({
  personnels: {
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

let personnelsUrl = computed(() => {
  let url = new URL(route('personnels.index'));
  url.searchParams.append('page', pageNumber.value);
  if (search.value) {
    url.searchParams.append('search', search.value);
  }
  // if(class_id.value){
  //     url.searchParams.append('class_id', class_id.value);
  // }
  return url;
});

watch(() => personnelsUrl.value, (newUrl) => {
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
  router.visit("/personnels?page=" + pageNumber.value, {
    preserveScroll: true,
  });
}

const deleteOfficer = (id) => {
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
        axios.delete(route('officers.destroy', id), { data: {} })
          .then(response => {
            Swal.fire({
              icon: 'success',
              title: 'Avsec Officer record deleted successfully',
              toast: true,
              position: 'top-end',
              showConfirmButton: false,
              timer: 1000,
              timerProgressBar: true,
            });
            //redirect to the permissions index page
            setTimeout(() => {
              router.visit(route('officers.index'), {
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

const sortedPersonnels = computed(() => {
  let sorted = [...personnels.data];
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

  <Head title="Avsec Officers" />
  <AuthenticatedLayout>
    <div class="content-wrapper">
      <div class="content-header">
        <div class="container-fluid">
          <div class="row mb-2">
            <div class="col-sm-6">
              <h3 class="m-0"><strong>AVSEC Officers</strong></h3>
            </div>
            <div class="col-sm-6">
              <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item">
                  <Link class="btn btn-info" :href="route('officers.create')"><i class="fas fa-plus"></i> Create</Link>
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

                <!-- /.card-header -->
                <div class="card-body">
                  <div class="row mb-3">
                    <div class="col-md-3">
                      <div class="form-group">
                        <div class="input-group input-group-sm">
                          <input type="search" class="form-control form-control-lg"
                            placeholder="Search for personnel here.." v-model="search">
                          <div class="input-group-append">
                            <button type="submit" class="btn btn-lg btn-default">
                              <i class="fa fa-search"></i>
                            </button>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="table-responsive">
                    <table v-if="personnels.data.length > 0" id="example2"
                      class="table table-sm table-bordered table-hover table-striped">
                      <thead>
                        <tr>
                          <th>#</th>
                          <th>Avatar</th>
                          <th @click="sortTable('name')" style="cursor: pointer;">
                            Names
                            <i v-if="sortKey === 'name'"
                              :class="sortDirection === 'asc' ? 'fas fa-sort-up' : 'fas fa-sort-down'"></i>
                          </th>
                          <th @click="sortTable('gender')" style="cursor: pointer;">
                            Gender
                            <i v-if="sortKey === 'gender'"
                              :class="sortDirection === 'asc' ? 'fas fa-sort-up' : 'fas fa-sort-down'"></i>
                          </th>
                          <th @click="sortTable('email')" style="cursor: pointer;">
                            Email
                            <i v-if="sortKey === 'email'"
                              :class="sortDirection === 'asc' ? 'fas fa-sort-up' : 'fas fa-sort-down'"></i>
                          </th>
                          <th @click="sortTable('nrc')" style="cursor: pointer;">
                            NRC
                            <i v-if="sortKey === 'nrc'"
                              :class="sortDirection === 'asc' ? 'fas fa-sort-up' : 'fas fa-sort-down'"></i>
                          </th>

                          <th @click="sortTable('phone_number')" style="cursor: pointer;">
                            Phone
                            <i v-if="sortKey === 'phone_number'"
                              :class="sortDirection === 'asc' ? 'fas fa-sort-up' : 'fas fa-sort-down'"></i>
                          </th>
                          <th @click="sortTable('is_certified')" style="cursor: pointer;">
                            Status
                            <i v-if="sortKey === 'is_certified'"
                              :class="sortDirection === 'asc' ? 'fas fa-sort-up' : 'fas fa-sort-down'"></i>
                          </th>
                          <th @click="sortTable('user_type')" style="cursor: pointer;">
                            Category
                            <i v-if="sortKey === 'user_type'"
                              :class="sortDirection === 'asc' ? 'fas fa-sort-up' : 'fas fa-sort-down'"></i>
                          </th>
                          <th @click="sortTable('facility_name')" style="cursor: pointer;">
                            Operator
                            <i v-if="sortKey === 'facility_name'"
                              :class="sortDirection === 'asc' ? 'fas fa-sort-up' : 'fas fa-sort-down'"></i>
                          </th>
                          <th @click="sortTable('created_at')" style="cursor: pointer;">
                            Created
                            <i v-if="sortKey === 'created_at'"
                              :class="sortDirection === 'asc' ? 'fas fa-sort-up' : 'fas fa-sort-down'"></i>
                          </th>

                          <th style="width: 240px;">Actions</th>
                        </tr>
                      </thead>
                      <tbody>

                        <tr v-for="(personnel, index) in sortedPersonnels" :key="personnel.id"
                          :class="{ 'table table-selected': selectedRowId === personnel.id }"
                          @click="selectRow(personnel.id)">
                          <td>{{ (personnels.current_page - 1) * personnels.per_page + index + 1 }}</td>
                          <td class="text-center">
                            <div class="d-flex align-items-center">
                              <div class="d-flex align-items-center">
                                <img
                                  :src="personnel.portrait ? `/storage/${personnel.portrait}` : '/storage/portraits/avatar.png'"
                                  class="rounded-circle mr-2" width="30" height="30" alt="Avatar">
                              </div>
                            </div>
                          </td>
                          <td>
                            <Link :href="route('officers.show', personnel.id)">
                            {{ personnel.name }}
                            </Link>
                          </td>
                          <td>{{ personnel.gender }}</td>
                          <td>
                            {{ personnel.email }}
                          </td>
                          <td>{{ personnel.nrc }}</td>
                          <td>
                            {{ personnel.phone_number }}
                          </td>
                          <td>
                            <span class="badge p-2"
                              :class="personnel.is_certified === 'Certified' ? 'certified' : 'not-certified'">
                              {{ personnel.is_certified }}
                            </span>
                          </td>

                          <td>{{ personnel.user_type }}</td>
                          <td>
                            <Link v-if="personnel.facility_id" :href="route('facilities.show', personnel.facility_id)">
                            {{ personnel.facility_name }}
                            </Link>
                          </td>

                          <td>{{ dayjs(personnel.created_at).format('DD-MM-YYYY') }}</td>

                          <td class="text-center">
                            <div class="d-flex justify-content-end">
                              <Link class="btn btn-success btn-sm mr-2" :href="route('officers.show', personnel.id)">
                              <i class="fas fa-clipboard-list"></i><span> Details</span>
                              </Link>
                              <Link class="btn btn-info btn-sm mr-2" :href="route('officers.edit', personnel.id)">
                              <i class="fas fa-edit"></i> <span>Edit</span>
                              </Link>
                              <button v-if="hasRoles(['Super Admin'])" class="btn btn-danger btn-sm"
                                @click="deleteOfficer(personnel.id)">
                                <i class="fas fa-trash"></i> <span>Del</span>
                              </button>
                            </div>
                          </td>
                        </tr>
                      </tbody>
                    </table>
                  </div>
                  <div v-if="personnels.data.length > 0" class="card mt-3">
                    <Pagination :data="personnels" :updatePageNumber="updatePageNumber" />
                  </div>
                  <div v-else class="card mt-3">
                    <h3 class="text-center">No personnel found</h3>
                    <p class="text-center">Please create a personnel to get started.</p>
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
  text-align: center;
  background-color: #B2C6D5;
}


.certified {
  background-color: #f6ffed;
  border: 1px solid #b7eb8f;
  color: #389e0d;
}

.not-certified {
  background-color: rgba(220, 53, 69, 0.1);
  /* light red tint */
  border: 1px solid #dc3545;
  color: #dc3545;
}
</style>

<script setup>
//import Swal from 'sweetalert2';
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import Pagination from '@/Components/Pagination.vue'; ``
import { Head, Link, usePage, router } from '@inertiajs/vue3';

import dayjs from 'dayjs';
import { ref, computed, watch } from 'vue';

const { auditAreaCategories } = defineProps({
  auditAreaCategories: {
    type: Object,
    required: true
  }
});

const selectedRowId = ref(null);
const selectRow = (id) => {
  selectedRowId.value = id;
};

let pageNumber = ref(1);

let search = ref(usePage().props.search);

let qcAreaUrl = computed(() => {
  let url = new URL(route('audit-categories.index'));
  url.searchParams.append('page', pageNumber.value);
  if (search.value) {
    url.searchParams.append('search', search.value);
  }
  // if(class_id.value){
  //     url.searchParams.append('class_id', class_id.value);
  // }
  return url;
});

const updatePageNumber = (link) => {
  pageNumber.value = link.url.split('=')[1];
  router.visit("/audit-categories?page=" + pageNumber.value, {
    preserveScroll: true,
  });
}

watch(() => qcAreaUrl.value, (newUrl) => {
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


const deleteAuditCategory = (id) => {
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
        axios.delete(route('audit-categories.destroy', id), { data: {} })
          .then(response => {
            Swal.fire({
              icon: 'success',
              title: 'Audit category deleted successfully',
              toast: true,
              position: 'top-end',
              showConfirmButton: false,
              timer: 1000,
              timerProgressBar: true,
            });
            //redirect to the permissions index page
            setTimeout(() => {
              router.visit(route('audit-categories.index'), {
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

const sortedAuditAreaCategories = computed(() => {
  let sorted = [...auditAreaCategories.data];
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

  <Head title="Areas of Quality Control" />
  <AuthenticatedLayout>
    <div class="content-wrapper">
      <div class="content-header">
        <div class="container-fluid">
          <div class="row mb-2">
            <div class="col-sm-6">
              <h3 class="m-0"><strong>Quality Control Areas</strong></h3>
            </div>
            <div class="col-sm-6">
              <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item">
                  <Link class="btn btn-info" :href="route('audit-categories.create')"><i class="fas fa-plus"></i> Create
                  </Link>
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
                  <div class="row mb-3">
                    <div class="col-md-3">
                      <div class="form-group">
                        <div class="input-group input-group-sm">
                          <input type="search" class="form-control form-control-lg"
                            placeholder="Search for Quality Control Area" v-model="search">
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
                    <table v-if="auditAreaCategories.data.length > 0" id="example2"
                      class="table table-sm table-bordered table-hover table-striped">
                      <thead>
                        <tr>
                          <th>#</th>
                          <th @click="sortTable('name')" style="cursor: pointer">
                            Area Name
                            <i v-if="sortKey === 'name'"
                              :class="sortDirection === 'asc' ? 'fas fa-sort-up' : 'fas fa-sort-down'"></i>
                          </th>
                          <th @click="sortTable('category_name')" style="cursor: pointer">
                            Target Operator
                            <i v-if="sortKey === 'category_name'"
                              :class="sortDirection === 'asc' ? 'fas fa-sort-up' : 'fas fa-sort-down'"></i>
                          </th>
                          <th @click="sortTable('created_at')" style="cursor: pointer">
                            Created
                            <i v-if="sortKey === 'created_at'"
                              :class="sortDirection === 'asc' ? 'fas fa-sort-up' : 'fas fa-sort-down'"></i>
                          </th>
                          <th>Actions</th>
                        </tr>
                      </thead>
                      <tbody>
                        <tr v-for="(item, index) in sortedAuditAreaCategories" :key="item.id"
                          :class="{ 'table table-selected': selectedRowId === item.id }" @click="selectRow(item.id)">
                          <td>{{ (auditAreaCategories.current_page - 1) * auditAreaCategories.per_page + index + 1 }}
                          </td>
                          <td>
                            <Link :href="route('audit-categories.edit', item.id)">
                            {{ item.name }}
                            </Link>
                          </td>
                          <td>{{ item.category_name }}</td>
                          <td>{{ dayjs(item.created_at).format('DD-MM-YYYY') }}</td>
                          <td>
                            <div class="d-flex justify-content-center">
                              <Link class="btn btn-info btn-sm mr-2" :href="route('audit-categories.edit', item.id)">
                              <i class="fas fa-edit"></i> <span>Edit</span>
                              </Link>
                              <button class="btn btn-danger btn-sm" @click="deleteAuditCategory(item.id)">
                                <i class="fas fa-trash"></i> <span>Del</span>
                              </button>
                            </div>
                          </td>
                        </tr>
                      </tbody>
                    </table>
                  </div>

                  <div v-if="auditAreaCategories.data.length > 0" class="card mt-3">
                    <Pagination :data="auditAreaCategories" :updatePageNumber="updatePageNumber" />
                  </div>
                  <div v-else class="card mt-3">
                    <h3>No items found</h3>
                    <p>Please create a item to get started.</p>
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

.table th {
  text-align: center;
  background-color: #B2C6D5;
}
</style>

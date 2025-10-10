<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import Pagination from '@/Components/Pagination.vue'; ``
import { Head, Link, usePage, router } from '@inertiajs/vue3';
import dayjs from 'dayjs';
import { ref, computed, watch } from 'vue';

const { facilities } = defineProps({
  facilities: {
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

let facilitiesUrl = computed(() => {
  let url = new URL(route('facilities.index'));
  url.searchParams.append('page', pageNumber.value);
  if (search.value) {
    url.searchParams.append('search', search.value);
  }

  return url;
});

watch(() => facilitiesUrl.value, (newUrl) => {
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
  router.visit("/facilities?page=" + pageNumber.value, {
    preserveScroll: true,
  });
}

const deleteFacility = (id) => {
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
        axios.delete(route('facilities.destroy', id), { data: {} })
          .then(response => {
            Swal.fire({
              icon: 'success',
              title: 'Facility deleted successfully',
              toast: true,
              position: 'top-end',
              showConfirmButton: false,
              timer: 1000,
              timerProgressBar: true,
            });
            //redirect to the permissions index page
            setTimeout(() => {
              router.visit(route('facilities.index'), {
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

const downLoadOperator = async () => {
  try {
    const response = await axios.get('/api/facilities/downloadFacilities', {
      responseType: 'blob'
    });
    const url = window.URL.createObjectURL(new Blob([response.data]));
    const link = document.createElement('a');
    link.href = url;
    link.setAttribute('download', 'operators.pdf');
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);

  } catch (error) {
    console.log(error);
    Swal.fire({
      icon: "error",
      title: "PDF Generation Failed",
      text: 'Something went wrong while generating the PDF file.',
      toast: true,
      position: "top-end",
      showConfirmButton: false,
      timer: 1000,
      timerProgressBar: true,
    });
  }
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

const sortedFacilities = computed(() => {
  let sorted = [...facilities.data];
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

  <Head title="Operators" />
  <AuthenticatedLayout>
    <div class="content-wrapper">
      <div class="content-header">
        <div class="container-fluid">
          <div class="row mb-2">
            <div class="col-sm-6">
              <h3 class="m-0"><strong>Aviation Operators</strong></h3>
            </div><!-- /.col -->
            <div class="col-sm-6">
              <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item">
                  <Link class="btn btn-info" :href="route('facilities.create')"><i class="fas fa-plus"></i> Create
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
                            placeholder="Search for operator here.." v-model="search">
                          <div class="input-group-append">
                            <button type="submit" class="btn btn-lg btn-default">
                              <i class="fa fa-search"></i>
                            </button>
                          </div>
                        </div>
                      </div>
                    </div>
                    <div class="col-md-9">
                      <div class="d-flex justify-content-end">
                        <button @click="downLoadOperator" class="btn btn-sm btn-primary">
                          <i class="fas fa-file-pdf"></i> Export to PDF
                        </button>
                      </div>
                    </div>
                  </div>
                  <div class="table-responsive">
                    <table v-if="facilities.data.length > 0" id="example2"
                      class="table table-sm table-bordered table-hover table-striped">
                      <thead>
                        <tr>
                          <th @click="sortTable('id')" style="cursor: pointer">#</th>
                          <th @click="sortTable('name')" style="cursor: pointer">
                            Operator
                            <i v-if="sortKey === 'name'"
                              :class="sortDirection === 'asc' ? 'fas fa-sort-up' : 'fas fa-sort-down'"></i>
                          </th>
                          <th @click="sortTable('category')" style="cursor: pointer">
                            Category
                            <i v-if="sortKey === 'category'"
                              :class="sortDirection === 'asc' ? 'fas fa-sort-up' : 'fas fa-sort-down'"></i>
                          </th>
                          <th @click="sortTable('email')" style="cursor: pointer">
                            Email
                            <i v-if="sortKey === 'email'"
                              :class="sortDirection === 'asc' ? 'fas fa-sort-up' : 'fas fa-sort-down'"></i>
                          </th>
                          <th @click="sortTable('contact_number')" style="cursor: pointer">
                            Contact
                            <i v-if="sortKey === 'contact_number'"
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
                        <tr v-for="(facility, index) in sortedFacilities" :key="facility.id"
                          :class="{ 'table table-selected': selectedRowId === facility.id }"
                          @click="selectRow(facility.id)">
                          <td>{{ (facilities.current_page - 1) * facilities.per_page + index + 1 }}</td>
                          <td>
                            <Link :href="route('facilities.edit', facility.id)">
                            {{ facility.name }}
                            </Link>
                          </td>

                          <td>{{ facility.category }}</td>

                          <td>
                            {{ facility.email }}
                          </td>
                          <td>
                            {{ facility.contact_number }}
                          </td>

                          <td>{{ dayjs(facility.created_at).format('DD-MM-YYYY') }}</td>

                          <td>
                            <div class="d-flex justify-content-center">
                              <Link class="btn btn-success btn-sm mr-2" :href="route('facilities.show', facility.id)">
                              <i class="fas fa-clipboard-list"></i><span> Details</span>
                              </Link>
                              <Link class="btn btn-info btn-sm mr-2" :href="route('facilities.edit', facility.id)">
                              <i class="fas fa-edit"></i> <span>Edit</span>
                              </Link>
                              <button class="btn btn-danger btn-sm" @click="deleteFacility(facility.id)">
                                <i class="fas fa-trash"></i> <span>Del</span>
                              </button>
                            </div>
                          </td>
                        </tr>

                      </tbody>
                    </table>
                  </div>

                  <div v-if="facilities.data.length > 0" class="card mt-3">
                    <Pagination :data="facilities" :updatePageNumber="updatePageNumber" />
                  </div>
                  <div v-else class="card mt-3">
                    <h3>No Operator found</h3>
                    <p>Please create a Operator to get started.</p>
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
</style>

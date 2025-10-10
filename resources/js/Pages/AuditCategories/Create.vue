<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import { Head, Link, useForm } from '@inertiajs/vue3';
import InputError from '@/Components/InputError.vue';

import Swal from 'sweetalert2';
import VueSweetalert2 from 'vue-sweetalert2';
import 'sweetalert2/dist/sweetalert2.min.css';
import { ref, watch } from 'vue';

const form = useForm({
  name: "",
  category_name: ""
});

const props = defineProps({
  categories: {
    type: Array,
    required: true
  }
});

const formErrors = ref({
  name: '',
  category_name: '',
});

watch(() => form.name, (value) => {
  if (!value.trim()) {
    formErrors.value.name = 'Name is required.';
  } else if (value.trim().length < 3) {
    formErrors.value.name = 'Name must be at least 3 characters.';
  } else {
    formErrors.value.name = '';
  }
});


const isLoading = ref(false);
//Create the user permission
// and redirect to the permissions index page


function createAuditAreaCategory() {
  isLoading.value = true;
  axios.post(route('audit-categories.store'), {
    name: form.name, // assuming you're using reactive `form` or `ref()`
    category_name: form.category_name,
  })
    .then(response => {
      Swal.fire({
        icon: "success",
        title: "Audit Category created successfully",
        toast: true,
        position: "top-end",
        showConfirmButton: false,
        timer: 1000,
        timerProgressBar: true,
      });
      //redirect to the permissions index page
      setTimeout(() => {
        window.location.href = route('audit-categories.index');
      }, 1000);
    })
    .catch(error => {
      let message = "Something went wrong.";
      if (error.response && error.response.status === 422) {
        const errors = error.response.data.errors;
        message = Object.values(errors).flat().join("\n");
      }
      Swal.fire({
        icon: "error",
        title: "Validation failed",
        text: message,
        toast: true,
        position: "top-end",
        showConfirmButton: false,
        timer: 4000,
        timerProgressBar: true,
      });

    }).finally(() => {
      isLoading.value = false;
    });
}


</script>

<template>

  <Head title="Audit Area-Create" />

  <AuthenticatedLayout>
    <div class="content-wrapper">
      <div class="content-header">
        <div class="container-fluid">
          <div class="row mb-2">
            <div class="col-sm-6">
              <h3 class="m-0"><strong>Audit Area / Create</strong></h3>
            </div>
            <div class="col-sm-6">
              <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item">
                  <Link class="btn btn-info" :href="route('audit-categories.index')"><i class="fas fa-arrow-left"></i>
                  Back</Link>
                </li>
              </ol>
            </div>
          </div>
        </div>
      </div>

      <!-- Main content -->
      <div class="content">
        <div class="container-fluid">
          <div class="d-flex justify-content-center align-items-center min-vh-60  bg-light">
            <div class="row w-100 justify-content-center">
              <div class="col-md-6">
                <!-- general form elements -->
                <div class="card card-info">
                  <div class="card-header">
                    <h3 class="card-title">Create Audit Area</h3>
                  </div>

                  <!-- form start -->
                  <form @submit.prevent="createAuditAreaCategory">
                    <div class="card-body">
                      <div class="form-group">
                        <label for="name">Name</label>
                        <input v-model="form.name" type="name" class="form-control" id="name" :class="{
                          'is-invalid': formErrors.name,
                          'is-valid': form.name && !formErrors.name
                        }" required max="255" placeholder="Enter Name">
                        <InputError :message="formErrors.name || form.errors.name" class="mt-2" />
                        <div v-if="form.name && !formErrors.name" class="valid-feedback d-block">
                          Name looks good!
                        </div>
                      </div>

                      <div class="form-group">
                        <label>Target Area</label>
                        <select required v-model="form.category_name" class="form-control"
                          :class="{ 'is-invalid': formErrors.category_name, 'is-valid': form.category_name && !formErrors.category_name }">
                          <option value="">-- Select Target Area --</option>
                          <option v-for="option in props.categories" :key="option" :value="option">{{ option }}</option>
                        </select>
                        <InputError :message="formErrors.category_name" class="mt-1" />
                        <div v-if="form.category_name && !formErrors.category_name" class="valid-feedback d-block">
                          Target area looks good!
                        </div>
                      </div>
                    </div>
                    <!-- /.card-body -->

                    <div class="card-footer">
                      <div class="d-flex ">
                        <button :disabled="isLoading" :class="{ 'opacity-25': isLoading }" type="submit"
                          class="btn btn-info ml-auto mr-2">
                          <span v-if="isLoading">
                            <i class="fas fa-spinner fa-spin"></i> Processing...
                          </span>
                          <span v-else>
                            <i class="fas fa-save"></i> Submit
                          </span>
                        </button>

                        <Link :href="route('audit-categories.index')" class="btn btn-default float-right">
                        <i class="fas fa-window-close"> </i>Cancel
                        </Link>
                      </div>
                    </div>
                  </form>
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
</style>
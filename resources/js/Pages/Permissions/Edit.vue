
<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import { Head,Link, useForm, usePage } from '@inertiajs/vue3';
import InputError from '@/Components/InputError.vue';
import Swal from 'sweetalert2';
import VueSweetalert2 from 'vue-sweetalert2';
import 'sweetalert2/dist/sweetalert2.min.css';
import { ref,watch } from 'vue';
import { router } from '@inertiajs/vue3';


const props = defineProps({
    permission:{
        type: Object,
        required: true
    }
})
const form = useForm({
    name: props.permission.name
});
const formErrors = ref({
  name: '',
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


const  updatePermission = () => {
    isLoading.value = true;
    axios.post(route('permissions.update', props.permission.id), {
        name: form.name, // assuming you're using reactive `form` or `ref()`
        
    })
    .then(response => {
        Swal.fire({
            icon: "success",
            title: "Permission updated successfully",
            toast: true,
            position: "top-end",
            showConfirmButton: false,
            timer: 1000,
            timerProgressBar: true,
        });
                
        //redirect to the permissions index page
        setTimeout(() => {
            router.visit(route('permissions.index'), {
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
    <Head title="Permissions-Edit" />

    <AuthenticatedLayout>
        <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h3 class="m-0">Permissions/Edit</h3>
          </div><!-- /.col -->
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item"><Link class="btn btn-info" :href="route('permissions.index')"><i class="fas fa-arrow-left"></i> Back</Link></li>
            </ol>
          </div><!-- /.col -->
        </div><!-- /.row -->
      </div><!-- /.container-fluid -->
    </div>
    <!-- /.content-header -->

    <!-- Main content -->
    <div class="content">
      <div class="container-fluid">
        <div class="d-flex justify-content-center align-items-center min-vh-60  bg-light">
            <div class="row w-100 justify-content-center">
                <div class="col-md-6">                    
                    <!-- general form elements -->
                    <div class="card card-info">
                        <div class="card-header">
                            <h3 class="card-title">Edit Permission</h3>
                        </div>

                        <!-- form start -->
                        <form @submit.prevent="updatePermission">
                            <div class="card-body">
                                <div class="form-group">
                                    <label for="name">Name</label>
                                    <input  
                                        v-model="form.name"
                                        type="name" 
                                        autofocus
                                        class="form-control" id="name" 
                                        :class="{
                                            'is-invalid': formErrors.name,
                                            'is-valid': form.name && !formErrors.name
                                        }"
                                        required max="255" 
                                        placeholder="Enter Name">
                                        <InputError :message="formErrors.name || form.errors.name" class="mt-2" />
                                        <div v-if="form.name && !formErrors.name" class="valid-feedback d-block">
                                            Name looks good!
                                        </div>
                                </div>
                            </div>
                            <!-- /.card-body -->                            

                            <div class="card-footer">
                                <div class="d-flex ">                                
                                    <button :disabled="isLoading"
                                        :class="{ 'opacity-25': isLoading }"
                                        type="submit"
                                        class="btn btn-info ml-auto mr-2"
                                    >
                                        <span v-if="isLoading">
                                            <i class="fas fa-spinner fa-spin"></i> Processing...
                                        </span>
                                        <span v-else>
                                            <i class="fas fa-save"></i> Save
                                        </span>
                                    </button> 

                                    <Link :href="route('permissions.index')" class="btn btn-default float-right">
                                        <i class="fas fa-window-close"> </i>Cancel
                                    </Link>                
                                </div>                                                                
                            </div>
                        </form>
                    </div>
                </div>
            </div>
    </div>

        <!-- /.row -->
      </div><!-- /.container-fluid -->
    </div>
    <!-- /.content -->
  </div>  
    </AuthenticatedLayout>
</template>
<style>
.content-wrapper {
  font-family: 'Poppins', 'Segoe UI', sans-serif;
}
</style>
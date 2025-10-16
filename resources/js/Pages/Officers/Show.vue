<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import { Head, Link, useForm, router, usePage } from '@inertiajs/vue3';
import { ref, watch, computed, onMounted } from 'vue';
import Swal from 'sweetalert2';
import 'sweetalert2/dist/sweetalert2.min.css';
import InputError from '@/Components/InputError.vue';
import dayjs from 'dayjs';

const { personnel, qualifications, certifications, mandatorycourse, specialisedtraining } = defineProps({
    personnel: {
        type: Object,
        required: true
    },
    qualifications: {
        type: Array,
        required: true
    },
    certifications: {
        type: Array,
        required: true
    },

    mandatorycourse: {
        type: Array,
        required: true,
        default: () => []
    },

    specialisedtraining: {
        type: Array,
        required: true,
        default: () => []
    },
});


const page = usePage();
const selectedRowId = ref(null);

const selectRow = (id) => {
    selectedRowId.value = id;
};

const selectedRowId2 = ref(null);

const selectRow2 = (id) => {
    selectedRowId2.value = id;
};

const isDownloading = ref(false);
const isLoading = ref(false);
const formErrors = ref({});

const controlTypes = ['Certifications', 'Qualifications', 'Mandatory Course', 'Specialised Course']
//const activeTab = ref('Qualifications');

// Parse the URL query
const urlParams = new URLSearchParams(window.location.search);
const activeTab = ref(urlParams.get('tab') || 'Qualifications');

const paginatedControls = computed(() => {
    switch (activeTab.value) {
        case 'Certifications': return certifications;
        case 'Qualifications': return qualifications;
        case 'Mandatory Course': return mandatorycourse;
        case 'Specialised Course': return specialisedtraining;
        default: return [];
    }
});

const goToPage = (url) => {
    if (!url) return;
    router.visit(url, { preserveScroll: true, preserveState: true });
};

const deleteQualification = (id) => {
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
                axios.delete(route('qualifications.destroy', id), { data: {} })
                    .then(response => {
                        Swal.fire({
                            icon: 'success',
                            title: 'Qualification record deleted successfully',
                            toast: true,
                            position: 'top-end',
                            showConfirmButton: false,
                            timer: 1000,
                            timerProgressBar: true,
                        });
                        //redirect to the permissions index page
                        setTimeout(() => {
                            router.visit(route('officers.show', personnel.id), {
                                preserveScroll: true,
                                replace: true,
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

const deleteCertificate = (id) => {
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
                axios.delete(route('certifications.destroy', id), { data: {} })
                    .then(response => {
                        Swal.fire({
                            icon: 'success',
                            title: 'Certification record deleted successfully',
                            toast: true,
                            position: 'top-end',
                            showConfirmButton: false,
                            timer: 1000,
                            timerProgressBar: true,
                        });
                        //redirect to the permissions index page
                        setTimeout(() => {
                            router.visit(route('officers.show', personnel.id), {
                                preserveScroll: true,
                                replace: true,
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

const deleteMandatoryCourse = (id) => {
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
                axios.delete(route('mandatorycourses.destroy', id), { data: {} })
                    .then(response => {
                        Swal.fire({
                            icon: 'success',
                            title: 'Mandatory course deleted successfully',
                            toast: true,
                            position: 'top-end',
                            showConfirmButton: false,
                            timer: 1000,
                            timerProgressBar: true,
                        });

                        // Refresh the officer details page after deletion
                        setTimeout(() => {
                            router.visit(route('officers.show', personnel.id), {
                                preserveScroll: true,
                                replace: true,
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
};

const deleteSpecialisedTraining = (id) => {
    Swal.fire({
        title: 'Are you sure?',
        text: 'This will permanently delete the specialised training record.',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Yes, delete it!'
    }).then((result) => {
        if (result.isConfirmed) {
            axios.delete(route('specialisedtrainings.destroy', id))
                .then(() => {
                    Swal.fire({
                        icon: 'success',
                        title: 'Deleted!',
                        text: 'The specialised training has been removed.',
                        toast: true,
                        position: 'top-end',
                        showConfirmButton: false,
                        timer: 1500
                    });

                    // Refresh the page or re-fetch data
                    setTimeout(() => {
                        router.visit(route('officers.show', personnel.id), { replace: true });
                    }, 1200);
                })
                .catch((error) => {
                    console.error(error);
                    Swal.fire({
                        icon: 'error',
                        title: 'Error!',
                        text: 'Failed to delete specialised training. Please try again.'
                    });
                });
        }
    });
}

const downloadPDF = async () => {
    try {
        isDownloading.value = true;
        const response = await axios.get(`/officers/${personnel.id}/download`, {
            responseType: 'blob',
        });
        const url = window.URL.createObjectURL(new Blob([response.data]));
        const link = document.createElement('a');
        link.href = url;
        link.setAttribute('download', `staff_${personnel.name}.pdf`);
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
    } catch (error) {
        console.error(error);
        Swal.fire('Error', 'PDF generation failed', 'error');
    } finally {
        isDownloading.value = false;
    }
};


</script>

<template>

    <Head title="Officers Details" />
    <AuthenticatedLayout>
        <div class="content-wrapper">
            <div class="content-header">
                <div class="container-fluid">
                    <div class="row mb-2">
                        <div class="col-sm-6">
                            <h3 class="m-0"><strong>Avsec Officers Details</strong></h3>
                        </div>
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item">
                                    <Link class="btn btn-info" data-bs-toggle="tooltip" title="Edit"
                                        :href="route('officers.edit', personnel.id)"><i class="fas fa-edit"></i> Edit
                                    </Link>
                                </li>
                                <li class="breadcrumb-item">
                                    <Link class="btn btn-info" data-bs-toggle="tooltip" title="Back to Personnels"
                                        :href="route('officers.index')"><i class="fas fa-arrow-left"></i> Back</Link>
                                </li>
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
                                        <div class="text-center">
                                            <img class="profile-user-img img-fluid img-circle"
                                                style="width: 120px; height: 120px; border-radius: 50%; object-fit: cover; border: 2px solid #ccc;"
                                                :src="personnel.portrait ?
                                                    `/storage/${personnel.portrait}`
                                                    : '/storage/portraits/avatar.png'" alt="User profile picture">
                                        </div>
                                        <h3 class="profile-username text-center">{{ personnel.name }}</h3>
                                        <hr>
                                        <p class="text-muted text-center">Category: {{ personnel.user_type }}</p>
                                        <p class="text-muted text-center">Status: {{ personnel.is_certified }}</p>
                                        <p class="text-muted text-center">Gender: {{ personnel.gender }}</p>
                                        <p class="text-muted text-center">NRC: {{ personnel.nrc }}</p>
                                        <p class="text-muted text-center">Operator:
                                            <Link :href="route('facilities.show', personnel.facility_id)">
                                            {{ personnel.facility_name }}</Link>
                                        </p>
                                        <p class="text-muted text-center">Email: {{ personnel.email }}</p>
                                        <p class="text-muted text-center">Contact: {{ personnel.phone_number }}</p>
                                        <hr>
                                        <div class="d-flex justify-content-center mb-2">
                                            <button class="btn btn-info btn-sm ms-2" @click="downloadPDF"
                                                :disabled="isDownloading">
                                                <i class="fas fa-file-pdf" style="margin-right: 8px;"></i>
                                                <span class="ms-1">Export to PDF</span>
                                                <span v-if="isDownloading" class="spinner-border spinner-border-sm ms-2"
                                                    role="status"></span>
                                            </button>
                                        </div>

                                    </div>
                                </div>
                            </div>

                            <div class="col-md-9">
                                <div class="card card-info card-outline">
                                    <div class="card-header p-2">

                                        <ul class="nav nav-pills">
                                            <!-- <li class="nav-item">
                                                <a 
                                                    class="nav-link" 
                                                    :class="{ active: activeTab === 'Certifications' }" 
                                                    href="#certifications" 
                                                    @click.prevent="activeTab = 'Certifications'">
                                                    <i class="fas fa-shield-alt"></i> Certifications
                                                </a>
                                            </li> -->

                                            <li class="nav-item">
                                                <a class="nav-link" :class="{ active: activeTab === 'Qualifications' }"
                                                    href="#qualifications"
                                                    @click.prevent="activeTab = 'Qualifications'">
                                                    <i class="fas fa-user-graduate"></i> Qualifications
                                                </a>
                                            </li>

                                            <li class="nav-item">
                                                <a class="nav-link"
                                                    :class="{ active: activeTab === 'Mandatory Course' }"
                                                    href="#mandatorycourse"
                                                    @click.prevent="activeTab = 'Mandatory Course'">
                                                    <i class="fas fa-exclamation-circle"></i> Mandatory Course
                                                </a>
                                            </li>

                                            <li class="nav-item">
                                                <a class="nav-link"
                                                    :class="{ active: activeTab === 'Specialised Course' }"
                                                    href="#specialisedtraining"
                                                    @click.prevent="activeTab = 'Specialised Course'">
                                                    <i class="fas fa-book-open"></i> Specialised Training
                                                </a>
                                            </li>
                                        </ul>

                                    </div>
                                    <div class="card-body">
                                        <div class="tab-content">

                                            <!-- certification here -->
                                            <!-- <div class="tab-pane" :class="{ active: activeTab === 'Certifications' }" id="certifications">
                                              
                                                <div class="d-flex justify-content-end mb-2">
                                                    <Link :href="route('certifications.create', personnel.id)"
                                                        data-bs-toggle="tooltip" data-bs-placement="top"
                                                        title="Add Certification" class="btn btn-info btn-sm "><i
                                                        class="fas fa-plus"></i> Add New</Link>
                                                </div>

                                                <div class="table-responsive">
                                                    <table v-if="certifications.length > 0" id="example2"
                                                        class="table table-sm table-bordered table-hover table-striped">
                                                        <thead>
                                                            <tr>
                                                                <th>#</th>
                                                                <th>Name</th>
                                                                <th>Issuer</th>
                                                                <th>Number</th>
                                                                <th>D/Issue</th>
                                                                <th>E/Date</th>
                                                                <th>Status</th>
                                                                <th>Score</th>
                                                                <th>Actions</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <tr v-for="(certificate, index) in certifications"
                                                                :key="certificate.id"
                                                                :class="{ 'table table-selected': selectedRowId === certificate.id }"
                                                                @click="selectRow(certificate.id)">
                                                                <td>{{ index + 1 }}</td>
                                                                <td>
                                                                    {{ certificate.certification_name }}
                                                                </td>
                                                                <td>{{ certificate.certification_body }}</td>
                                                                <td>
                                                                    {{ certificate.certification_number }}
                                                                </td>
                                                                <td>
                                                                    {{ certificate.date_issued ?
                                                                        dayjs(certificate.date_issued).format('DD-MM-YYYY')
                                                                        :
                                                                        'N/A' }}
                                                                </td>
                                                                <td>
                                                                    {{ certificate.expiry_date ?
                                                                        dayjs(certificate.expiry_date).format('DD-MM-YYYY')
                                                                        :
                                                                        'N/A' }}
                                                                </td>
                                                                <td class="text-center">
                                                                    <span class="badge p-2"
                                                                        :class="certificate.status === 'Active' ? 'bg-success' : 'bg-danger'">
                                                                        {{ certificate.status }}
                                                                    </span>
                                                                </td>
                                                                <td>{{ certificate.score }}%</td>

                                                                <td>
                                                                    <div class="d-flex justify-content-end">
                                                                        <a v-if="certificate.certification_file"
                                                                            class="btn btn-success btn-sm mr-2"
                                                                            data-bs-toggle="tooltip"
                                                                            title="View Attachment"
                                                                            :href="`/storage/${certificate.certification_file}`"
                                                                            target="_blank">
                                                                            <i
                                                                                class="fas fa-paperclip"></i><span></span>
                                                                        </a>
                                                                        <Link class="btn btn-info btn-sm mr-2"
                                                                            data-bs-toggle="tooltip" title="Edit"
                                                                            :href="route('certifications.edit', certificate.id)">
                                                                        <i class="fas fa-edit"></i> <span></span>
                                                                        </Link>
                                                                        <button class="btn btn-danger btn-sm"
                                                                            data-bs-toggle="tooltip" title="Delete"
                                                                            @click="deleteCertificate(certificate.id)">
                                                                            <i class="fas fa-trash"></i> <span></span>
                                                                        </button>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                    <div v-else class="text-center mt-4">
                                                        <h5>No Certification found for this personnel</h5>
                                                    </div>
                                                </div>

                                            </div> -->

                                            <!-- qualifications here -->
                                            <div class="tab-pane" :class="{ active: activeTab === 'Qualifications' }"
                                                id="qualifications">
                                                <div class="d-flex justify-content-end mb-2">
                                                    <Link :href="route('qualifications.create', personnel.id)"
                                                        class="btn btn-info btn-sm "><i class="fas fa-plus"></i> Add New
                                                    </Link>
                                                </div>

                                                <div class="table-responsive">
                                                    <table v-if="qualifications.length > 0" id="example2"
                                                        class="table table-sm table-bordered table-hover table-striped">
                                                        <thead>
                                                            <tr>
                                                                <th>#</th>
                                                                <th>Name</th>
                                                                <th>Operator</th>
                                                                <th>Number</th>
                                                                <th>Type</th>
                                                                <th>D/Issue</th>
                                                                <th>Actions</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <tr v-for="(qualification, index) in qualifications"
                                                                :key="qualification.id"
                                                                :class="{ 'table table-selected': selectedRowId2 === qualification.id }"
                                                                @click="selectRow2(qualification.id)">
                                                                <td>{{ index + 1 }}</td>
                                                                <td>
                                                                    {{ qualification.qualification_name }}
                                                                </td>
                                                                <td>{{ qualification.institution }}</td>
                                                                <td>{{ qualification.qualification_number }}</td>
                                                                <td>
                                                                    {{ qualification.qualification_type }}
                                                                </td>
                                                                <td>
                                                                    {{ qualification.date_obtained ?
                                                                        dayjs(qualification.date_obtained).format('DD-MM-YYYY')
                                                                        : 'N/A' }}
                                                                </td>


                                                                <td>
                                                                    <div class="d-flex justify-content-end">
                                                                        <a v-if="qualification.qualification_file"
                                                                            class="btn btn-success btn-sm mr-2"
                                                                            data-bs-toggle="tooltip"
                                                                            title="View Attachment"
                                                                            :href="`/storage/${qualification.qualification_file}`"
                                                                            target="_blank">
                                                                            <i class="fas fa-paperclip"></i>
                                                                            <span></span>
                                                                        </a>
                                                                        <Link class="btn btn-info btn-sm mr-2"
                                                                            data-bs-toggle="tooltip" title="Edit"
                                                                            :href="route('qualifications.edit', qualification.id)">
                                                                        <i class="fas fa-edit"></i> <span></span>
                                                                        </Link>
                                                                        <button class="btn btn-danger btn-sm"
                                                                            data-bs-toggle="tooltip" title="Delete"
                                                                            @click="deleteQualification(qualification.id)">
                                                                            <i class="fas fa-trash"></i> <span></span>
                                                                        </button>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                    <div v-else class="text-center mt-4">
                                                        <h5>No qualifications found for this personnel</h5>
                                                    </div>
                                                </div>

                                            </div>

                                            <!-- mandatory course here -->
                                            <div class="tab-pane" :class="{ active: activeTab === 'Mandatory Course' }"
                                                id="mandatorycourse">
                                                <div class="d-flex justify-content-end mb-2">
                                                    <Link :href="route('mandatorycourses.create', personnel.id)"
                                                        class="btn btn-info btn-sm">
                                                    <i class="fas fa-plus"></i> Add New
                                                    </Link>
                                                </div>

                                                <div class="table-responsive">
                                                    <!-- Safe check for undefined or empty array -->
                                                    <table v-if="mandatorycourse && mandatorycourse.length > 0"
                                                        class="table table-sm table-bordered table-hover table-striped">
                                                        <thead>
                                                            <tr>
                                                                <th>#</th>
                                                                <th>Course Name</th>
                                                                <th>Training Center</th>
                                                                <th>Certificate No</th>
                                                                <th>Date Issued</th>
                                                                <th>Expiry Date</th>
                                                                <th>Status</th>
                                                                <th>Actions</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <tr v-for="(course, index) in mandatorycourse"
                                                                :key="course.id">
                                                                <td>{{ index + 1 }}</td>
                                                                <td>{{ course.course_name }}</td>
                                                                <td>{{ course.training_center }}</td>
                                                                <td>{{ course.certificate_number }}</td>
                                                                <td>
                                                                    {{ course.date_issued
                                                                        ? dayjs(course.date_issued).format('DD-MM-YYYY')
                                                                        : 'N/A' }}
                                                                </td>
                                                                <td>
                                                                    {{ course.expiry_date
                                                                        ? dayjs(course.expiry_date).format('DD-MM-YYYY')
                                                                        : 'N/A' }}
                                                                </td>
                                                                <td>{{ course.status }}</td>
                                                                <td>
                                                                <td>
                                                                    <div class="d-flex justify-content-end">
                                                                        <!-- View Attachment -->
                                                                        <a v-if="course.attachment"
                                                                            :href="`/storage/${course.attachment}`"
                                                                            target="_blank"
                                                                            class="btn btn-success btn-sm mr-2"
                                                                            data-bs-toggle="tooltip"
                                                                            title="View Attachment">
                                                                            <i class="fas fa-paperclip"></i>
                                                                        </a>

                                                                        <!-- Edit Button -->
                                                                        <Link class="btn btn-info btn-sm mr-2"
                                                                            data-bs-toggle="tooltip" title="Edit"
                                                                            :href="route('mandatorycourses.edit', course.id)">
                                                                        <i class="fas fa-edit"></i> <span></span>
                                                                        </Link>
                                                                        <!-- <Link class="btn btn-info btn-sm mr-2"
                                                                            data-bs-toggle="tooltip"
                                                                            title="Edit"
                                                                            :href="route('mandatorycourses.edit', course.id)">
                                                                            <i class="fas fa-edit"></i>
                                                                        </Link> -->

                                                                        <!-- Delete Button -->
                                                                        <button class="btn btn-danger btn-sm"
                                                                            data-bs-toggle="tooltip" title="Delete"
                                                                            @click="deleteMandatoryCourse(course.id)">
                                                                            <i class="fas fa-trash"></i>
                                                                        </button>
                                                                    </div>
                                                                </td>

                                                                <!-- <div class="d-flex justify-content-end">
                                                                         <a v-if="course.attachment"
                                                                        :href="`/storage/${course.attachment}`"
                                                                        target="_blank"
                                                                        class="btn btn-success btn-sm mr-2">
                                                                        <i class="fas fa-paperclip"></i>
                                                                    </a>
                                                                    </div> -->
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>

                                                    <!-- Safe fallback when no courses are found -->
                                                    <div v-else class="text-center mt-4">
                                                        <h5>No mandatory courses found</h5>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- specialised training -->
                                            <div class="tab-pane"
                                                :class="{ active: activeTab === 'Specialised Course' }"
                                                id="specialisedtraining">
                                                <div class="d-flex justify-content-end mb-2">
                                                    <Link :href="route('specialisedtrainings.create', personnel.id)"
                                                        class="btn btn-info btn-sm">
                                                    <i class="fas fa-plus"></i> Add New
                                                    </Link>
                                                </div>

                                                <div class="table-responsive">
                                                    <!-- Safe check for undefined or empty array -->
                                                    <table v-if="specialisedtraining && specialisedtraining.length > 0"
                                                        class="table table-sm table-bordered table-hover table-striped">
                                                        <thead>
                                                            <tr>
                                                                <th>#</th>
                                                                <th>Training Name</th>
                                                                <th>Training Center</th>
                                                                <th>Certificate No</th>
                                                                <th>Date Issued</th>
                                                                <th>Expiry Date</th>
                                                                <th>Status</th>
                                                                <th>Actions</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <tr v-for="(training, index) in specialisedtraining"
                                                                :key="training.id">
                                                                <td>{{ index + 1 }}</td>
                                                                <td>{{ training.training_name }}</td>
                                                                <td>{{ training.training_center }}</td>
                                                                <td>{{ training.certificate_number }}</td>
                                                                <td>
                                                                    {{ training.date_issued
                                                                        ? dayjs(training.date_issued).format('DD-MM-YYYY')
                                                                        : 'N/A' }}
                                                                </td>
                                                                <td>
                                                                    {{ training.expiry_date
                                                                        ? dayjs(training.expiry_date).format('DD-MM-YYYY')
                                                                        : 'N/A' }}
                                                                </td>
                                                                <td>{{ training.status }}</td>
                                                                <td>
                                                                    <div class="d-flex justify-content-end">
                                                                        <!-- View Attachment -->
                                                                        <a v-if="training.attachment"
                                                                            :href="`/storage/${training.attachment}`"
                                                                            target="_blank"
                                                                            class="btn btn-success btn-sm mr-2"
                                                                            data-bs-toggle="tooltip"
                                                                            title="View Attachment">
                                                                            <i class="fas fa-paperclip"></i>
                                                                        </a>
                                                                        <!-- Edit Button -->
                                                                        <Link class="btn btn-info btn-sm mr-2"
                                                                            data-bs-toggle="tooltip" title="Edit"
                                                                            :href="route('specialisedtrainings.edit', training.id)">
                                                                        <i class="fas fa-edit"></i> <span></span>
                                                                        </Link>

                                                                        <!-- Delete Button -->
                                                                        <button class="btn btn-danger btn-sm"
                                                                            data-bs-toggle="tooltip" title="Delete"
                                                                            @click="deleteSpecialisedTraining(training.id)">
                                                                            <i class="fas fa-trash"></i>
                                                                        </button>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>

                                                    <!-- Safe fallback when no trainings are found -->
                                                    <div v-else class="text-center mt-4">
                                                        <h5>No specialised training found</h5>
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

.table .table-selected {
    background-color: #4962df !important;
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
</style>
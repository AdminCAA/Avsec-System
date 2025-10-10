<template>        
  <!-- Main Sidebar Container -->
  <aside class="main-sidebar sidebar-dark-primary elevation-4">
      <!-- Brand Logo -->
      <a href="#" class="brand-link">
      <img :src="logoImage" alt="Civil Aviation Authority Logo" class="brand-image img-circle elevation-3" style="opacity: .8">
      <span class="brand-text font-weight-light">Civil Aviation Authority</span>
      </a>

      <!-- Sidebar -->
      <div class="sidebar">
      <!-- Sidebar user panel (optional) -->
      <div class="user-panel mt-3 pb-3 mb-3 d-flex">
          <div class="image">
          <img :src="avatar" class="img-circle elevation-2" alt="User Image">
          </div>
          <div class="info">
          <Link :href="route('profile.edit')" class="d-block">{{ currentUser.name }}</Link>
          </div>
      </div>

      

      <!-- Sidebar Menu -->
      <nav class="mt-2">
          <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
          <!-- Add icons to the links using the .nav-icon class
              with font-awesome or any other icon font library -->             
              <li v-if="hasRoles(['Administrator','Super Admin','AVSEC Administrator'])" class="nav-item">
                  <Link :href="route('dashboard')" 
                      class="nav-link"
                      :class="{ active: currentPath.startsWith('/dashboard') }"
                  >                      
                      <!-- <i class="nav-icon fas fa-chart-bar"></i> -->
                      <i class="nav-icon fas fa-tachometer-alt"></i>
                      <p>
                          Admin Dashboard                                                                
                      </p>
                  </Link>
              </li>
              <li v-else-if="hasRoles(['AVSEC Inspector'])" class="nav-item">
                  <Link :href="route('dashboard')" 
                      class="nav-link"
                      :class="{ active: currentPath.startsWith('/dashboard') }"
                  >                      
                      <!-- <i class="nav-icon fas fa-chart-bar"></i> -->
                      <i class="nav-icon fas fa-tachometer-alt"></i>
                      <p>
                          Inspector Dashboard                                                                
                      </p>
                  </Link>
              </li>

              <li v-else="hasRoles(['Guest User'])" class="nav-item">
                  <Link :href="route('dashboard')" 
                      class="nav-link"
                      :class="{ active: currentPath.startsWith('/dashboard') }"
                  >                      
                      <!-- <i class="nav-icon fas fa-chart-bar"></i> -->
                      <i class="nav-icon fas fa-tachometer-alt"></i>
                      <p>
                          Guest Dashboard                                                                
                      </p>
                  </Link>
              </li>

          
              <li v-if="hasRoles(['Administrator','Super Admin','AVSEC Administrator','AVSEC Inspector'])" class="nav-item">
                  <Link :href="route('facilities.index')" 
                    class="nav-link"
                    :class="{ active: currentPath.startsWith('/facilities') }">
                    <i class="nav-icon fas fa-shield-alt"></i>
                  <p>
                    AVSEC Operators                    
                  </p>
                  </Link>
              </li>

              <li v-if="hasRoles(['Administrator','Super Admin','AVSEC Administrator','AVSEC Inspector'])" class="nav-item">
                  <Link :href="route('quality-controls.index')" 
                    class="nav-link"
                    :class="{ active: currentPath.startsWith('/quality-controls') }">
                    <i class="nav-icon fas fa-project-diagram"></i>
                  <p>
                    AVSEC Quality Controls 
                  </p>
                  </Link>
              </li>
              
              <li v-if="hasRoles(['Administrator','Super Admin','AVSEC Administrator','AVSEC Inspector'])" class="nav-item">
                  <Link :href="route('securityconcerns.index')" 
                    class="nav-link"
                    :class="{ active: currentPath.startsWith('/securityconcerns') }">
                    <i class="nav-icon fas fa-bolt"></i>
                  <p>
                      Security Concerns                 
                      <span class="badge badge-danger navbar-badge">{{ securityConcernCounter }}</span>               
                  </p>
                </Link>
              </li>

              <li v-if="hasRoles(['Administrator','Super Admin','AVSEC Administrator','AVSEC Inspector'])" class="nav-item">
                  <Link :href="route('audit-questions.index')" class="nav-link"
                  :class="{ active: currentPath.startsWith('/audit-questions') }"
                  >
                    <i class="nav-icon fas fa-question-circle"></i>
                  <p>
                      Checklist Questions                                                    
                  </p>
                </Link>
              </li>

              <li v-if="hasRoles(['Administrator','Super Admin','AVSEC Administrator','AVSEC Inspector'])" class="nav-item">
                  <Link :href="route('audit-categories.index')" class="nav-link"
                  :class="{ active: currentPath.startsWith('/audit-categories') }"
                  >                  
                    <i class="nav-icon fas fa-server"></i>
                  <p>
                     Quality Control Areas
                  </p>
                </Link>
              </li>
             
              <li v-if="hasRoles(['Administrator','Super Admin','AVSEC Administrator','AVSEC Inspector'])" class="nav-item">
                <Link :href="route('security-equipments.index')" class="nav-link"
                  :class="{ active: currentPath.startsWith('/security-equipments') }"
                  >
                  <i class="nav-icon fas fa-microscope"></i>
                  <p>
                      AVSEC Equipments                      
                  </p>
                  </Link>
              </li>

              <li v-if="hasRoles(['Administrator','Super Admin','AVSEC Administrator','AVSEC Inspector'])" class="nav-item">
                  <a href="#" class="nav-link">
                  <i class="nav-icon fas fa-user-graduate"></i>
                  <p>
                      AVSEC Trainings
                      <i class="right fas fa-angle-left"></i>
                  </p>
                  </a>
                  <ul class="nav nav-treeview">
                    <li class="nav-item">
                      <Link :href="route('personnels.index')" class="nav-link"
                      :class="{ active: currentPath.startsWith('/personnels') }"
                      >
                          <i class="fas fa-chevron-circle-right nav-icon"></i>
                      <p>Training Records</p>
                      </Link>
                  </li>
                  <li class="nav-item">
                      <Link :href="route('trainings.index')" class="nav-link"
                      :class="{ active: currentPath.startsWith('/trainings') }"
                      >
                          <i class="fas fa-chevron-circle-right nav-icon"></i>
                      <p>Trainings</p>
                      </Link>
                  </li>                  
                  </ul>
              </li>

              <li v-if="hasRoles(['Administrator','Super Admin','AVSEC Administrator','AVSEC Inspector'])" class="nav-item">
                  <a href="#" class="nav-link">
                  <i class="nav-icon fas fa-user-graduate"></i>
                  <p>
                      Operator Certification
                      <i class="right fas fa-angle-left"></i>
                  </p>
                  </a>
                  <ul class="nav nav-treeview">
                    <li class="nav-item">
                      <Link :href="route('personnels.index')" class="nav-link"
                      :class="{ active: currentPath.startsWith('/personnels') }"
                      >
                          <i class="fas fa-chevron-circle-right nav-icon"></i>
                      <p>Personnel Records</p>
                      </Link>
                  </li>
                  <li class="nav-item">
                      <Link :href="route('trainings.index')" class="nav-link"
                      :class="{ active: currentPath.startsWith('/trainings') }"
                      >
                          <i class="fas fa-chevron-circle-right nav-icon"></i>
                      <p>Trainings</p>
                      </Link>
                  </li>                  
                  </ul>
              </li>
             
                                        
              <li v-if="hasRoles(['Administrator','Super Admin','AVSEC Administrator','AVSEC Inspector'])" class="nav-item">
                  <a href="#" class="nav-link">
                      <i class="nav-icon fas fa-toolbox"></i>
                  <p>
                      AVSEC Documents                  
                  </p>
                  </a>
              </li>
              
              <li v-if="hasRoles(['Administrator','Super Admin','AVSEC Administrator','AVSEC Inspector'])" class="nav-item">
                    <Link :href="route('departments.index')" class="nav-link"
                        :class="{ active: currentPath.startsWith('/departments') }">
                        <i class="nav-icon fas fa-warehouse"></i> <p>Target Departments</p>
                  </Link>
              </li>              


              <li v-if="hasRoles(['Administrator','Super Admin','AVSEC Administrator','AVSEC Inspector'])" class="nav-item">
                  <a href="#" class="nav-link">
                    <i class="nav-icon fas fa-chart-pie"></i> 
                  <p>Reports <i class="right fas fa-angle-left"></i>
                  </p>
                  </a>
                  <ul class="nav nav-treeview">
                    <li class="nav-item">
                      <Link :href="route('quality-control-reports.index')" class="nav-link"
                      :class="{ active: currentPath.startsWith('/quality-control-reports') }"
                      >
                          <i class="fas fa-chevron-circle-right nav-icon"></i>
                      <p>Quality Control Report</p>
                      </Link>
                  </li>
                  
                  </ul>
              </li>
              
              <li  v-if="hasRoles(['Administrator','Super Admin'])" class="nav-item">
                  <a href="#" class="nav-link">
                  <i class="nav-icon fas fa-users-cog"></i>
                  <p>
                      Admin Management
                      <i class="right fas fa-angle-left"></i>
                  </p>
                  </a>
                  <ul class="nav nav-treeview">
                    <li class="nav-item">
                      <Link :href="route('users.index')" class="nav-link"
                      :class="{ active: currentPath.startsWith('/users') }"
                      >
                          <i class="fas fa-chevron-circle-right nav-icon"></i>
                      <p>Users</p>
                      </Link>
                  </li>
                  <li class="nav-item">
                      <Link :href="route('roles.index')" class="nav-link"
                      :class="{ active: currentPath.startsWith('/roles') }"
                      >
                          <i class="fas fa-chevron-circle-right nav-icon"></i>
                      <p>User Roles</p>
                      </Link>
                  </li>

                  <li class="nav-item">
                      <Link :href="route('permissions.index')" class="nav-link"
                      :class="{ active: currentPath.startsWith('/permissions') }"
                      >
                          <i class="fas fa-chevron-circle-right nav-icon"></i>
                      <p>User Permissions</p>
                      </Link>
                  </li>
                  </ul>
              </li>
                
              <li class="nav-item">
                  <Link  :href="route('logout')" 
                        class="nav-link" as="button"
                      method="post"                             
                  >
                      <i class="nav-icon fas fa-power-off poweroff-color"></i>
                      <p>
                          Logout                
                      </p>
                  </Link>
              </li>
          </ul>
      </nav>
      <!-- /.sidebar-menu -->
      </div>
      <!-- /.sidebar -->
  </aside>
</template>
<script setup>
    import ApplicationLogo from '@/Components/ApplicationLogo.vue';
    import Dropdown from '@/Components/Dropdown.vue';
    import DropdownLink from '@/Components/DropdownLink.vue';
    import NavLink from '@/Components/NavLink.vue';
    import { ref ,computed,onMounted} from 'vue';
    import { Link } from '@inertiajs/vue3';
    import { usePage } from '@inertiajs/vue3';
    import { useRoute } from 'vue-router';
    import axios from 'axios';


defineProps({
    currentUser: {
        type: Object,
        required: true
    }
});
const page = usePage()
const roles = page.props.auth.user.roles;

console.log('User Roles:', roles);

// Function to check if the user has a specific role
const hasRoles = (roles) => {
    const userRoles = page.props.auth.user?.roles ?? []
    // If a single role is passed as a string, wrap it in an array
    const requiredRoles = Array.isArray(roles) ? roles : [roles]
    return requiredRoles.some(role => userRoles.includes(role))
}

const logoImage = '/assets/caa-logo.png';
const avatar = '/assets/avatar.png';

const currentPath = computed(() => window.location.pathname);
const securityConcernCounter = ref(0);
onMounted(() => {
    // You can add any additional logic here if needed
    axios.get('/securityconcerns/count')
        .then(response => {
            // Handle the response if needed            
            securityConcernCounter.value = response.data.count;
        })
        .catch(error => {
            console.error('Error fetching user data:', error);
        });
});

</script>


<style>

/* .main-sidebar {
    font-family: 'Poppins', 'Segoe UI', sans-serif;
} */

.main-sidebar {
    font-family: 'Inter', sans-serif;
}

.font-weight-light {
    font-weight: 300 !important;
}

.brand-link {
    display: block;
    font-size: 1.1rem;
    line-height: 1.5;
    padding: .8125rem .5rem;
    transition: width .3s ease-in-out;
    white-space: nowrap;
}

[class*=sidebar-dark-] .nav-treeview>.nav-item>.nav-link.active,
[class*=sidebar-dark-] .nav-treeview>.nav-item>.nav-link.active:focus,
[class*=sidebar-dark-] .nav-treeview>.nav-item>.nav-link.active:hover {
    background-color: #007B86;
    color: #fff;
}

.sidebar-dark-primary .nav-sidebar>.nav-item>.nav-link.active,
.sidebar-light-primary .nav-sidebar.nav-item>.nav-link.active {

    background-color: #007B86;
    color: #fff;
}

.poweroff-color {
    color: #e3342f;
}

.nav-pills .nav-link {
    border-radius: 0.5rem;

}

.nav-sidebar .nav-link p {
    display: inline;
    margin: 0;
    white-space: normal;
    font-size: 15px !important;
}

[ class*=sidebar-dark-] {
    background-color: #072f57 !important;
}
</style>
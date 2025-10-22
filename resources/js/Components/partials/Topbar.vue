<template>
<nav class="main-header navbar navbar-expand navbar-white navbar-light">
                <!-- Left navbar links -->
                <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>
                </li>
                
                </ul>

                <!-- Right navbar links -->
                <ul class="navbar-nav ml-auto">

               
                
                <li class="nav-item dropdown">
                    <a class="nav-link" data-toggle="dropdown" href="#">
                    <i class="far fa-bell"></i>
                    <Link :href="route('securityconcerns.index')"><span class="badge badge-warning navbar-badge">{{ securityConcernCounter }}</span>
                    </Link>
                    </a>
                    <div class="dropdown-menu dropdown-menu-lg dropdown-menu-right">
                    <span class="dropdown-header">15 Notifications</span>
                    <div class="dropdown-divider"></div>
                    <a href="#" class="dropdown-item">
                        <i class="fas fa-envelope mr-2"></i> 4 new messages
                        <span class="float-right text-muted text-sm">3 mins</span>
                    </a>
                    <div class="dropdown-divider"></div>
                    <a href="#" class="dropdown-item">
                        <i class="fas fa-users mr-2"></i> 8 friend requests
                        <span class="float-right text-muted text-sm">12 hours</span>
                    </a>
                    <div class="dropdown-divider"></div>
                    <a href="#" class="dropdown-item">
                        <i class="fas fa-file mr-2"></i> 3 new reports
                        <span class="float-right text-muted text-sm">2 days</span>
                    </a>
                    <div class="dropdown-divider"></div>
                    <a href="#" class="dropdown-item dropdown-footer">See All Notifications</a>
                    </div>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-widget="fullscreen" href="#" role="button">
                    <i class="fas fa-expand-arrows-alt"></i>
                    </a>
                </li>
                
                <li class="nav-item dropdown">
                    <a class="nav-link" data-toggle="dropdown" href="#">
                        <div class="user-panel  d-flex">       
                            <img :src="user.portrait ?`/storage/${user.portrait}`
                                                    : '/storage/portraits/avatar.png'" class="img-circle elevation-2" alt="User Image">         
                            <div class="info">
                                <span  class="d-block">{{ user.name }}</span>
                            </div>
                        </div>                    
                    </a>
                    <div class="dropdown-menu dropdown-menu-lg dropdown-menu-right">
                    <a href="#" class="dropdown-item">                        
                        <div class="media">                        
                        <div class="media-body">
                            <Link
                                :href="route('profile.edit')"
                                class="dropdown-item d-flex align-items-center"
                                >
                                <i class="fas fa-user me-2 text-primary"></i>
                                <span class="fw-semibold ml-2">Profile</span>
                            </Link>                        
                        </div>
                        </div>                        
                    </a>
                    <div class="dropdown-divider"></div>
                    <a href="#" class="dropdown-item">
                        
                        <div class="media">
                        
                        <div class="media-body">
                        <Link
                            :href="route('logout')"
                            method="post"
                            as="button"
                            class="dropdown-item d-flex align-items-center text-danger"
                            >
                        <i class="fas fa-power-off me-1 poweroff-color"></i>
                        <span class="fw-semibold ml-2">Logout</span>
                        </Link>  
                        </div>
                        </div>                        
                    </a>                                                            
                    </div>
                </li>

                

                </ul>
            </nav>

</template>
<script setup>
import { ref } from 'vue';
import { usePage,Link } from '@inertiajs/vue3';
import { useRoute } from 'vue-router';
import axios from 'axios';
import { onMounted} from 'vue';

    const page = usePage()
    const user = page.props.auth.user;    
    const logoImage = '/assets/caa-logo.png';
    const avatar = '/assets/avatar.png';

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
<style scoped>
    .dropdown-menu-lg {
        max-width: 300px;
        min-width: 160px !important;
        padding: 0;
    }
    .dropdown-menu-lg .dropdown-item {
        padding: .3rem 1rem !important;
    }
</style>
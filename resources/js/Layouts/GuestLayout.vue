<script setup>
import ApplicationLogo from '@/Components/ApplicationLogo.vue';
import { Link } from '@inertiajs/vue3';

const logoImage = '/assets/caa-logo.png';
</script>

<template>
    <div class="wrapper">
        <!-- Navbar -->
        <nav class="main-header navbar navbar-expand-md navbar-light navbar-white">
        <div class="container">
            <Link :href="route('welcome')" class="navbar-brand">
            <img :src="logoImage"width="60px" alt="Zambia Civil Aviation Authority" class="brand-image img-circle elevation-3" style="opacity: .8">
            <span class="brand-text font-weight-light">Zambia Civil Aviation Authority</span>
            </Link>

            <button class="navbar-toggler order-1" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
            </button>

            
            
        </div>
        </nav>
        <!-- /.navbar -->
        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">

        <!-- /.content-header -->

        <!-- Main content -->
        <div class="content">
            <div class="container">
                <div class="row">
                    <div class="col-lg-3">
                                    
                    </div>
                    <div class="col-lg-6">
                        <slot />                
                    </div>

                    <div class="col-lg-3">
                                    
                    </div>
                    <!-- /.col-md-6 -->
                </div>
            <!-- /.row -->
            </div><!-- /.container-fluid -->
        </div>
        <!-- /.content -->
        </div>
    </div>
</template>
<style scoped>


    .main-header {
        transition: margin-left .3s ease-in-out;
        margin-left: 0px !important;
    }   

    .font-weight-light {
        font-size: 20px;
        font-weight: bold !important;
        /* font-weight: 300 !important; */
        margin-left: 10px;
}
    
    @media (min-width: 768px) {
    body:not(.sidebar-mini-md):not(.sidebar-mini-xs):not(.layout-top-nav) .content-wrapper, body:not(.sidebar-mini-md):not(.sidebar-mini-xs):not(.layout-top-nav) .main-footer, body:not(.sidebar-mini-md):not(.sidebar-mini-xs):not(.layout-top-nav) .main-header {
        transition: margin-left .3s ease-in-out;
        margin-left: 0px !important;
        font-family: 'Poppins', 'Segoe UI', sans-serif;
    }}


    .login-box, .register-box {
        width: auto !important;
    }
</style>


<script setup>
    import { ref ,computed} from 'vue';
    import ApplicationLogo from '@/Components/ApplicationLogo.vue';
    import Dropdown from '@/Components/Dropdown.vue';
    import DropdownLink from '@/Components/DropdownLink.vue';
    import NavLink from '@/Components/NavLink.vue';
    import ResponsiveNavLink from '@/Components/ResponsiveNavLink.vue';
    import { Link,usePage } from '@inertiajs/vue3';
    import Topbar from '@/Components/partials/Topbar.vue';
    import Sidebar from '@/Components/partials/Sidebar.vue';
    import Footer from '@/Components/partials/Footer.vue';
    import { RouterLink } from 'vue-router';
    
    const page = usePage()
    const showingNavigationDropdown = ref(false);
    const currentPath = computed(() => window.location.pathname);
    const currentUser = page.props.auth.user;
    
        
</script>

<template>
    <div>
        <div  class="wrapper">
            <Topbar />
            <Sidebar :currentUser = "currentUser" />
            <!-- Content Wrapper. Contains page content -->
            <!-- Page Content -->
            <main>
                <slot />
            </main>
            <!-- /.content-wrapper -->             
            <Footer/>
        </div>
    </div>
</template>



<style> 

 
</style>

import { createRouter, createWebHistory } from "vue-router";
// import HomeView from "../views/HomeView.vue";
// import AboutView from "../views/AboutView.vue";
// import Register from "@/Pages/Auth/Register.vue";
import Welcome from "@/Pages/Welcome.vue";
import Dashboard from "@/Pages/Dashboard.vue";
import Training from "@/Pages/Training.vue";



const routes = [
    { path:'/', name:'Welcome', component:Welcome },
    { path:'/dashboard', name:'Dashboard', component:Dashboard },
    { path:'/training', name:'Training', component:Training },
    // { path:'/about', name:'AboutView', component:AboutView},
    // { path:'/register', name:'Register', component:Register},
]

const router = createRouter({
    history: createWebHistory(),
    routes,
});

export default router;
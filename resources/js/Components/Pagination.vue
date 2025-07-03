
<script setup>
    import {router}  from "@inertiajs/vue3";
    defineProps({
        data:{
            type:Object,
            required:true
        },

        updatePageNumber:{
            type:Function,
            required:true
        }

    });


    
    // const updatePageNumber = (link)=>{
    //     let pageNumber = link.url.split('=')[1];
    //     router.visit("/permissions?page=" +  pageNumber, {
    //         preserveScroll:true
    //     });
    // }

</script>
<template>
    <div class="container py-3">            
      <div class="row justify-content-between align-items-center">
            <div class="col-auto">
                <p class="mb-0 text-muted">
                    Showing
                    {{ data.from }}
                    to
                    {{ data.to }}
                    of
                    {{ data.total }}
                    results
                </p>
            </div>
            <div class="col-auto">
                <nav aria-label="Page navigation">
                    <ul class="pagination  mb-0">
                    <li
                        v-for="(link, index) in data.links"
                        :key="index"
                        class="page-item"
                        :class="{ active: link.active, disabled: !link.url }"
                    >
                        <button
                        class="page-link"
                        v-html="link.label"
                        @click.prevent="updatePageNumber(link)"
                        :disabled="link.active || !link.url"
                        ></button>
                    </li>
                    </ul>
                </nav>
            </div>
      </div>
    </div>
  </template>
  

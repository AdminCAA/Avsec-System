<script setup>
import { defineProps } from 'vue';
import { Head,Link, useForm } from '@inertiajs/vue3';


import { usePage } from '@inertiajs/vue3'

const page = usePage()
const message = page.props.flash.error || 'Something went wrong.'

  
</script>

<template>
    <div class="d-flex align-items-center justify-content-center min-vh-100 bg-light">
      <div class="card shadow-lg p-4 text-center" style="max-width: 500px; width: 100%;">
        
        <!-- Optional error icon -->
        <div class="mb-3 text-danger">
          <i class="fas fa-exclamation-triangle fa-3x"></i>
        </div>
  
        <h1 class="h3 fw-bold text-danger mb-2">Something went wrong</h1>
        <p class="text-muted mb-4">{{ message }}</p>
  
        <Link 
          href="/dashboard" 
          class="btn btn-info"
          role="button"
          aria-label="Back to Dashboard"
        >
          ← Back to Dashboard
        </Link>
      </div>
    </div>
  </template>
  


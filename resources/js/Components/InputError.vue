<script setup>
defineProps({
    message: {
        type: String,
    },
});
</script>

<template>
    <div v-show="message">
        <p class="text-danger font-weight-bold">                        
            {{ message }}
        </p>
    </div>
</template>

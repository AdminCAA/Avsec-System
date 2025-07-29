<script setup>
// import { Bar } from 'vue-chartjs'
// import { onMounted, onBeforeUnmount } from 'vue';

// import {
//   Chart as ChartJS,
//   Title,
//   Tooltip,
//   Legend,
//   BarElement,
//   CategoryScale,
//   LinearScale
// } from 'chart.js'

// ChartJS.register(Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale)

// const props = defineProps({
//   operators: Object
// })

// const labels = Object.keys(props.operators)
// const values = Object.values(props.operators)

// const getRandomColor = () => {
//   // Returns a random hex color
//   const letters = '0123456789ABCDEF';
//   let color = '#';
//   for (let i = 0; i < 6; i++) {
//     color += letters[Math.floor(Math.random() * 16)];
//   }
//   return color;
// }
// const options = {
//   responsive: true,
//   //maintainAspectRatio: false,
//   // other options...
// };
// const backgroundColors = labels.map(() => getRandomColor());

// const data = {
//   labels,
//   datasets: [
//     {
//       label: 'Operator By Category',
//       backgroundColor: backgroundColors,
//       data: values
//     }
//   ]
// }

// let chartInstance = null;

// onMounted(() => {
//   window.addEventListener('resize', handleResize);
// });

// onBeforeUnmount(() => {
//   window.removeEventListener('resize', handleResize);
// });

// const handleResize = () => {
//   if (chartInstance) {
//     chartInstance.resize();
//   }
// };


</script>

<template>
  <div class="card">
    <div class="card-header">Controls by Operator Type</div>
    <div class="card-body">
      <!-- <div style=" height: 400px;"> -->
        <!-- Chart will be rendered here -->
      <!-- <Bar :data="data" :options="options" /> -->
      <!-- </div> -->
    </div>
  </div>
</template>

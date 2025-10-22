<script setup>
import { ref, watch } from 'vue';
import { Head, Link, useForm } from '@inertiajs/vue3';

const form = useForm({
  name: '',
  email: '',
  password: '',
  password_confirmation: '',
});

const submit = () => {
  form.post(route('register'), {
    onFinish: () => form.reset('password', 'password_confirmation'),
  });
};

// Validation errors
const nameError = ref('');
const emailError = ref('');
const passwordError = ref('');
const confirmPasswordError = ref('');

watch(() => form.name, (value) => {
  nameError.value = '';
  if (!value) nameError.value = 'Name is required.';
  else if (value.length < 3) nameError.value = 'Name must be at least 3 characters.';
  else if (value.length > 50) nameError.value = 'Name must be less than 50 characters.';
});

watch(() => form.email, (value) => {
  emailError.value = '';
  if (!value) emailError.value = 'Email is required.';
  else if (!/^\S+@\S+\.\S+$/.test(value)) emailError.value = 'Enter a valid email address.';
});

watch(() => form.password, (value) => {
  passwordError.value = '';
  if (!value) passwordError.value = 'Password is required.';
  else if (value.length < 8) passwordError.value = 'Password must be at least 8 characters.';
  else if (!/[A-Z]/.test(value)) passwordError.value = 'Add at least one uppercase letter.';
  else if (!/[a-z]/.test(value)) passwordError.value = 'Add at least one lowercase letter.';
  else if (!/[0-9]/.test(value)) passwordError.value = 'Add at least one number.';
  else if (!/[!@#$%^&*(),.?":{}|<>]/.test(value)) passwordError.value = 'Add at least one special character.';
  else if (value !== form.password_confirmation) passwordError.value = 'Passwords do not match.';
});

watch(() => form.password_confirmation, (value) => {
  confirmPasswordError.value = '';
  if (!value) confirmPasswordError.value = 'Password confirmation is required.';
  else if (value !== form.password) confirmPasswordError.value = 'Passwords do not match.';
});
</script>

<template>

  <Head title="Register" />
  <div class="login-wrapper">
    <div class="login-container">

      <!-- LEFT PANEL -->
      <div class="left-panel">
        <div class="header-section">
          <img src="/assets/caa-logo.png" alt="CAA Logo" class="caa-logo" />
          <h2 class="welcome-title">Welcome to</h2>
          <h2 class="welcome-title">Aviation Security Information <br /> Management System </h2>
        </div>

        <form @submit.prevent="submit" class="login-form">
          <input v-model="form.name" type="text" placeholder="Full Name" class="input-field" />
          <div v-if="nameError" class="error">{{ nameError }}</div>

          <input v-model="form.email" type="email" placeholder="Email" class="input-field" />
          <div v-if="emailError" class="error">{{ emailError }}</div>

          <input v-model="form.password" type="password" placeholder="Password" class="input-field" />
          <div v-if="passwordError" class="error">{{ passwordError }}</div>

          <input v-model="form.password_confirmation" type="password" placeholder="Confirm Password"
            class="input-field" />
          <div v-if="confirmPasswordError" class="error">{{ confirmPasswordError }}</div>

          <button type="submit" class="btn-primary" :disabled="form.processing">
            <span v-if="form.processing"><i class="fas fa-spinner fa-spin"></i> Wait..</span>
            <span v-else>Register</span>
          </button>
        </form>

        <p class="account-text">
          Already have an account?
          <Link :href="route('login')">Login</Link>
        </p>
      </div>

      <!-- RIGHT PANEL -->
      <div class="right-panel">
        <img src="/assets/register-3.png" class="illustration" alt="Register" />

        <div class="register-info">
          <h3>New Here?</h3>
          <p>
            Register an account to access ASIMS. Once registered, you can securely log in,
            manage your profile, and gain access to Aviation Security Information.
          </p>
          <Link :href="route('login')" class="btn-register">Back to Login</Link>
        </div>
      </div>
    </div>
  </div>
</template>
<style scoped>
body,
html {
  height: 100%;
  margin: 0;
}

.login-wrapper {
  display: flex;
  align-items: center;
  justify-content: center;
  height: 100%;
  background: #f0f2f5;
  padding: 40px;
}

/* Container */
.login-container {
  display: flex;
  width: 80%;
  min-height: 70vh;
  background: #fff;
  border-radius: 16px;
  box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
  overflow: hidden;
  font-family: 'Poppins', 'Segoe UI', sans-serif;
  /* font-family: 'Inter', sans-serif; */
}

/* LEFT PANEL */
.left-panel {
  flex: 1;
  background: #fff;
  padding: 40px;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
}

.header-section {
  display: flex;
  flex-direction: column;
  align-items: center;
  margin-bottom: 20px;
}

.caa-logo {
  width: 120px;
  height: auto;
  margin-bottom: 15px;
}

.welcome-title {
  font-size: 24px;
  font-weight: bold;
  margin-bottom: 10px;
  text-align: center;
}

.subtitle {
  font-size: 14px;
  color: #666;
  max-width: 310px;
  text-align: center;
}

.login-form {
  display: flex;
  flex-direction: column;
}

.input-field {
  border: 1px solid #ccc;
  border-radius: 8px;
  padding: 12px;
  margin-bottom: 15px;
}

.error {
  font-size: 13px;
  color: red;
  margin-bottom: 10px;
}

.btn-primary {
  background: #000;
  color: #fff;
  padding: 12px;
  border: none;
  border-radius: 8px;
  cursor: pointer;
  text-decoration: none;
  transition: 0.3s;
}

.btn-primary:hover {
  background-color: #005fa3;
}

.account-text {
  margin-top: 20px;
  text-align: center;
}

.bottom-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.avatars img {
  width: 35px;
  height: 35px;
  border-radius: 50%;
  margin-right: -10px;
}

.arrow-btn {
  background: #000;
  color: #fff;
  border: none;
  border-radius: 50%;
  width: 40px;
  height: 40px;
  font-size: 20px;
  cursor: pointer;
}

/* RIGHT PANEL */
.right-panel {
  flex: 1;
  background: #e9f5f9;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  position: relative;
}

.right-panel h2,
.right-panel .cta {
  position: absolute;
  z-index: 2;
  color: #fff;
  text-align: center;
  padding: 20px;
}

.right-panel h2 {
  top: 40px;
  font-size: 28px;
  margin-bottom: 20px;
  width: 80%;
  /* takes 80% of right panel width */
  margin-left: auto;
  margin-right: auto;
  line-height: 1.4;
}

.right-panel .cta {
  bottom: 150px;
  left: 50%;
  transform: translateX(-50%);
  max-width: 80%;
}

.illustration {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

/* Register Info */
.register-info {
  position: absolute;
  bottom: 40px;
  background: rgba(255, 255, 255, 0.5);
  /* reduced opacity */
  padding: 20px;
  border-radius: 12px;
  text-align: center;
  max-width: 80%;
  backdrop-filter: blur(2px);
}


.register-info h3 {
  margin-bottom: 10px;
  color: #333;
}

.register-info p {
  font-size: 14px;
  color: #555;
  margin-bottom: 15px;
}

.btn-register {
  display: inline-block;
  background-color: #000;
  color: white;
  padding: 10px 20px;
  border-radius: 8px;
  text-decoration: none;
  transition: 0.3s;
}

.btn-register:hover {
  background-color: #005fa3;
}

/* Responsive */
@media (max-width: 900px) {
  .login-container {
    flex-direction: column;
    width: 95%;
    height: auto;
  }

  .left-panel,
  .right-panel {
    flex: none;
    width: 100%;
    min-height: auto;
    padding: 20px;
  }

  .right-panel h2,
  .right-panel .cta,
  .register-info {
    position: static;
    transform: none;
    margin-top: 20px;
  }

  .illustration {
    height: 250px;
  }
}
</style>

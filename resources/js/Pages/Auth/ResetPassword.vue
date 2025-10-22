<script setup>
import { Head, useForm } from '@inertiajs/vue3';

const props = defineProps({
  email: {
    type: String,
    required: true,
  },
  token: {
    type: String,
    required: true,
  },
});

const form = useForm({
  token: props.token,
  email: props.email,
  password: '',
  password_confirmation: '',
});

const submit = () => {
  form.post(route('password.update'), {
    onFinish: () => form.reset('password', 'password_confirmation'),
  });
};
</script>

<template>
  <Head title="Reset Password" />

  <div class="login-wrapper">
    <div class="login-container">

      <!-- LEFT PANEL -->
      <div class="left-panel">
        <div class="header-section">
          <img src="/assets/caa-logo.png" alt="CAA Logo" class="caa-logo" />
          <h2 class="welcome-title">Reset Your Password</h2>
          <p class="subtitle">
            Please enter your new password below. Make sure it’s strong and easy to remember.
          </p>
        </div>

        <form @submit.prevent="submit" class="login-form">

          <!-- Token -->
          <input type="hidden" v-model="form.token" />

          <!-- Email -->
          <div class="form-group mb-3">
            <input
              id="email"
              type="email"
              placeholder="Email"
              class="input-field"
              v-model="form.email"
              autocomplete="username"
              :disabled="true"
            />
            <div v-if="form.errors.email" class="error">{{ form.errors.email }}</div>
          </div>

          <!-- Password -->
          <div class="form-group mb-3">
            <input
              id="password"
              type="password"
              placeholder="New Password"
              class="input-field"
              v-model="form.password"
              autocomplete="new-password"
            />
            <div v-if="form.errors.password" class="error">{{ form.errors.password }}</div>
          </div>

          <!-- Confirm Password -->
          <div class="form-group mb-3">
            <input
              id="password_confirmation"
              type="password"
              placeholder="Confirm Password"
              class="input-field"
              v-model="form.password_confirmation"
              autocomplete="new-password"
            />
            <div v-if="form.errors.password_confirmation" class="error">
              {{ form.errors.password_confirmation }}
            </div>
          </div>

          <!-- Submit -->
          <button type="submit" class="btn-primary" :disabled="form.processing">
            <span v-if="form.processing">
              <i class="fas fa-spinner fa-spin"></i> Resetting...
            </span>
            <span v-else>Reset Password</span>
          </button>
        </form>
      </div>

      <!-- RIGHT PANEL -->
      <div class="right-panel">
        <h2>Welcome to <br />Aviation Security Information Management System (ASIMS)</h2>
        <img src="/assets/register-3.png" class="illustration" alt="Reset Password" />

        <div class="register-info">
          <h3>Forgot again?</h3>
          <p>
            If you’re still having trouble, contact support or try resetting again.
          </p>
          <a :href="route('login')" class="btn-register">Back to Login</a>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
/* Reuse styles from verifyEmail.vue */

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

.login-container {
  display: flex;
  width: 80%;
  min-height: 70vh;
  background: #fff;
  border-radius: 16px;
  box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
  overflow: hidden;
  font-family: 'Poppins', 'Segoe UI', sans-serif;
}

/* LEFT PANEL */
.left-panel {
  flex: 1;
  background: #fff;
  padding: 40px;
  display: flex;
  flex-direction: column;
  justify-content: center;
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
  margin-bottom: 20px;
}

.input-field {
  border: 1px solid #ccc;
  border-radius: 8px;
  padding: 12px;
  width: 100%;
  margin-bottom: 10px;
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

.right-panel h2 {
  top: 40px;
  font-size: 28px;
  margin-bottom: 20px;
  width: 80%;
  text-align: center;
  color: #fff;
  z-index: 2;
}

.illustration {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.register-info {
  position: absolute;
  bottom: 40px;
  background: rgba(255, 255, 255, 0.5);
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

  .illustration {
    height: 250px;
  }

  .register-info {
    position: static;
    transform: none;
    margin-top: 20px;
  }
}
</style>

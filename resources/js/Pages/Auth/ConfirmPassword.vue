<script setup>
import { Head, useForm, Link } from '@inertiajs/vue3';

const form = useForm({
  password: '',
});

const submit = () => {
  form.post(route('password.confirm'), {
    onFinish: () => form.reset(),
  });
};
</script>

<template>
  <Head title="Confirm Password" />

  <div class="login-wrapper">
    <div class="login-container">

      <!-- LEFT PANEL -->
      <div class="left-panel">
        <div class="header-section">
          <img src="/assets/caa-logo.png" alt="CAA Logo" class="caa-logo" />
          <h2 class="welcome-title">Confirm Your Password</h2>
          <p class="subtitle">
            This is a secure area of the system. Please confirm your password before continuing.
          </p>
        </div>

        <form @submit.prevent="submit" class="login-form">
          <div class="form-group mb-3">
            <input
              id="password"
              type="password"
              class="input-field"
              placeholder="Enter your password"
              v-model="form.password"
              autocomplete="current-password"
              autofocus
            />
            <div v-if="form.errors.password" class="error">{{ form.errors.password }}</div>
          </div>

          <div class="button-group">
            <button
              type="submit"
              class="btn-primary"
              :disabled="form.processing"
            >
              <span v-if="form.processing">
                <i class="fas fa-spinner fa-spin"></i> Confirming...
              </span>
              <span v-else>Confirm</span>
            </button>

            <Link :href="route('profile.edit')" class="btn-cancel">Cancel</Link>
          </div>
        </form>
      </div>

      <!-- RIGHT PANEL -->
      <div class="right-panel">
        <h2>Aviation <br />Security Information Management System (ASIMS)</h2>
        <img src="/assets/register-3.png" class="illustration" alt="Confirm Password" />

        <div class="register-info">
          <h3>Need Help?</h3>
          <p>
            If you’ve forgotten your password, you can reset it using the link below.
          </p>
          <Link :href="route('password.request')" class="btn-register">
            Forgot Password?
          </Link>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
/* Reused from verifyEmail.vue for consistency */
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

.button-group {
  display: flex;
  justify-content: space-between;
  align-items: center;
  gap: 12px;
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
  flex: 1;
  text-align: center;
}

.btn-primary:hover {
  background-color: #005fa3;
}

.btn-cancel {
  background-color: #888;
  color: white;
  padding: 12px;
  border-radius: 8px;
  text-decoration: none;
  transition: 0.3s;
  flex: 1;
  text-align: center;
}

.btn-cancel:hover {
  background-color: #444;
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

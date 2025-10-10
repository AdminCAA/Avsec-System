<script>
import AppFooter from '@/Components/AppFooter.vue';
import { Head } from '@inertiajs/vue3';
import Swal from 'sweetalert2';
import axios from 'axios';

export default {
    name: 'ContactPage',
    components: { Head, AppFooter },
    data() {
        return {
            loading: false,
            form: {
                first_name: '',
                last_name: '',
                email: '',
                subject: '',
                message: '',
            },
            errors: {},
        };
    },
    methods: {
        async sendMessage() {
            console.log('Form submitted', this.form);
            this.loading = true;
            this.errors = {};

            try {
                await axios.post('/contacts', this.form);
                Swal.fire({
                    icon: 'success',
                    title: 'Message Sent!',
                    text: 'Your message has been sent successfully.',
                    confirmButtonColor: '#000',
                });
                this.form = { first_name: '', last_name: '', email: '', subject: '', message: '' };
            } catch (error) {
                if (error.response && error.response.status === 422) {
                    this.errors = error.response.data.errors || {};
                } else {
                    Swal.fire({
                        icon: 'error',
                        title: 'Oops...',
                        text: 'Failed to send message. Please try again.',
                        confirmButtonColor: '#000',
                    });
                }
            } finally {
                this.loading = false;
            }
        },
    },
};
</script>


<template>

    <Head title="Contact" />

    <div class="contact-page">
        <!-- Hero Section -->
        <section class="hero-section">
            <div class="hero-overlay">
                <h1>Contact Us</h1>
                <p>We’re here to assist you. Reach out with any questions or feedback!</p>
            </div>
        </section>

        <!-- Breadcrumb -->
        <div class="breadcrumb">
            <span>Home</span> › <span class="current">Contact Us</span>
        </div>

        <!-- Contact Content -->
        <section class="contact-content">
            <!-- Left column: contact info -->
            <div class="contact-info card">
                <h2>Get in <br />touch with us</h2>
                <p>
                    Whether you have a question about our services, need assistance with your account, or want to
                    provide feedback, our team is ready to assist you.
                </p>
                <hr />
                <div class="info-item">
                    <strong>Official Email:</strong>
                    <span>civil.aviation@caa.co.zm</span>
                </div>
                <div class="info-item">
                    <strong>Unit Email:</strong>
                    <span>AVSEC@caa.co.zm</span>
                </div>
                <div class="info-item">
                    <strong>Phone:</strong>
                    <span>+260 211 251677 / 251861</span>
                </div>
                <div class="info-item">
                    <strong>Website:</strong>
                    <span>www.caa.co.zm</span>
                </div>

                <hr />
                <p class="availability">Available Monday to Friday, 8 AM – 5 PM GMT</p>
            </div>

            <!-- Right column: form -->
            <div class="contact-form card">
                <h2>Send us a Message</h2>
                <br />
                <form @submit.prevent="sendMessage">
                    <div class="row mb-3">
                        <div class="col-md-6 mb-2 mb-md-0">
                            <input type="text" placeholder="First Name" v-model="form.first_name"
                                class="form-control" />
                            <span v-if="errors.first_name" class="error-message">{{ errors.first_name[0] }}</span>
                        </div>
                        <div class="col-md-6">
                            <input type="text" placeholder="Last Name" v-model="form.last_name" class="form-control" />
                            <span v-if="errors.last_name" class="error-message">{{ errors.last_name[0] }}</span>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-6 mb-2 mb-md-0">
                            <input type="email" placeholder="Email Address" v-model="form.email" class="form-control" />
                            <span v-if="errors.email" class="error-message">{{ errors.email[0] }}</span>
                        </div>
                        <div class="col-md-6">
                            <input type="text" placeholder="Subject" v-model="form.subject" class="form-control" />
                            <span v-if="errors.subject" class="error-message">{{ errors.subject[0] }}</span>
                        </div>
                    </div>

                    <div class="mb-3">
                        <textarea placeholder="Your Message" rows="5" v-model="form.message"
                            class="form-control"></textarea>
                        <span v-if="errors.message" class="error-message">{{ errors.message[0] }}</span>
                    </div>

                    <button type="submit" class="btn btn-dark px-4" :disabled="loading">
                        {{ loading ? 'Sending...' : 'Send Message' }}
                    </button>
                </form>
            </div>
        </section>

        <AppFooter />
    </div>
</template>


<style scoped>
/* Base */
.contact-page {
    font-family: 'Poppins', 'Segoe UI', sans-serif;
    background: #f5f5f5;
    color: #333;
}

/* Hero */
.hero-section {
    position: relative;
    background-image: url('/assets/contact-1.jpg');
    background-size: cover;
    background-position: center;
    height: 40vh;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #fff;
}

.hero-overlay {
    background-color: rgba(0, 0, 0, 0.5);
    padding: 2rem 3rem;
    border-radius: 12px;
    text-align: center;
}

.hero-overlay h1 {
    font-size: clamp(2.5rem, 5vw, 4rem);
    margin-bottom: 0.5rem;
}

.hero-overlay p {
    font-size: clamp(1rem, 2.5vw, 1.5rem);
}

/* Breadcrumb */
.breadcrumb {
    padding: 1rem 4vw;
    font-size: 1rem;
    color: #666;
}

.breadcrumb .current {
    font-weight: bold;
    color: #000;
}

/* Contact Content */
.contact-content {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
    gap: 3rem;
    padding: 4vw;
    align-items: start;
}

/* Cards */
.card {
    background: #fff;
    padding: 2rem;
    border-radius: 12px;
    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.08);
}

/* Left column */
.contact-info h2 {
    font-size: 2rem;
    font-weight: bold;
    margin-bottom: 1rem;
}

.contact-info p {
    color: #555;
    margin-bottom: 1rem;
    line-height: 1.5;
}

.contact-info .info-item {
    display: flex;
    justify-content: space-between;
    /* pushes label left, value right */
    align-items: center;
    margin-bottom: 0.5rem;
    font-size: 1rem;
}

.contact-info .info-item strong {
    font-weight: bold;
}

.availability {
    font-size: 0.9rem;
    color: #777;
    margin-top: 0.5rem;
}

/* Right column form */
.contact-form form {
    display: flex;
    flex-direction: column;
    gap: 1rem;
}

.contact-form input,
.contact-form textarea {
    width: 100%;
    padding: 0.8rem 1rem;
    border: 1px solid #ddd;
    border-radius: 8px;
    font-size: 1rem;
    transition: all 0.3s;
}

.contact-form input:focus,
.contact-form textarea:focus {
    border-color: #000;
    outline: none;
}

.send-btn:hover {
    background: #333;
}

@media (max-width: 768px) {
    .contact-form .row {
        flex-direction: column;
    }
}

/* Validation */
.error-message {
    color: rgb(223, 26, 26);
    font-size: 0.875rem;
    margin-top: 0.25rem;
    display: block;
}
</style>

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")



import Vue from 'vue'
import App from '../app.vue'

import router from 'router'
import axios from 'axios'
import store from 'store'

import Vuetify from 'vuetify'
import 'vuetify/dist/vuetify.min.css'
import VueToast from 'vue-toast-notification'
import 'vue-toast-notification/dist/theme-sugar.css'
import Toasted from 'vue-toasted'
import VueToastify from "vue-toastify";


Vue.use(Vuetify)
Vue.use(VueToast)


document.addEventListener('DOMContentLoaded', () => {
Vue.use(Toasted)
Vue.use(VueToastify);
  const el = document.body.appendChild(document.createElement('application'))
  const app = new Vue({
    router,
    store,
    vuetify: new Vuetify(),
    el,
    render: h => h(App)
  })

  console.log(app)
})


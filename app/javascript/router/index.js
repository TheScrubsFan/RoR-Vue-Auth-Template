import Vue from 'vue';
import VueRouter from 'vue-router';

import LogIn from '../components/log_in.vue'

Vue.use(VueRouter);

const router = new VueRouter({
  mode: 'history',
  routes: [
    {
      path: '/',
      name: 'log_in',
      component: LogIn
    }
  ]
})

export default router;

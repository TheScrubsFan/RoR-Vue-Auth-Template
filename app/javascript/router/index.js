import Vue from 'vue';
import VueRouter from 'vue-router';

import SignIn from '../components/sign_in.vue'
import SignUp from '../components/sign_up.vue'

Vue.use(VueRouter);

const router = new VueRouter({
  mode: 'history',
  routes: [
    {
      path: '/sign_in',
      name: 'sign_in',
      component: SignIn
    },
    {
      path: '/sign_up',
      name: 'sign_up',
      component: SignUp
    }
  ]
})

export default router;

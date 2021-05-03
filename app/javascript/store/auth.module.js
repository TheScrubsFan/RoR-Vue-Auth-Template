import AuthService from '../services/auth.service'

const initialState = {
  loggedIn: null,
  user: null
}

export const auth = {
  namespaced: true,
  state: initialState,
  actions: {
    login({ commit }, user) {
      return AuthService.login(user).then(
        user => {
          commit('loginSuccess', user);
          return Promise.resolve(user);
        },
        error => {
          commit('loginFailure');
          return Promise.reject(error);
        }
      );
    },

    logout({ commit }) {
      return AuthService.logout().then(
        response => {
          commit('logout')
          return Promise.resolve(response)
        },
        error => {
          return Promise.reject(error)
        }
      )
    },

    register({ commit }, user) {
      return AuthService.register(user).then(
        response => {
          commit('registerSuccess', response.data)
          return Promise.resolve(response.data)
        },
        error => {
          commit('registerFailure')
          return Promise.reject(error)
        }
      )
    },

    refresh({ commit }) {
      return AuthService.refresh().then(
        response => {
          commit('loginSuccess', response.data)
          return Promise.resolve(response.data)
        },
        error => {
          commit('logout')
          return Promise.reject(error)
        }
      )

    }
  },

  getters: {
    user: state => {
      return state.user
    }
  },

  mutations: {
    loginSuccess(state, user) {
      state.loggedIn = true
      state.user = user
    },
    loginFailure(state) {
      state.loggedIn = false
      state.user = null
    },
    logout(state) {
      state.loggedIn = false
      state.user = null
    },
    registerSuccess(state, user) {
      state.loggedIn = true
      state.user = user
    },
    registerFailure(state) {
      state.loggedIn = false
    }
  }
};

import axios from 'axios'
import store from 'store'
import AuthService from '../services/auth.service'

class Interceptors {
  setTokens(token) {
    axios.interceptors.request.use(function(config) {
      if(token) {
        config.headers.Authorization = `Bearer ${token.access_token}`
      }

      return config
    }, function(err) {
      return Promise.reject(err)

    })
  }

  setRefresh() {
    axios.interceptors.response.use(
      (response) => { return response },
      (error) => {
        if (error.response.status !== 401) {
          return new Promise((resolve, reject) => {
            reject(error)
          })
        }

        if (error.config.url == '/api/tokens/refresh') {
          store.dispatch('auth/logout')

          return new Promise((resolve, reject) => {
            console.log(error)
          })
        }

        return AuthService.refresh()
          .then((token) => {
            const config = error.config;
            config.headers['Authorization'] = `Bearer ${token.access_token}`
            store.dispatch('auth/login', token)

            return new Promise((resolve, reject) => {
              axios.request(config).then(response => {
                resolve(response)
              }).catch((error) => {
                reject(error)
              })
            })

          })
          .catch((error) => {
            Promise.reject(error)
          })
      }
    )
  }
}

export default new Interceptors()

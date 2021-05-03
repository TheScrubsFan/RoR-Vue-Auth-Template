import axios from 'axios'
import store from 'store'
import AuthService from '../services/auth.service'
import humps from 'humps'

class Interceptors {
  setTokens(data) {
    axios.interceptors.request.use(function(config) {
      if(data) {
        config.headers.Authorization = `Bearer ${data.accessToken}`
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
            config.headers['Authorization'] = `Bearer ${token.accessToken}`
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

  transformKeys() {
    axios.defaults.transformResponse = [(data, headers) => {
      try {
        var parsedData = JSON.parse(data)

        if (parsedData && headers['content-type'].includes('application/json')) {
          return humps.camelizeKeys(parsedData)
        }
      }
      catch (e) { }

      return data
    }]

    // TODO: make smth with get query
    axios.defaults.transformRequest = [(data) => {
      if (data) {
        let formData = new FormData()

        Object.keys(data).forEach(attr => {
          formData.append(humps.decamelize(attr), data[attr])
        })

        return formData
      }
    }]
  }
}

export default new Interceptors()

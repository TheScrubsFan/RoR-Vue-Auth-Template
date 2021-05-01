import axios from 'axios'

class AuthService {
  login(user) {
    let url = '/api/tokens/create'

    return axios.post(url, user)
  }

  logout() {
    let url = '/api/tokens/signout'

    return axios.post(url)
  }

  refresh() {
    let url = '/api/tokens/refresh'

    return axios.post(url)
  }

  register(user) {
    let url = '/api/registrations/signup'

    return axios.post(url, user)
  }
}

export default new AuthService()

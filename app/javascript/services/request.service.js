import axios from 'axios';
import authHeader from './auth-header';

class RequestService {
  get(url, params) {
    return axios.get(
      url,
      {
        headers: authHeader(),
        params: params
      }
    );
  }
}

export default new UserService();

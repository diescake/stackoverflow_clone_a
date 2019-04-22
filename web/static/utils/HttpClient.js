import axios from 'axios';
import camelCase from 'just-camel-case';
import snakeCase from 'just-snake-case';

export default class HttpClient {
  static get(path, options) {
    return axios.get(path, HttpClient._snakeCaseOptions(options))
      .then(res => HttpClient._camelizeResponse(res));
  }

  static post(path, body, options) {
    return axios.post(path, HttpClient._snakeCaseKeyRecursive(body), HttpClient._snakeCaseOptions(options))
      .then(res => HttpClient._camelizeResponse(res));
  }

  static put(path, body, options) {
    return axios.put(path, HttpClient._snakeCaseKeyRecursive(body), HttpClient._snakeCaseOptions(options))
      .then(res => HttpClient._camelizeResponse(res));
  }

  static _mapKeyRecursive(o, iteratee) {
    if (Array.isArray(o)) {
      return o.map(item => HttpClient._mapKeyRecursive(item, iteratee));
    }
    if (typeof o === 'object') {
      return Object.keys(o).reduce((memo, key) => {
        const camelizedKey = iteratee(key);
        return { ...memo, [camelizedKey]: HttpClient._mapKeyRecursive(o[key], iteratee) };
      }, {});
    }
    return o;
  }

  static _camelizeKeyRecursive(o) {
    return HttpClient._mapKeyRecursive(o, camelCase);
  }

  static _snakeCaseKeyRecursive(o) {
    return HttpClient._mapKeyRecursive(o, snakeCase);
  }

  static _camelizeResponse(res) {
    return { ...res, data: HttpClient._camelizeKeyRecursive(res.data) };
  }

  static _snakeCaseOptions(options = {}) {
    return { ...options, params: HttpClient._snakeCaseKeyRecursive(options.params) };
  }
}

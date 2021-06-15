import axios from 'axios'

export const client = axios.create({
  withCredentials: true,
  headers: {
    'x-csrf-token': document.head.querySelector('[name~=csrf-token][content]').attributes.getNamedItem('content').value,
  },
})

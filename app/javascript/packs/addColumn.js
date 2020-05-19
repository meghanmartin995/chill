const form = document.querySelector('#form')
const button = document.querySelector('#form-link')

button.addEventListener("click", addColumn);

function addColumn() {
  button.classList.add('hide')
  form.classList.remove('hide')
}

export default addColumn

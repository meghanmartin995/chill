const form = document.querySelector('#form')
// console.log(form)
const button = document.querySelector('#form-link')
// console.log(button)

button.addEventListener("click", addColumn);

console.log(button)
console.log(form)


function addColumn() {
  button.classList.add('hide')
  form.classList.remove('hide')
}



export default addColumn

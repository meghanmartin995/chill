const colorLabel = document.querySelectorAll('.form-check-label')
console.log(colorLabel)

const colorChange = () => {
  colorLabel.forEach(label => {
    console.log(label)
    label.classList.add('purple')
  })
}


export default colorChange

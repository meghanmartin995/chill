const menu = document.getElementById("menu");
console.log(menu)
const dropdown = document.getElementById("dropdown")
console.log(dropdown)


menu.addEventListener("click", openMenu);

function openMenu() {
  dropdown.classList.toggle("active")
}

export default dropdown

import { Controller } from 'stimulus'
import { Sortable } from '@shopify/draggable'

export default class extends Controller {
  static targets = ['column', 'todo']
  initialize() {}
  connect() {
    if (this.hasTodoTarget) {
      this.todoTargets.forEach(todo => {
        todo.setAttribute('style', 'z-index: 1000;')
      })
      const sortable = new Sortable(this.columnTargets, {
        draggable: 'li'
      })
      sortable.on('sortable:stop', function(event) {
        let array = Array.from(event.newContainer.children)
        array.forEach((todo, index) => {
          if (todo.classList.contains('draggable--original')) {
            array.splice(index, 1)
          } else if (todo.classList.contains('draggable-mirror')) {
            array.splice(index, 1)
          }
        })
        let positions = array.map(todo => todo.dataset.id)
        let url = event.dragEvent.source.getAttribute('data-url')
        let column = event.newContainer.getAttribute('data-id')
        let data = { todo: { column_id: column }, positions: positions }
        let token = document.head.querySelector('meta[name="csrf-token"]').getAttribute('content')
        fetch(url, {
          method: 'PUT',
          credentials: 'same-origin',
          headers: {
            "X-CSRF-Token": token,
            "Accept": "application/json",
            "Content-type": "application/json"
          },
          body: JSON.stringify(data)
        })
      })
    }
  }
  disconnect() {}
}

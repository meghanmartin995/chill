import { Controller} from "stimulus"
import consumer from '../channels/consumer'

export default class extends Controller {
  connect() {}

  initialize() {
    this.subscription()
  }

  disconnect() {
    this.subscription().unsubscribe()
    this.subscription().disconnected()
  }

  subscription() {
    if (this._subscription == undefined) {
      let _this = this
      this._subscription = consumer.subscriptions.create({ channel: "TopicChannel", topic_id: this.data.get("id") }, {
        connected() {
          // Called when the subscription is ready for use on the server
          console.log(`connected to ${_this.data.get("id")}`)
        },

        disconnected() {
          // Called when the subscription has been terminated by the server
          console.log(`disconnected from ${_this.data.get("id")}`)
        },

        received(data) {
          // Called when there's incoming data on the websocket for this channel
          console.log(`received from ${_this.data.get("id")}`)
          let type = data.type
          if (type == "create") {
            _this.createTodo(data.column_id, data.todo)
          } else if (type == "update") {
            _this.updateTodo(data.column_id, data.column)
          } else if (type == "destroy") {
            _this.destroyTodo(data.todo_id)
          }

        }
      });
    }
    return this._subscription
  }

  createTodo(column_id, todo) {
    let column = document.getElementById(`column_${column_id}`)
    // console.log(column)
    column.insertAdjacentHTML("afterBegin", todo)
  }

  updateTodo(column_id, todos) {
    let column = document.getElementById(`column_${column_id}`)
    console.log(column)
    column.innerHTML = todos
  }

  destroyTodo(todo_id) {
    let todo = document.getElementById(`todo_${todo_id}`)
    console.log(todo)
    todo.remove()
  }

}

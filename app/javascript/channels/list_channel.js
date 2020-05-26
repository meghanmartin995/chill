// import consumer from "./consumer"

// document.addEventListener("turbolinks:load", function () {
//   let list_room = document.getElementById('list_room')
//   if (list_room) {
//     consumer.subscriptions.create( { channel: "ListChannel", list_id: list_room.dataset.id }, {
//       connected() {
//         // Called when the subscription is ready for use on the server
//         console.log(`connected to ${list_room.dataset.id}`)
//       },

//       disconnected() {
//         // Called when the subscription has been terminated by the server
//         console.log(`disconnected from ${list_room.dataset.id}`)
//       },

//       received(data) {
//         // Called when there's incoming data on the websocket for this channel
//         console.log(`received from ${list_room.dataset.id}`)
//       }
//     });
//   }
// })

// document.addEventListener("turbolinks:before-visit", function () {
//   let list_room = document.getElementById('list_room')
//   if (list_room) {
//     consumer.list_channel.unsubscribe()
//     consumer.list_channel.disconnected()
//   }
// })

// app/javascript/channels/chatroom_channel.js
import consumer from "./consumer";

const initChatroomCable = () => {
  const messagesContainer = document.getElementById('messages');
  if (messagesContainer) {
    const id = messagesContainer.dataset.chatroomId;
    // received callback below
    // we insert adjacent html instead of using the console.log before to check
    consumer.subscriptions.create({ channel: "ChatroomChannel", id: id }, {
      received(data) {
        messagesContainer.insertAdjacentHTML('beforeend', data);
      }
    });
  }
}

export { initChatroomCable };

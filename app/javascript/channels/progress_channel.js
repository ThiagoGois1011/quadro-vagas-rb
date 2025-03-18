import consumer from "channels/consumer"

consumer.subscriptions.create("ProgressChannel", {
  connected() {
  },

  disconnected() {
  },

  received(data) {
    document.addEventListener("turbo:load", function() {
      const progressContainer = document.getElementById("progress_channel_container");
      const remaining = progressContainer.querySelector("#remaining").textContent;
      const error_list = progressContainer.querySelector("#error-list");
      
      if(parseInt(remaining) == 0){
        error_list.classList.remove('hidden')
      }
    })
  }
});

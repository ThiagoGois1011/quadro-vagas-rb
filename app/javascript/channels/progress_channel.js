import consumer from "channels/consumer"

consumer.subscriptions.create("ProgressChannel", {
  connected() {
  },

  disconnected() {
  },

  received(data) {
    console.log("Progresso recebido:", data);

    const progressText = document.getElementById("progress-text");

    if (progressText) {
      progressText.innerText = data.processed;
    }
  }
});

import consumer from "channels/consumer"

consumer.subscriptions.create("ProgressChannel", {
  connected() {
    console.log("Progresso conectado");
  },

  disconnected() {
  },

  received(data) {
    console.log("Progresso recebido:", data);

    const processed = document.getElementById("job-processed");
    const remaining = document.getElementById("job-remaining");
    const registrations = document.getElementById("job-registrations");
    const error = document.getElementById("job-error");
    
    if (processed) {
      processed.innerText = data.processed;
    }
    if (remaining) {
      remaining.innerText = data.remaining;
    }
    if (registrations) {
      registrations.innerText = data.successful_registrations;
    }
    if (error) {
      error.innerText = data.errors;
    }
  }
});

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["message"]

  showMessage() {
    if(this.messageTarget.innerHTML.trim() == ''){
      this.messageTarget.innerHTML =  'Bem vindo ao quadro de vagas 🚀';
    }
    else{
      this.messageTarget.innerHTML =  '';
    }

  }
}

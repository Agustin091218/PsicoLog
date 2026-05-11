import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["editor", "field"]

  connect() {
    this.boundSync = this.syncContent.bind(this)
    this.element.addEventListener("submit", this.boundSync)
  }

  disconnect() {
    this.element.removeEventListener("submit", this.boundSync)
  }

  syncContent() {
    this.fieldTarget.value = this.editorTarget.innerHTML
  }

  bold() {
    document.execCommand("bold")
    this.editorTarget.focus()
  }

  italic() {
    document.execCommand("italic")
    this.editorTarget.focus()
  }

  list() {
    document.execCommand("insertUnorderedList")
    this.editorTarget.focus()
  }

  quickNote() {
    const now = new Date().toLocaleString("es-AR", {
      dateStyle: "medium",
      timeStyle: "short"
    })
    document.execCommand("insertHTML", false,
      "<h2>Nota rápida — " + now + "</h2><p><br></p>")
    this.editorTarget.focus()
  }
}

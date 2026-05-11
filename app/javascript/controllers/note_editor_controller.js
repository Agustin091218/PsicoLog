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

  bold(e) {
    e.preventDefault()
    e.stopPropagation()
    this.editorTarget.focus()
    document.execCommand("bold")
  }

  italic(e) {
    e.preventDefault()
    e.stopPropagation()
    this.editorTarget.focus()
    document.execCommand("italic")
  }

  list(e) {
    e.preventDefault()
    e.stopPropagation()
    this.editorTarget.focus()
    document.execCommand("insertUnorderedList")
  }

  quickNote(e) {
    e.preventDefault()
    e.stopPropagation()
    const now = new Date().toLocaleString("es-AR", {
      dateStyle: "medium",
      timeStyle: "short"
    })
    this.editorTarget.focus()
    document.execCommand("insertHTML", false,
      "<h2>Nota rápida — " + now + "</h2><p><br></p>")
  }
}

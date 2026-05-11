import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  quickNote(e) {
    e.preventDefault()
    const now = new Date().toLocaleString("es-AR", {
      dateStyle: "medium",
      timeStyle: "short"
    })
    const editor = this.element.querySelector("trix-editor").editor
    editor.insertHTML("<h2>Nota rápida — " + now + "</h2><p><br></p>")
  }
}

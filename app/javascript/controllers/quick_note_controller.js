import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal", "form"]

  open() {
    this.modalTarget.classList.remove("hidden")
    this.modalTarget.classList.add("flex")
    document.body.classList.add("overflow-hidden")
  }

  close() {
    this.modalTarget.classList.add("hidden")
    this.modalTarget.classList.remove("flex")
    document.body.classList.remove("overflow-hidden")
  }

  submit(e) {
    e.preventDefault()
    const formData = new FormData(this.formTarget)

    fetch(this.formTarget.action, {
      method: "POST",
      body: formData,
      headers: { "Accept": "application/json" }
    })
    .then(r => r.json())
    .then(data => {
      if (data.success) {
        this.close()
        this.formTarget.reset()
        const editor = this.modalTarget.querySelector("trix-editor")
        if (editor) editor.editor.loadHTML("")
        this.flash(data.notice)
      } else {
        this.flash(data.error || "Error al guardar")
      }
    })
    .catch(() => this.flash("Error de conexión"))
  }

  flash(msg) {
    const el = document.createElement("div")
    el.className = "fixed bottom-24 right-6 z-50 bg-white rounded-xl shadow-lg border border-gray-200 px-4 py-3 text-sm animate-fade-in"
    el.textContent = msg
    document.body.appendChild(el)
    setTimeout(() => el.remove(), 3000)
  }
}

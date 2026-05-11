import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["textarea", "quickNote"]

  bold() {
    this.wrapSelection("**")
  }

  italic() {
    this.wrapSelection("_")
  }

  list() {
    this.wrapSelection("\n- ")
  }

  quickNote() {
    const textarea = this.textareaTarget
    const now = new Date().toLocaleString()
    textarea.value = `Quick note — ${now}\n\n`
    textarea.focus()
    textarea.selectionStart = textarea.value.length
  }

  wrapSelection(wrapper) {
    const textarea = this.textareaTarget
    const start = textarea.selectionStart
    const end = textarea.selectionEnd
    const selected = textarea.value.substring(start, end)

    if (selected.length === 0) return

    textarea.value =
      textarea.value.substring(0, start) +
      wrapper +
      selected +
      wrapper +
      textarea.value.substring(end)

    textarea.selectionStart = start + wrapper.length
    textarea.selectionEnd = end + wrapper.length
    textarea.focus()
  }
}

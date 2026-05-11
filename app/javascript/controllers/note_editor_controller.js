import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["textarea", "preview"]

  connect() {
    if (this.hasTextareaTarget && this.hasPreviewTarget) {
      this.updatePreview()
    }
  }

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
    const now = new Date().toLocaleString("es-AR", {
      dateStyle: "medium",
      timeStyle: "short"
    })
    const template = "## Nota rápida — " + now + "\n\n"
    textarea.value = template
    textarea.focus()
    textarea.selectionStart = textarea.value.length
    this.updatePreview()
  }

  updatePreview() {
    if (!this.hasPreviewTarget) return
    const text = (this.textareaTarget && this.textareaTarget.value) || ""
    this.previewTarget.innerHTML = this.renderMarkdown(text)
  }

  wrapSelection(wrapper) {
    const textarea = this.textareaTarget
    if (!textarea) return

    const start = textarea.selectionStart
    const end = textarea.selectionEnd
    const selected = textarea.value.substring(start, end)

    if (selected.length === 0) {
      if (wrapper === "\n- ") {
        textarea.value =
          textarea.value.substring(0, start) + wrapper +
          textarea.value.substring(end)
        textarea.selectionStart = start + wrapper.length
        textarea.selectionEnd = start + wrapper.length
      }
      textarea.focus()
      this.updatePreview()
      return
    }

    textarea.value =
      textarea.value.substring(0, start) +
      wrapper + selected + wrapper +
      textarea.value.substring(end)

    textarea.selectionStart = start + wrapper.length
    textarea.selectionEnd = end + wrapper.length
    textarea.focus()
    this.updatePreview()
  }

  renderMarkdown(text) {
    if (!text) return '<span class="text-gray-400 italic">Escribe tu nota...</span>'

    let html = text

    // Escape HTML
    html = html.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;")

    // Headings (##)
    html = html.replace(/^## (.+)$/gm, '<h2 class="text-base font-semibold text-gray-900 mt-3 mb-1">$1</h2>')

    // Bold (**text**)
    html = html.replace(/\*\*(.+?)\*\*/g, '<strong class="font-semibold">$1</strong>')

    // Italic (_text_)  — avoid matching URLs with underscores
    html = html.replace(/(^|\s)_([^_]+)_(\s|$|[.,!?;:])/g, '$1<em class="italic">$2</em>$3')

    // List items (lines starting with -)
    html = html.replace(/^- (.+)$/gm, '<li class="ml-4 list-disc">$1</li>')

    // Wrap consecutive <li> in <ul>
    html = html.replace(/((?:<li[^>]*>.*?<\/li>\n?)+)/g, '<ul class="mb-2">$1</ul>')

    // Line breaks
    html = html.replace(/\n/g, "<br>")

    return html
  }
}

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
        // Insert list marker at cursor
        textarea.value =
          textarea.value.substring(0, start) + wrapper +
          textarea.value.substring(end)
        textarea.selectionStart = start + wrapper.length
        textarea.selectionEnd = start + wrapper.length
      } else {
        // Insert wrapping markers and place cursor between them
        const placeholder = wrapper === "**" ? "texto" : "texto"
        textarea.value =
          textarea.value.substring(0, start) +
          wrapper + placeholder + wrapper +
          textarea.value.substring(end)
        textarea.selectionStart = start + wrapper.length
        textarea.selectionEnd = start + wrapper.length + placeholder.length
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

    html = html.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;")

    html = html.replace(/^## (.+)$/gm, '<h2 class="text-base font-semibold text-gray-900 mt-3 mb-1">$1</h2>')

    html = html.replace(/\*\*(.+?)\*\*/g, '<strong class="font-semibold">$1</strong>')

    html = html.replace(/(^|\s)_([^_]+)_(?=\s|$|[.,!?;:])/g, '$1<em class="italic">$2</em>')

    html = html.replace(/^- (.+)$/gm, '<li class="ml-4 list-disc">$1</li>')

    html = html.replace(/((?:<li[^>]*>.*?<\/li>\s*)+)/g, '<ul class="mb-2">$1</ul>')

    html = html.replace(/\n{2,}/g, "</p><p>")

    html = html.replace(/\n/g, "<br>")

    if (!html.startsWith("<")) html = "<p>" + html + "</p>"

    return html
  }
}

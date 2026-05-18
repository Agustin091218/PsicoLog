import { application } from "./application"
import QuickNoteController from "./quick_note_controller"
import NoteEditorController from "./note_editor_controller"

application.register("quick-note", QuickNoteController)
application.register("note-editor", NoteEditorController)

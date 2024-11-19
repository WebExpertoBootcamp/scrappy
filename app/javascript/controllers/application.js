import { Application } from "@hotwired/stimulus"
import NestedFormController from "./nested_form_controller";

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus = application
application.register("nested-form", NestedFormController);

export { application }



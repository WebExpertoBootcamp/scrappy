import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["template", "container"]

    add(event) {
        event.preventDefault()
        /* const content = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, new Date().getTime()) */
        const content = this.templateTarget.innerHTML.replace(
            /NEW_RECORD/g,
            ""
        );
        this.containerTarget.insertAdjacentHTML("beforeend", content)
    }


}
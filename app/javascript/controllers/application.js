import { Application } from "@hotwired/stimulus";

const application = Application.start();
application.register("sortable", Sortable);

// Configure Stimulus development experience
application.debug = false;
window.Stimulus = application;

export { application };

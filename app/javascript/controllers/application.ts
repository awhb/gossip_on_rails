import { Application } from "@hotwired/stimulus"

const application = Application.start() as Application;

// Configure Stimulus development experience
application.debug = false;
(window as any).Stimulus = application;

declare global {
    interface Window {
        Stimulus: Application;
    }
}

export { application }
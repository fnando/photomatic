import { Application } from "@hotwired/stimulus";

import { Hello } from "controllers/hello";

const application = Application.start();

declare const window: Window &
  typeof globalThis & { Stimulus: typeof application };

application.register("hello", Hello);

// Configure Stimulus development experience
application.debug = true;
window.Stimulus = application;

export { application };

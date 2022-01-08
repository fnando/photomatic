import { Application } from "@hotwired/stimulus";

import { FileUpload } from "controllers/FileUpload";

const application = Application.start();

declare const window: Window &
  typeof globalThis & { Stimulus: typeof application };

application.register("file-upload", FileUpload);

// Configure Stimulus development experience
application.debug = true;
window.Stimulus = application;

export { application };

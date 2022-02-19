import { Application } from "@hotwired/stimulus";

import { FileUpload } from "controllers/FileUpload";
import { CharsCounter } from "controllers/CharsCounter";
import { Menu } from "controllers/Menu";
import { LikeButton } from "controllers/LikeButton";

const application = Application.start();

declare const window: Window &
  typeof globalThis & { Stimulus: typeof application };

application.register("file-upload", FileUpload);
application.register("chars-counter", CharsCounter);
application.register("like-button", LikeButton);
application.register("menu", Menu);

// Configure Stimulus development experience
application.debug = true;
window.Stimulus = application;

export { application };

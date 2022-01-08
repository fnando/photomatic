import { Controller } from "@hotwired/stimulus";
import { DirectUploadController } from "@rails/activestorage/src/direct_upload_controller";
import { subscribe } from "helpers/subscribe";

export class FileUpload extends Controller {
  static targets = ["field", "dropZone", "preview", "button", "error"];

  public subscriptions: (() => void)[] = [];
  public file: File;
  public errors: string[] = [];

  fieldTarget: HTMLInputElement;
  dropZoneTarget: HTMLInputElement;
  previewTarget: HTMLImageElement;
  buttonTarget: HTMLInputElement;
  errorTarget: HTMLSpanElement;

  connect() {
    this.subscriptions.push(
      subscribe(this.fieldTarget, "change", this.handleFileChange.bind(this)),
      subscribe(this.dropZoneTarget, "drop", this.handleDrop.bind(this)),
      subscribe(this.dropZoneTarget, "dragover", this.handleDrop.bind(this)),
      subscribe(this.buttonTarget, "click", this.handleSubmit.bind(this)),
      subscribe(this.buttonTarget.form, "submit", this.handleSubmit.bind(this)),
      subscribe(
        this.previewTarget,
        "error",
        this.handlePreviewError.bind(this),
      ),
    );
  }

  disconnect() {
    this.subscriptions.forEach((unsubscribe) => unsubscribe());
  }

  handleFileChange(event: InputEvent) {
    const file = (event.target as HTMLInputElement).files[0];

    this.validate(file);
    this.previewImage(file);
  }

  handleDrop(event: DragEvent) {
    event.stopPropagation();
    event.preventDefault();

    const file = event.dataTransfer?.files[0];

    if (!file) {
      return;
    }

    this.validate(file);
    this.previewImage(file);
  }

  handleSubmit(event: Event) {
    event.stopPropagation();
    event.preventDefault();

    const controller = new DirectUploadController(this.fieldTarget, this.file);
    controller.start((error?: Error) => {
      if (error) {
        throw new Error("error while uploading file");
      } else {
        this.fieldTarget.form.submit();
      }
    });
  }

  handlePreviewError(message: string) {
    throw new Error(`error while loading image preview: ${message}`);
  }

  validate(file: File) {
    this.errors = [];
    const accepted = this.fieldTarget.accept.split(",");

    if (!accepted.includes(file.type)) {
      this.errors.push("This file type is not supported.");
    }

    if (file.size > 10485760) {
      this.errors.push("The image is too large (limit is 10MB).");
    }

    this.file = this.errors.length ? null : file;
    this.buttonTarget.disabled = Boolean(this.errors.length);
    this.renderError();
  }

  renderError() {
    if (this.errors.length) {
      this.errorTarget.hidden = false;
      this.errorTarget.textContent = this.errors[0];
    } else {
      this.errorTarget.hidden = true;
      this.errorTarget.textContent = "";
    }
  }

  previewImage(file: File) {
    const reader = new FileReader();

    reader.onload = (event) => {
      this.previewTarget.src = event.target.result.toString();
    };

    reader.onerror = () => {
      throw new Error("reader raised an error");
    };

    reader.readAsDataURL(file);
  }
}

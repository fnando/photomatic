import { DirectUploadController } from "@rails/activestorage/src/direct_upload_controller";

import { Base } from "controllers/Base";
import { i18n } from "config/i18n";
import { subscribe } from "helpers/subscribe";
import { render } from "helpers/render";

enum PreviewStatus {
  none = "none",
  ready = "ready",
  noPreview = "no-preview",
}

function hasNoPreview(status: PreviewStatus): boolean {
  return [PreviewStatus.none, PreviewStatus.noPreview].includes(status);
}

export class FileUpload extends Base {
  static targets = ["field", "dropZone", "button"];

  public subscriptions: (() => void)[] = [];
  public file: File;
  public errors: string[] = [];
  public previewStatus = PreviewStatus.none;

  fieldTarget: HTMLInputElement;
  dropZoneTarget: HTMLInputElement;
  buttonTarget: HTMLInputElement;

  connect() {
    this.subscriptions.push(
      subscribe(this.fieldTarget, "change", this.handleFileChange.bind(this)),
      subscribe(document.body, "drop", this.handleDrop.bind(this)),
      subscribe(document.body, "dragover", this.handleDrop.bind(this)),
      subscribe(document.body, "dragenter", this.handleDrag.bind(this)),
      subscribe(this.buttonTarget, "click", this.handleSubmit.bind(this)),
      subscribe(this.buttonTarget.form, "submit", this.handleSubmit.bind(this)),
    );

    this.render();
  }

  disconnect() {
    this.subscriptions.forEach((unsubscribe) => unsubscribe());
  }

  handleRemove(event: Event) {
    event.stopPropagation();
    event.preventDefault();

    this.file = null;
    this.previewStatus = PreviewStatus.none;
    this.render();
  }

  handleFileChange() {
    const file = this.fieldTarget.files[0];
    this.fieldTarget.value = "";

    this.validate(file);
  }

  handleDrag(event: DragEvent) {
    document.body.classList.add("dragging");
  }

  handleDrop(event: DragEvent) {
    event.stopPropagation();
    event.preventDefault();

    const file = event.dataTransfer?.files[0];

    if (!file) {
      return;
    }

    document.body.classList.remove("dragging");
    this.validate(file);
  }

  handleSubmit(event: Event) {
    event.stopPropagation();
    event.preventDefault();

    const controller = new DirectUploadController(this.fieldTarget, this.file);

    this.buttonTarget.disabled = true;

    controller.start((error?: Error) => {
      if (error) {
        this.errors = [i18n.t("js.posts.new.unable_to_upload_file")];
        this.render();
      } else {
        this.fieldTarget.form.submit();
      }
    });
  }

  validate(file: File) {
    this.errors = [];
    const accepted = this.fieldTarget.accept.split(",");

    if (!accepted.includes(file.type)) {
      this.errors.push(i18n.t("js.posts.new.unsupported_file_type"));
    }

    if (file.size > 10485760) {
      this.errors.push(i18n.t("js.posts.new.file_is_too_large"));
    }

    this.file = this.errors.length ? null : file;
    this.previewStatus = PreviewStatus.none;

    this.createPreviewImage();
    this.render();
  }

  render() {
    const [error] = this.errors;

    this.dropZoneTarget.innerHTML = render("fileUploadPreview", {
      error,
      file: this.file,
      previewStatus: this.previewStatus,
      hasNoPreview,
    });

    this.fieldTarget.disabled = Boolean(this.file);
    this.buttonTarget.disabled = Boolean(this.errors.length || !this.file);
  }

  createPreviewImage() {
    if (!this.file) {
      return;
    }

    const image = document.createElement("img");
    const reader = new FileReader();
    const subscriptions: (() => void)[] = [];

    const handleDone = () => {
      subscriptions.forEach((subscription) => subscription());
      this.render();
    };

    const handleReaderLoad = (event) => {
      image.src = event.target.result.toString();
    };

    const handleReaderError = () => {
      this.previewStatus = PreviewStatus.none;
      handleDone();
    };

    const handleImageLoad = () => {
      this.previewStatus = PreviewStatus.ready;
      handleDone();

      const target = this.element.querySelector<HTMLImageElement>("img");

      image.style.aspectRatio = `${image.width} / ${image.height}`;

      Array.from(target.attributes).forEach((attr) => {
        if (attr.name !== "src") {
          image.setAttribute(attr.name, attr.value);
        }
      });

      target.replaceWith(image);
    };

    const handleImageError = () => {
      this.previewStatus = PreviewStatus.noPreview;
      handleDone();
    };

    subscriptions.push(
      subscribe(reader, "load", handleReaderLoad),
      subscribe(reader, "error", handleReaderError),
      subscribe(image, "load", handleImageLoad),
      subscribe(image, "error", handleImageError),
    );

    reader.readAsDataURL(this.file);
  }
}

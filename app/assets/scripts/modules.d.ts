declare module "@rails/activestorage/src/direct_upload_controller" {
  export class DirectUploadController {
    constructor(input: HTMLInputElement, file: File);
    start(callback: (error?: Error) => void): void;
  }
}

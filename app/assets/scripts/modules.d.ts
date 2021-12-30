import "@rails/activestorage";

declare module "@rails/activestorage" {
  export interface DirectUploadInitializeEvent extends Event {
    detail: {
      file: File;
      id: number;
    };
  }
}

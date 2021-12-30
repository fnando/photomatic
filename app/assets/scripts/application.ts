import { I18n } from "i18n-js";
import * as ActiveStorage from "@rails/activestorage";

import translations from "translations.json";
import "controllers";

ActiveStorage.start();

// Fetch user locale from html#lang.
// This value is being set on `app/views/layouts/application.html.erb` and
// is inferred from `ACCEPT-LANGUAGE` header.
const userLocale = document.documentElement.lang;

const i18n = new I18n();
i18n.store(translations);
i18n.defaultLocale = "en";
i18n.enableFallback = true;
i18n.locale = userLocale;

addEventListener(
  "direct-upload:initialize",
  (event: ActiveStorage.DirectUploadInitializeEvent) => {
    const { detail } = event;

    document.querySelector<HTMLInputElement>("#photo_id").value = String(
      detail.id,
    );
  },
);

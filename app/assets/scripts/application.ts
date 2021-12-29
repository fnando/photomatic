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

function action(name: string): (event: any) => void {
  return (event) =>
    console.log(JSON.stringify({ name, event, detail: event.detail }, null, 2));
}

addEventListener("direct-upload:initialize", ({ detail }) => {
  document.querySelector("#photo_id").value = detail.id;
});
addEventListener("direct-upload:start", action("start"));
addEventListener("direct-upload:progress", action("progress"));
addEventListener("direct-upload:error", action("error"));
addEventListener("direct-upload:end", action("end"));

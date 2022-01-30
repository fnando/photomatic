/* eslint-disable */
// This file has been automatically generated.
// Don't edit it manually. Use `enroute export` instead.
// Last updated on 2022-01-30 03:48:54 UTC

import { zipObject } from "lodash";

function camelize(text: string): string {
  return text.replace(
    /_(.)/g,
    (_match, group) =>
      `${group[0].toUpperCase()}${group.substr(1, -1).toLowerCase()}`,
  );
}

function buildRoute(route: Route): RouteHandler {
  const incomingPattern = route.incomingPattern.replace("(.:format)", "");
  const outgoingPattern = route.outgoingPattern.replace("(.:format)", "");

  const handler = generate({
    ...route,
    segments: route.segments.map(camelize),
    requiredSegments: route.requiredSegments.map(camelize),
    pattern: incomingPattern,
  }) as RouteHandler;

  handler.pattern = incomingPattern;
  handler.incomingPattern = incomingPattern;
  handler.outgoingPattern = outgoingPattern;
  handler.underscore = generate({ ...route, pattern: outgoingPattern });

  return handler;
}

function generate(route: Route): RouteHelper {
  return (...args: PrimitiveType[]): string => {
    const { segments } = route;
    const pattern = route.pattern as string;
    const actualArgsSize = args.length;
    const requiredArgsSize = route.requiredSegments.length;
    const segmentsSize = segments.length;
    const params = zipObject(route.segments, args);

    if (actualArgsSize < requiredArgsSize) {
      throw new Error(
        `Expected ${requiredArgsSize} args; got ${actualArgsSize}`,
      );
    }

    if (actualArgsSize > segmentsSize) {
      throw new Error(
        `Expected no more than ${segmentsSize} args; got ${actualArgsSize}`,
      );
    }

    if (segmentsSize === 0) {
      return pattern;
    }

    const ext = params.format ? `.${params.format}` : "";
    const url = `${pattern}${ext}`;

    return segments.reduce((buffer: string, segment: string) => {
      const param = String(params[segment]);
      const encodedParam = encodeURIComponent(param);

      const optionalSegmentRegex = new RegExp(`\\(\\/:${segment}\\)`);
      const requiredSegmentRegex = new RegExp(`\\(?:${segment}\\)?`);

      if (buffer.match(optionalSegmentRegex)) {
        const replacement = params[segment] ? `/${encodedParam}` : "";
        return buffer.replace(optionalSegmentRegex, replacement);
      }

      const rejectParam =
        param === "undefined" ||
        param === "null" ||
        param.trim() === "";

      if (route.requiredSegments.includes(segment) && rejectParam) {
        const serializedParam = JSON.stringify(params[segment]);

        throw new Error(
          `${segment} is required, but received ${serializedParam}.`
        );
      }

      return buffer.replace(requiredSegmentRegex, encodedParam);
    }, url);
  };
}

type PrimitiveType = number | string | null | undefined | boolean;

export interface Route {
  name: string;
  pattern?: string;
  method: string[];
  segments: string[];
  requiredSegments: string[];
  incomingPattern: string;
  outgoingPattern: string;
}

export type RouteHelper = (...args: PrimitiveType[]) => string;

export type RouteHandler = RouteHelper & {
  pattern: string;
  incomingPattern: string;
  outgoingPattern: string;
  underscore: RouteHelper;
};

const rootHandler = buildRoute({
  "name": "root",
  "incomingPattern": "/",
  "outgoingPattern": "/",
  "method": [
    "get",
    "",
    "post",
    "delete",
    "put"
  ],
  "segments": [

  ],
  "requiredSegments": [

  ]
});

const homeHandler = buildRoute({
  "name": "home",
  "incomingPattern": "/home(.:format)",
  "outgoingPattern": "/home(.:format)",
  "method": [
    "get",
    "",
    "post",
    "delete",
    "put"
  ],
  "segments": [
    "format"
  ],
  "requiredSegments": [

  ]
});

const loginHandler = buildRoute({
  "name": "login",
  "incomingPattern": "/login",
  "outgoingPattern": "/login",
  "method": [
    "get",
    "",
    "post",
    "delete",
    "put"
  ],
  "segments": [

  ],
  "requiredSegments": [

  ]
});

const checkInboxHandler = buildRoute({
  "name": "checkInbox",
  "incomingPattern": "/login/check-inbox",
  "outgoingPattern": "/login/check-inbox",
  "method": [
    "get",
    "",
    "post",
    "delete",
    "put"
  ],
  "segments": [

  ],
  "requiredSegments": [

  ]
});

const verifyEmailHandler = buildRoute({
  "name": "verifyEmail",
  "incomingPattern": "/login/verify-email",
  "outgoingPattern": "/login/verify-email",
  "method": [
    "get",
    "",
    "post",
    "delete",
    "put"
  ],
  "segments": [

  ],
  "requiredSegments": [

  ]
});

const logoutHandler = buildRoute({
  "name": "logout",
  "incomingPattern": "/logout(.:format)",
  "outgoingPattern": "/logout(.:format)",
  "method": [
    "get",
    "",
    "post",
    "delete",
    "put"
  ],
  "segments": [
    "format"
  ],
  "requiredSegments": [

  ]
});

const profileHandler = buildRoute({
  "name": "profile",
  "incomingPattern": "/u/:username(.:format)",
  "outgoingPattern": "/u/:username(.:format)",
  "method": [
    "get",
    "",
    "post",
    "delete",
    "put"
  ],
  "segments": [
    "username",
    "format"
  ],
  "requiredSegments": [
    "username"
  ]
});

const newPostHandler = buildRoute({
  "name": "newPost",
  "incomingPattern": "/posts/new",
  "outgoingPattern": "/posts/new",
  "method": [
    "get",
    "",
    "post",
    "delete",
    "put"
  ],
  "segments": [

  ],
  "requiredSegments": [

  ]
});

const editPostHandler = buildRoute({
  "name": "editPost",
  "incomingPattern": "/posts/:id/edit",
  "outgoingPattern": "/posts/:id/edit",
  "method": [
    "get",
    "",
    "post",
    "delete",
    "put"
  ],
  "segments": [
    "id"
  ],
  "requiredSegments": [
    "id"
  ]
});

const postHandler = buildRoute({
  "name": "post",
  "incomingPattern": "/posts/:id",
  "outgoingPattern": "/posts/:id",
  "method": [
    "get",
    "",
    "post",
    "delete",
    "put"
  ],
  "segments": [
    "id"
  ],
  "requiredSegments": [
    "id"
  ]
});

const likePostHandler = buildRoute({
  "name": "likePost",
  "incomingPattern": "/posts/:id/like(.:format)",
  "outgoingPattern": "/posts/:id/like(.:format)",
  "method": [
    "get",
    "",
    "post",
    "delete",
    "put"
  ],
  "segments": [
    "id",
    "format"
  ],
  "requiredSegments": [
    "id"
  ]
});

const turboRecedeHistoricalLocationHandler = buildRoute({
  "name": "turboRecedeHistoricalLocation",
  "incomingPattern": "/recedeHistoricalLocation(.:format)",
  "outgoingPattern": "/recede_historical_location(.:format)",
  "method": [
    "get",
    "",
    "post",
    "delete",
    "put"
  ],
  "segments": [
    "format"
  ],
  "requiredSegments": [

  ]
});

const turboResumeHistoricalLocationHandler = buildRoute({
  "name": "turboResumeHistoricalLocation",
  "incomingPattern": "/resumeHistoricalLocation(.:format)",
  "outgoingPattern": "/resume_historical_location(.:format)",
  "method": [
    "get",
    "",
    "post",
    "delete",
    "put"
  ],
  "segments": [
    "format"
  ],
  "requiredSegments": [

  ]
});

const turboRefreshHistoricalLocationHandler = buildRoute({
  "name": "turboRefreshHistoricalLocation",
  "incomingPattern": "/refreshHistoricalLocation(.:format)",
  "outgoingPattern": "/refresh_historical_location(.:format)",
  "method": [
    "get",
    "",
    "post",
    "delete",
    "put"
  ],
  "segments": [
    "format"
  ],
  "requiredSegments": [

  ]
});

export const rootUrl = (): string =>
  rootHandler();

export const homeUrl = (format?: any): string =>
  homeHandler(format);

export const loginUrl = (): string =>
  loginHandler();

export const checkInboxUrl = (): string =>
  checkInboxHandler();

export const verifyEmailUrl = (): string =>
  verifyEmailHandler();

export const logoutUrl = (format?: any): string =>
  logoutHandler(format);

export const profileUrl = (username: any, format?: any): string =>
  profileHandler(username, format);

export const newPostUrl = (): string =>
  newPostHandler();

export const editPostUrl = (id: any): string =>
  editPostHandler(id);

export const postUrl = (id: any): string =>
  postHandler(id);

export const likePostUrl = (id: any, format?: any): string =>
  likePostHandler(id, format);

export const turboRecedeHistoricalLocationUrl = (format?: any): string =>
  turboRecedeHistoricalLocationHandler(format);

export const turboResumeHistoricalLocationUrl = (format?: any): string =>
  turboResumeHistoricalLocationHandler(format);

export const turboRefreshHistoricalLocationUrl = (format?: any): string =>
  turboRefreshHistoricalLocationHandler(format);

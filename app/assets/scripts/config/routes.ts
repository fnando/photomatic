/* eslint-disable */
// This file has been automatically generated.
// Don't edit it manually. Use `enroute export` instead.

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

const likePostHandler = buildRoute({
  "name": "likePost",
  "incomingPattern": "/posts/:postId/like",
  "outgoingPattern": "/posts/:post_id/like",
  "method": [
    "get",
    "",
    "post",
    "delete",
    "put"
  ],
  "segments": [
    "post_id"
  ],
  "requiredSegments": [
    "post_id"
  ]
});

const postCommentsHandler = buildRoute({
  "name": "postComments",
  "incomingPattern": "/posts/:postId/comments",
  "outgoingPattern": "/posts/:post_id/comments",
  "method": [
    "get",
    "",
    "post",
    "delete",
    "put"
  ],
  "segments": [
    "post_id"
  ],
  "requiredSegments": [
    "post_id"
  ]
});

export const likePostUrl = (postId: any): string =>
  likePostHandler(postId);

export const postCommentsUrl = (postId: any): string =>
  postCommentsHandler(postId);

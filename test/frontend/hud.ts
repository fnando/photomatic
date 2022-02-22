import * as http from "http";
import * as queryString from "querystring";
import { Reporter, Context } from "@jest/reporters";
import { AggregatedResult } from "@jest/test-result";

const noop = () => {
  // noop
};

const pluralize = (count: number, one: string, many: string): string => {
  if (count === 0) {
    return `No ${many}`;
  }

  if (count === 1) {
    return `1 ${one}`;
  }

  return `${count} ${many}`;
};

export default class HudReporter implements Pick<Reporter, "onRunComplete"> {
  onRunComplete(_: Set<Context>, results: AggregatedResult) {
    const testsCount = results.numTotalTests;
    const failedCount = results.numFailedTests;
    const passedCount = results.numPassedTests;
    const pendingCount = results.numPassedTests;
    const messages: string[] = [];
    let title = "Passed!";
    let symbolName = "checkmark.circle.trianglebadge.exclamationmark";

    if (testsCount === 0) {
      messages.push("No tests has been found!");
    }

    if (testsCount) {
      messages.push(pluralize(testsCount, "test", "tests"));
    }

    if (passedCount) {
      title = "Passed!";
      symbolName = "checkmark.circle";
      messages.push(`${passedCount} passed`);
    }

    if (failedCount) {
      title = "Failed!";
      symbolName = "exclamationmark.triangle";
      messages.push(`${failedCount} failed`);
    }

    if (pendingCount) {
      messages.push(`${pendingCount} pending`);
    }

    const request = http.request(
      {
        hostname: "127.0.0.1",
        port: 32323,
        path: "/hud",
        method: "post",
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
      },
      noop,
    );

    request.on("error", noop);

    request.write(
      queryString.stringify({
        title,
        symbolName,
        message: messages.join(", "),
      }),
    );

    request.end();

    return Promise.resolve();
  }
}

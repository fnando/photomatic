"use strict";
exports.__esModule = true;
var http = require("http");
var queryString = require("querystring");
var noop = function () {
    // noop
};
var pluralize = function (count, one, many) {
    if (count === 0) {
        return "No ".concat(many);
    }
    if (count === 1) {
        return "1 ".concat(one);
    }
    return "".concat(count, " ").concat(many);
};
var HudReporter = /** @class */ (function () {
    function HudReporter() {
    }
    HudReporter.prototype.onRunComplete = function (_, results) {
        var testsCount = results.numTotalTests;
        var failedCount = results.numFailedTests;
        var passedCount = results.numPassedTests;
        var pendingCount = results.numPassedTests;
        var messages = [];
        var title = "Passed!";
        var symbolName = "checkmark.circle.trianglebadge.exclamationmark";
        if (testsCount === 0) {
            messages.push("No tests has been found!");
        }
        if (testsCount) {
            messages.push(pluralize(testsCount, "test", "tests"));
        }
        if (passedCount) {
            title = "Passed!";
            symbolName = "checkmark.circle";
            messages.push("".concat(passedCount, " passed"));
        }
        if (failedCount) {
            title = "Failed!";
            symbolName = "exclamationmark.triangle";
            messages.push("".concat(failedCount, " failed"));
        }
        if (pendingCount) {
            messages.push("".concat(pendingCount, " pending"));
        }
        var request = http.request({
            hostname: "127.0.0.1",
            port: 32323,
            path: "/hud",
            method: "post",
            headers: {
                "Content-Type": "application/x-www-form-urlencoded"
            }
        }, noop);
        request.on("error", noop);
        request.write(queryString.stringify({
            title: title,
            symbolName: symbolName,
            message: messages.join(", ")
        }));
        request.end();
        return Promise.resolve();
    };
    return HudReporter;
}());
exports["default"] = HudReporter;

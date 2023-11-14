import fs from "node:fs";
import path from "node:path";
import { prefixEveryLineWith } from "./utils.js";

export const logFilePath = path.join(
  path.dirname(new URL(import.meta.url).pathname),
  "chatter.log"
);

export const logStream = fs.createWriteStream(logFilePath, { flags: "a" });

export function debug(value) {
    logStream.write(prefixEveryLineWith(" ", value) + "\n");
}
debug.stdin = (value) =>
  logStream.write(prefixEveryLineWith("+", value) + "\n");
debug.stdout = (value) =>
  logStream.write(prefixEveryLineWith("-", value) + "\n");
debug.stderr = (value) =>
  logStream.write(prefixEveryLineWith("-!", value) + "\n");

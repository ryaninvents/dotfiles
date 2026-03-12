import { stdout } from "node:process";

export const ESC = 0x1b;
export const ST = 0x07;
export const OSC = [String.fromCharCode(ESC), "]"];
export const CSI = [ESC, "["];

export function print(...args) {
  for (const elem of args) {
    if (typeof elem === "string") {
      stdout.write(elem);
      continue;
    }
    if (typeof elem === "number") {
      stdout.write(String.fromCharCode(elem));
      continue;
    }
    if (Array.isArray(elem)) {
      print(...elem);
      continue;
    }
  }
}

export const LEET = [OSC, "1337;"];

export function setColor(key, value) {
  print(LEET, `SetColors=${key}=${value}`, String.fromCharCode(ST));
}

export function setBadge(badge) {
  const base64Badge = Buffer.from(badge).toString("base64");
  print(LEET, `SetBadgeFormat=${base64Badge}`, ST);
}

async function main() {
  const [mode] = process.argv.slice(2);
  switch (mode) {
    case undefined:
      setColor("bg", "fff");
      setBadge("");
      break;
    case "test":
      setColor("bg", "e8f5e6");
      setBadge("🧪");
      break;
    case "e2e":
      setColor("bg", "e8f5e6");
      setBadge("🎭");
      break;
    case "run":
      setColor("bg", "f5e8e6");
      setBadge("🏃‍♂️‍➡️");
      break;
    case "play":
      setColor("bg", "e6e8f5");
      setBadge("▶️");
      break;
    case "build":
      setColor("bg", "eeeeee");
      setBadge("🛠️");
      break;
  }
}

if (import.meta.url === `file://${process.argv[1]}`) {
  main();
}

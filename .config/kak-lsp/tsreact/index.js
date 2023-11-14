import { spawn } from "node:child_process";
import { chunksOf, withContentLength } from "./yieldstream.js";

// -----
// Setup
// -----

const server = spawn(
  "/Users/ryan/Library/pnpm/typescript-language-server",
  process.argv.slice(2)
);
process.stdin.setEncoding("utf8");

// ------
// Piping
// ------

// process.stdin.pipe(server.stdin);
// server.stdout.pipe(process.stdout);
// server.stderr.pipe(process.stderr);

async function handleStdin() {
  for await (const rpcCall of withContentLength(chunksOf(process.stdin))) {
    const json = JSON.parse(rpcCall);
    if (
      json.method === "textDocument/didOpen" &&
      json.params &&
      json.params.textDocument &&
      json.params.textDocument.languageId === "typescript" &&
      json.params.textDocument.uri.endsWith("tsx")
    ) {
      json.params.textDocument.languageId = "typescriptreact";
    }
    const nextRpc = JSON.stringify(json);
    server.stdin.write(`Content-Length: ${nextRpc.length}\r\n\r\n${nextRpc}`);
  }
}

async function handleStdout() {
  for await (const chunk of chunksOf(server.stdout)) {
    process.stdout.write(chunk);
  }
}

async function handleStderr() {
  for await (const chunk of chunksOf(server.stderr)) {
    process.stderr.write(chunk);
  }
}

await Promise.all([handleStdin(), handleStdout(), handleStderr()]);

// ------
// Events
// ------

server.on("exit", (code) => {
  process.exit(code);
});

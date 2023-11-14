import { spawn } from "node:child_process";
import { chunksOf } from "./yieldstream.js";
import { debug } from "./logging.js";

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

debug("server starting");
debug(JSON.stringify(process.argv));



function handleStdinEnd() {
  debug(`+stdin EOF ${new Date().toISOString()}\n`);
  server.stdin.end();
}

async function handleStdin() {
  for await (const chunk of chunksOf(process.stdin, handleStdinEnd)) {
    debug.stdin(chunk);
    server.stdin.write(chunk);
  }
  debug(`-----Exited for loop somehow???-------\n`);
}

async function handleStdout() {
  for await (const chunk of chunksOf(server.stdout)) {
    debug.stdout(chunk);
    process.stdout.write(chunk);
  }
}

async function handleStderr() {
  for await (const chunk of chunksOf(server.stderr)) {
    debug.stderr(chunk);
    process.stderr.write(chunk);
  }
}

await Promise.all([handleStdin(), handleStdout(), handleStderr()]);

// ------
// Events
// ------

server.on("exit", (code) => {
  debug(
    `>>>Server exited with code ${code} at ${new Date().toISOString()}\n`
  );
  process.exit(code);
});

debug(`\n starting server at ${new Date().toISOString()}
 process.cwd(): ${process.cwd()}\n`);

process.on("exit", () => {
  debug(`>>>main process exit at ${new Date().toISOString()}\n`);
  debug(String(new Error().stack));
});

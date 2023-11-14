export function chunksOf(stdin, {onEnd} = {}) {
  let isDone = false;
  stdin.on("end", () => {
    isDone = true;
    if (onEnd) {
        onEnd();
    }
  });
  return {
    [Symbol.asyncIterator]() {
      return this;
    },
    async next() {
      if (isDone) {
        return { isDone };
      }
      const chunk = await new Promise((resolve) => {
        stdin.once("data", (chunk) => {
          resolve(String(chunk));
        });
      });
      return {
        value: chunk,
        done: isDone,
      };
    },
    async return() {
      return {
        done: true,
      };
    },
  };
}


/**
 * Expects an iterator of the format `Content-Length: 123\n\n<content>`.
 * Emits the content as a string.
 */
export async function *withContentLength(asyncIterator) {
  let remaining = "";
  for await (const chunk of asyncIterator) {
    remaining += chunk;
    while (true) {
      const match = /^Content-Length: (\d+)\r?\n\r?\n/.exec(remaining);
      if (!match) {
        break;
      }
      const contentLength = Number(match[1]);
      const contentStart = match[0].length;
      const contentEnd = contentStart + contentLength;
      const content = remaining.slice(contentStart, contentEnd);
      remaining = remaining.slice(contentEnd);
      yield content;
    }
  }
}
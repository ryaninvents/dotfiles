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
          resolve(chunk);
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

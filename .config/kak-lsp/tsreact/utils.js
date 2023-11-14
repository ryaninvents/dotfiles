
export function prefixEveryLineWith(prefix, data) {
  return String(data)
    .split("\n")
    .map((line) => prefix + line)
    .join("\n");
}

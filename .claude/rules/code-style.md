# Code Style

## Paradigm

Prefer a functional style. Use classes only where a framework requires it (e.g. extending a base class).

Favor **factory functions** for dependency injection: define each part of the application as a factory that accepts its dependencies as arguments. This makes isolated unit testing and integration testing with clear mock boundaries straightforward.

## Module System

- Avoid `default` exports except where required by a framework.
- Use named exports.
- Each directory exposes a public API via an `index.ts` that re-exports selectively:
  ```ts
  export * from './someModule';
  ```
- Anything not exported from `index.ts` is considered private to that directory. Do not import private files from outside the directory.

## File & Function Size

- Keep source code files to ~300 lines. Markdown and other human-readable files are not subject to this rule.
- Keep functions short and focused.
- Only extract a helper when you have a genuinely good name for it — don't split for splitting's sake.

## Complexity & Decoupling

- Build behavior by composing small building blocks, not by threading configuration objects through layers and branching deep in the call stack.
- Keep code paths as decoupled as possible.
- The **Strategy pattern** is the preferred approach for varying behavior.
- If a particular composition is reused, "package" it — and optionally expose a configuration option at that level rather than pushing it deeper.

## TypeScript

- Never use `any` to paper over type issues. Use generics instead.
- Generic type parameter names should be lower-camel-case and descriptive:
  ```ts
  // Bad
  type Transform<T, U> = (input: T) => U;

  // Good
  type Transform<inputType, outputType> = (input: inputType) => outputType;
  ```
- Prefer `Array<ElementType>` over `ElementType[]` on personal projects. Defer to the project's existing convention on shared codebases.
- Avoid `I`-prefixes on interfaces. Invest in finding a good name instead.

## Naming Conventions

- Name files after their most prominent export, using `camelCase` or `PascalCase` as appropriate for that export.
- Use `kebab-case` for directory names.
- No `I`-prefix for interfaces or other type-level constructs.

## React State

- Avoid multiple `setState` calls for related state. Prefer a single state object managed by a reducer.
- Use simple `useState` only when the state is genuinely simple and independent.
- This keeps state transitions deterministic and testable.

## Async

- Prefer `async/await` over `.then()` chains.

## Testing

- Co-locate unit tests with source files (Vitest/Jest).
- Place end-to-end tests in a top-level `e2e/` (or similarly named) directory.
- Keep `describe`/`it` nesting shallow.
- Use small, reusable, composable test utilities for repeated setup rather than deeply nested `beforeEach` hooks.
- Test utilities should still be clear and readable in isolation.

## Comments

- Comments must explain **why** code exists — the requirement, constraint, or non-obvious reason behind a decision.
- Never comment on **what** code does. The code itself should be self-evident from its structure and naming.
- Good comments reflect the requirements context in which the code was written.

```ts
// Bad: describes what the code does
// Multiply rate by hours to get total
const total = rate * hours;

// Good: explains why a non-obvious decision was made
// Rates are stored in cents to avoid floating-point rounding errors in billing
const total = rate * hours;
```

## Error Handling

- Subclass `Error` for domain-specific error types. Use **factory functions** to create error instances (consistent with the DI/factory pattern).
- Catch at layer boundaries (controller, app) — not deep in the call stack.
- Never silently swallow errors.

```ts
class NotFoundError extends Error {
  readonly code = 'NOT_FOUND' as const;
  constructor(resource: string, id: string) {
    super(`${resource} ${id} not found`);
    this.name = 'NotFoundError';
  }
}

const createNotFoundError = (resource: string, id: string) =>
  new NotFoundError(resource, id);
```

## Immutability

- Prefer `Readonly<>`, `ReadonlyArray<>`, and `as const` for data that shouldn't change after creation.
- Don't mutate function arguments — return new objects/arrays instead.
- Use spread/destructuring or `structuredClone` over in-place mutation.

## Discriminated Unions over Optional Fields

- Model mutually exclusive states as discriminated unions, not bags of optional fields.
- Makes impossible states unrepresentable at the type level.

```ts
// Avoid
type Request = {
  status: 'pending' | 'fulfilled' | 'rejected';
  data?: ResponseData;
  error?: Error;
};

// Prefer
type Request =
  | { status: 'pending' }
  | { status: 'fulfilled'; data: ResponseData }
  | { status: 'rejected'; error: Error };
```

## Exhaustive Switch

- When switching on a discriminated union, include a `default: assertNever(x)` case.
- Produces a compile error when a new variant is added but not handled.

```ts
const assertNever = (x: never): never => {
  throw new Error(`Unexpected value: ${x}`);
};
```

## Barrel Imports & Path Aliases

- Use TypeScript path aliases (`@app/*`, `@domain/*`, etc.) mapped to layer boundaries.
- Import from the barrel (`@domain`) not from internal files (`@domain/user/validation`).
- Reinforces the `index.ts`-as-public-API convention above.

## Prefer `satisfies` over Type Annotations for Literals

- Use `satisfies` to validate a value matches a type while preserving the narrower literal type.
- Aligns with the "infer types from concrete providers" pattern.

```ts
const config = {
  retries: 3,
  timeout: 5000,
} satisfies Config;
// typeof config.retries is 3, not number
```

## Early Returns

- Prefer guard clauses and early returns over nested `if/else`.
- Keep nesting to ~2-3 levels max within a function.

## React Dependency Arrays

- Never suppress ESLint `react-hooks/exhaustive-deps` warnings. Restructure the code instead.
- Suppressing dep warnings is the React equivalent of using `any`.

## `Map`/`Set` for Dynamic Keys

- Use `Map<K, V>` / `Set<V>` when keys are runtime-dynamic.
- Plain objects are fine for static, known-key structures.

## Formatting & Linting

- Always use the project's built-in lint/format command to apply fixes. Do not fix lint issues manually unless the tooling cannot handle them.
- Formatting bikeshedding (tabs vs. spaces, quote style, etc.) is explicitly out of scope — just keep it consistent and automatically enforced.
- Default to Prettier with an empty `.prettierrc` for new projects.

# Architecture

> **Project-specific rules always override these personal defaults.**

## Layered Architecture

Projects are organized into layers, typically living in a `packages/`, `libs/`, or `layers/` directory. For large projects each layer is its own workspace package; for small projects they may be folders within a single package.

### Layers

| Layer | Purpose |
|---|---|
| **types** | Shared types and Zod schemas. Any layer may import from `types` without restriction. |
| **util** | Shared utilities (string helpers, date formatting, etc.). Same import rules as `infra`. |
| **infra** | Adapters over external dependencies (adapter pattern, only when needed). Also houses cross-cutting concerns: logging, error handling, observability, and a single strongly-typed environment-variable utility (all env access goes through this utility unless a framework constraint prevents it). |
| **data** | Data storage abstractions (database, S3, IndexedDB, etc.). |
| **domain** | Business logic and auth. Validates its own inputs — do not assume the controller has already validated. Domain errors are thrown (not returned as result types). |
| **presentation** | Pure presentational components that are a strict function of their inputs. Typically React components backed by Storybook, but applicable server-side when heavy reuse justifies it. |
| **controller** | Adapts a framework (Hono, Express, React, Vue, etc.) to the domain layer. In React, this means hooks and container components that call domain logic and pass props to presentation components. |

### Apps Directory

A separate `apps/` directory contains one or more packages that wire everything together:
- Instantiate dependencies for the target deploy environment.
- Expose the controller layer to the framework.
- This is composition only — no business logic lives here.

## Dependency Flow

Strict directional dependency rules. Violations should be flagged in code review and documented in the project's `CLAUDE.md`/`AGENTS.md`.

```
types ← (any layer, no restrictions)
util  ← data, domain, controller, app
infra ← data, domain, controller, app

data → domain → controller → app
                                ↑
presentation ← controller, app
```

- **Domain never imports from controller, presentation, or app.**
- **Data never imports from domain, controller, presentation, or app.**
- **Layers do not skip levels** in the core flow: controller does not import directly from data.
- `infra`, `util`, and `types` are "horizontal" — available where needed without violating the vertical flow.
- Circular dependencies are prevented by convention. Add enforcement notes to each project's `CLAUDE.md`/`AGENTS.md` so agents flag violations.

## Dependency Inversion

Layers depend on abstractions, but **types are inferred from the concrete provider** rather than hand-maintained interface files:

```ts
// data layer provides the implementation
export const createUserRepo = (db: Database) => ({
  findById: async (id: string) => { /* ... */ },
});

// domain layer infers the type from the provider
type UserRepo = ReturnType<typeof createUserRepo>;

export const createUserService = (repo: UserRepo) => ({
  /* ... */
});
```

This pairs with the factory-function DI pattern from `code-style.md` — each layer is a factory accepting its dependencies as arguments. Composition happens in `apps/`.

## Layer Communication

Layers communicate via **plain function calls** wired through factory-function composition. No event bus or pub-sub unless a project explicitly adopts one.

## Validation

- **Controller**: parses and validates external input (HTTP bodies, query params, form data) via Zod schemas from `types`.
- **Domain**: independently validates business invariants. Do not rely solely on controller validation.

## Monorepo Tooling

Default stack: **pnpm workspaces** with **Turborepo** layered on top. Scale the package structure to the project's complexity.

## Module Hygiene

- **Single responsibility per file.** Each file exports one cohesive unit (a factory, a set of related types, a utility). If a file serves two distinct concerns, split it.
- **No cross-layer barrel re-exports.** A layer's `index.ts` only re-exports its own modules — never from a dependency layer. Consumers import each layer explicitly to prevent transitive dependency leaks.
- **No ambient state.** No module-level mutable singletons. All state flows through function arguments or framework-sanctioned state management (React context, store).

## Domain Purity

The domain layer must have **zero imports from any framework** (React, Hono, Express, Vue) or runtime-specific API (DOM, Node `fs`, Deno). If domain needs an external capability (e.g., file storage), it accepts it as a dependency via factory injection.

## Composition Root

Each app has a single file (e.g., `composition.ts` or `root.ts`) where all factory functions are called and wired together. No dependency instantiation happens outside this file. This makes the full dependency graph scannable in one place. Defer to framework-specific conventions when they conflict (e.g., Next.js layout nesting).

## Collocated Contracts

Zod schemas in `types` are the **single source of truth** for validation and type derivation (`z.infer<>`). Never duplicate a shape as both a Zod schema and a hand-written interface.

## Error Boundaries by Layer

Each layer catches and translates errors from the layer below into its own vocabulary:
- Controller catches domain errors → maps to HTTP status codes or UI error states.
- Domain catches data errors → maps to domain-level failures.
- Raw infrastructure errors never leak to the consumer.

## One-Way Data Mapping

Each layer boundary has explicit mapper functions to transform data shapes. A database row becomes a domain entity becomes a response DTO. Layers never pass their internal types across boundaries — they map to the shape the consumer expects.

## Feature Slicing

When the domain layer grows beyond ~10 modules, organize by feature/subdomain (e.g., `domain/billing/`, `domain/auth/`) rather than by technical role. Each subdomain follows the same index-as-API convention. Cross-subdomain calls go through the public index only.

## Testing by Layer

| Scope | Location | Runner | Dependencies |
|---|---|---|---|
| **Unit tests** | Co-located with source files | Vitest / Jest | Mock dependencies via factory injection |
| **Integration tests** | Highest layer under test (typically `controller`) | Vitest / Jest | May compose real sub-units; mock at the outermost boundary |
| **E2E tests** | `apps/` package (or top-level `e2e/` directory) | Playwright / Cypress | Run against a live instance of the app — no mocks |

### Test Data

Prefer composable factory functions for test data over static JSON fixtures:

```ts
const user = createTestUser({ role: 'admin' });
```

This pairs with the composable test utilities rule in `code-style.md`.

---
description: Save contextual knowledge from the current conversation to the appropriate memory file
argument-hint: [optional: brief description of what to save, or leave blank to infer from context]
---

# /learn

**Input**: $ARGUMENTS (optional — if blank, infer from recent conversation context)

## Objective

Persist a lesson, preference, or piece of context learned during this conversation to the long-term memory system at `~/.claude/MEMORY.md` and `~/.claude/memory/`, so it is available in future conversations.

---

## Step 1: Identify What Was Learned

If `$ARGUMENTS` is provided, use it as the subject of the memory. Otherwise, look at the most recent correction, confirmation, or piece of new context in the conversation — the thing that prompted the `/learn` call.

Extract:
- **The core fact or rule** — what is true, or what should be done differently
- **Why** — the reason, constraint, or incident behind it (if available)
- **How to apply** — when this guidance should kick in

---

## Step 2: Classify the Memory

Choose the most appropriate type:

| Type | Use when |
|------|----------|
| `user` | Describes the user's role, skills, background, or working style |
| `feedback` | Corrects or confirms an approach — how Claude should behave |
| `project` | Ongoing work, decisions, goals, deadlines for the current project |
| `reference` | Points to where information lives in an external system |

Do **not** save:
- Code patterns derivable from reading the codebase
- Git history or recent changes
- Ephemeral task state or in-progress work
- Anything already in a `CLAUDE.md` file

---

## Step 3: Check for Project Scope

If the lesson is specific to the current project (not a general user preference or behavior rule):
- **Stop and ask** the user whether they'd like it saved to memory or encoded in the project's `.claude/` files instead.
- Do not proceed until they confirm.

---

## Step 4: Check for Existing Memory

Read `~/.claude/MEMORY.md` and scan for an existing entry on the same topic.

- **If one exists**: Read that file and update it in place rather than creating a duplicate.
- **If none exists**: Create a new file in `~/.claude/memory/` named after the topic in `kebab-case.md`.

---

## Step 5: Write the Memory File

Use this frontmatter format:

```markdown
---
name: {Concise title}
description: {One-line description — specific enough to judge relevance in future conversations}
type: {user | feedback | project | reference}
---

{Memory content}
```

For `feedback` and `project` types, structure the body as:

```
{The rule or fact — lead with this}

**Why:** {The reason, constraint, or past incident}

**How to apply:** {When/where this guidance should activate}
```

For `user` and `reference` types, use clear prose or a short list.

---

## Step 6: Update MEMORY.md

`MEMORY.md` is loaded frequently and must stay lean. It is a **sparse index** — one line per memory file, nothing more. All detail belongs in the memory file itself.

Read `~/.claude/MEMORY.md` and add or update the entry for this memory.

Rules:
- One line per entry, under 150 characters total
- Format: `- [Title](memory/filename.md) — one-line hook: when to apply this memory`
- The hook should name the *trigger* (when to reach for this file), not summarize its contents
- No inline detail, no multi-line entries, no prose — if it needs more than one line, it belongs in the memory file
- Keep the file under 200 lines total

---

## Step 7: Confirm

Output a single short line confirming what was saved and where. Example:

```
Saved feedback memory → memory/terse-responses.md: no trailing post-implementation summaries
```

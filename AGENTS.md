# Repository Guidelines

## Project Structure & Module Organization

- `src/resume.tex` is the main LaTeX entry point.
- `src/sections/` contains section content (`summary.tex`, `experience.tex`, `projects.tex`, `skills.tex`, etc.).
- `src/awesome-cv.cls` and `src/fonts/` provide the theme and font assets.
- Build artifacts (PDF output) are written to the repo root as `resume.pdf` when you run the build.

## Build, Test, and Development Commands

- `npm run format` applies Prettier formatting to supported files.
- `npm run format:check` verifies formatting without writing changes.
- `make test` runs Prettier checks; set `RUN_SUPER_LINTER=1` to run super-linter via Docker.
- `make build` compiles the LaTeX sources via `latexmk` (local) or a Docker fallback and writes `resume.pdf` to the repo root.
- `make all` runs both test and build targets.

Prereqs: `git >= 2`, plus either TeX Live with `latexmk` or Docker (`>= 18.09`). For local formatting, install Node.js `>= 16` and run `npm install`.

## Coding Style & Naming Conventions

- Indentation: 2 spaces, LF line endings, final newline required (see `.editorconfig`).
- Formatting: Prettier enforces `singleQuote`, `trailingComma: all`, and `printWidth: 120` for supported files.
- Naming: keep section files in `src/sections/` with lowercase, descriptive names (e.g., `experience.tex`).
- LaTeX: prefer consistent macro usage and keep edits localized to the relevant section file.

## Testing Guidelines

- No unit test framework is configured; tests are lint/format checks.
- Run `make test` before opening a PR; it validates Prettier rules (and optionally super-linter).

## Commit & Pull Request Guidelines

- Commit messages follow Conventional Commits (examples in `git log`):
  - `feat(contents): update job title`
  - `docs: update README`
  - `release: 2.1.0 [skip ci]`
- Keep commits scoped and descriptive; use an optional scope when it helps (`contents`, `readme`, `build`).
- PRs should include: a short summary, the updated section(s), and the commands you ran (`npm run format:check`, `make test`, `make build`). Attach a PDF preview if content/layout changed.

## Configuration & CI Notes

- CI uses super-linter and semantic-release; keep `CHANGELOG.md` and release commits aligned with Conventional Commits.
- Avoid adding local-only files to the repo root other than the expected `resume.pdf` build output.

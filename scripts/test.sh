#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

run_prettier() {
  local glob_pattern="${PRETTIER_GLOB:-**/*.{yaml,yml,json,md}}"
  local prettier_bin=""

  if [[ -n "${PRETTIER_BIN:-}" ]]; then
    prettier_bin="$PRETTIER_BIN"
  elif [[ -x "$ROOT_DIR/node_modules/.bin/prettier" ]]; then
    prettier_bin="$ROOT_DIR/node_modules/.bin/prettier"
  elif command -v prettier >/dev/null 2>&1; then
    prettier_bin="prettier"
  elif command -v npx >/dev/null 2>&1; then
    npx --yes prettier@3.8.1 --check "$glob_pattern"
    return
  fi

  if [[ -n "$prettier_bin" ]]; then
    "$prettier_bin" --check "$glob_pattern"
    return
  fi

  echo "Prettier not found. Install with 'npm install' or set PRETTIER_BIN." >&2
  return 1
}

run_super_linter() {
  if ! command -v docker >/dev/null 2>&1; then
    echo "Docker not available; skipping super-linter." >&2
    return 0
  fi

  docker run --rm \
    -e RUN_LOCAL=true \
    -e MULTI_STATUS=false \
    -e VALIDATE_ALL_CODEBASE=true \
    -e VALIDATE_EDITORCONFIG=true \
    -e VALIDATE_MD=true \
    -e VALIDATE_YAML=true \
    -e FILTER_REGEX_EXCLUDE=".*/(CHANGELOG\\.md)" \
    -e DEFAULT_WORKSPACE=/work \
    -v "$ROOT_DIR":/work \
    -w /work \
    github/super-linter:slim-v4.9.4
}

cd "$ROOT_DIR"
run_prettier

if [[ "${RUN_SUPER_LINTER:-}" == "1" ]]; then
  run_super_linter
else
  echo "Skipping super-linter (set RUN_SUPER_LINTER=1 to enable)." >&2
fi

#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
RESUME_TEX="${RESUME_TEX:-${1:-}}"
if [[ -z "${RESUME_TEX}" ]]; then
  RESUME_TEX="$ROOT_DIR/src/resume.tex"
elif [[ "${RESUME_TEX}" != /* ]]; then
  RESUME_TEX="$ROOT_DIR/${RESUME_TEX}"
fi

if [[ ! -f "${RESUME_TEX}" ]]; then
  echo "Resume source not found: ${RESUME_TEX}" >&2
  exit 1
fi

RESUME_TEX_REL="${RESUME_TEX#$ROOT_DIR/}"
if [[ "${RESUME_TEX_REL}" == "${RESUME_TEX}" ]]; then
  echo "Resume source must be under repo root: ${RESUME_TEX}" >&2
  exit 1
fi
RESUME_TEX_DOCKER="/work/${RESUME_TEX_REL}"
RESUME_DIR="$(dirname "${RESUME_TEX}")"
RESUME_BASENAME="$(basename "${RESUME_TEX}")"
RESUME_NAME="${RESUME_BASENAME%.tex}"
RESUME_DIR_REL="$(dirname "${RESUME_TEX_REL}")"
RESUME_DIR_DOCKER="/work/${RESUME_DIR_REL}"
build_with_latexmk() {
  # Avoid latexmk forcing BibTeX from stale artifacts when the resume has no bibliography.
  rm -f \
    "$ROOT_DIR/${RESUME_NAME}.bbl" \
    "$ROOT_DIR/${RESUME_NAME}.blg" \
    "$ROOT_DIR/${RESUME_NAME}.fdb_latexmk" \
    "$ROOT_DIR/${RESUME_NAME}.fls"
  (
    cd "$RESUME_DIR"
    lualatex \
      --file-line-error \
      --halt-on-error \
      --interaction=nonstopmode \
      -recorder \
      -output-directory="$ROOT_DIR" \
      "$RESUME_BASENAME"
  )
  latexmk \
    -cd \
    -lualatex \
    --file-line-error \
    --halt-on-error \
    --interaction=nonstopmode \
    -recorder \
    -output-directory="$ROOT_DIR" \
    "$RESUME_TEX"
}

build_with_docker() {
  # Avoid latexmk forcing BibTeX from stale artifacts when the resume has no bibliography.
  rm -f \
    "$ROOT_DIR/${RESUME_NAME}.bbl" \
    "$ROOT_DIR/${RESUME_NAME}.blg" \
    "$ROOT_DIR/${RESUME_NAME}.fdb_latexmk" \
    "$ROOT_DIR/${RESUME_NAME}.fls"
  docker run --rm \
    -v "$ROOT_DIR":/work \
    -w "$RESUME_DIR_DOCKER" \
    ghcr.io/xu-cheng/texlive-full:20220701 \
    lualatex \
      --file-line-error \
      --halt-on-error \
      --interaction=nonstopmode \
      -recorder \
      -output-directory=/work \
      "$RESUME_BASENAME"
  docker run --rm \
    -v "$ROOT_DIR":/work \
    -w /work \
    ghcr.io/xu-cheng/texlive-full:20220701 \
    latexmk \
      -cd \
      -lualatex \
      --file-line-error \
      --halt-on-error \
      --interaction=nonstopmode \
      -recorder \
      -output-directory=/work \
      "$RESUME_TEX_DOCKER"
}

cd "$ROOT_DIR"

if command -v latexmk >/dev/null 2>&1; then
  build_with_latexmk
  exit 0
fi

if command -v docker >/dev/null 2>&1; then
  build_with_docker
  exit 0
fi

echo "latexmk not found and Docker unavailable. Install TeX Live/latexmk or Docker." >&2
exit 1

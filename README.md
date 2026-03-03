# Pezh Zarabadi's resume

[![Release](https://img.shields.io/github/release/ezpzbz/automated-cv.svg?style=flat)](https://github.com/ezpzbz/automated-cv/releases/latest)
[![Software License](https://img.shields.io/badge/license-MIT-brightgreen.svg?style=flat)](./LICENSE)
[![Build status](https://img.shields.io/github/actions/workflow/status/ezpzbz/automated-cv/general.yaml?style=flat)](https://github.com/ezpzbz/automated-cv/actions?query=workflow%3Ageneral)
[![semantic-release](https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg?style=flat)](https://github.com/semantic-release/semantic-release)

My resume written in LaTeX based on [Awesome-CV](https://github.com/posquit0/Awesome-CV) with complete CI/CD pipline. Fully automated testing, building & release process is powered by GitHub Actions & [semantic-release](https://github.com/semantic-release/semantic-release). The output pdf can be found in the [releases section](https://github.com/ezpzbz/automated-cv/releases/latest).

## Download: [resume.pdf](https://ezpzbz.github.io/automated-cv/resume.pdf)

If GitHub Pages is enabled for this repo, a preview will also be available at `https://<username>.github.io/automated-cv/resume.pdf`. For example, you can find preview [here](https://ezpzbz.github.io/automated-cv/resume.pdf)

## Hiring Use (Fork + Submit)

If you are applying and were asked to use this repo:

1. Fork this repository to your GitHub account.
2. Update the resume content in `src/sections/` (start with `src/sections/summary.tex` and `src/sections/experience-cde.tex`).
3. Build the PDF locally with `make build` (or via GitHub Actions).
4. Commit and push your changes to your fork.
5. Send me the link to your fork (and, if possible, the `resume.pdf` in the latest release or GitHub Pages).

## Local Development

### Setup

The following tools are recommended for local work:

- `git`: `>=2`
- Build: TeX Live with `latexmk` (LuaLaTeX) **or** Docker (`>=18.09`) for a containerized build
- Tests: Node.js `>=16` to install and run Prettier locally
- `make` (standard on macOS/Linux)

First clone the repository:

```shell
git clone git@github.com:ezpzbz/automated-cv.git
```

To work from your fork:

```shell
git clone git@github.com:<your-username>/automated-cv.git
```

Install local dev tools (Prettier):

```shell
npm install
```

### Test & Build Locally

- format (write): `npm run format`
- format (check): `npm run format:check`
- test: `make test` (runs Prettier; set `RUN_SUPER_LINTER=1` to run super-linter via Docker)
- build: `make build` (uses local `latexmk` when available, otherwise Docker)
- build a variant: `make build RESUME_TEX=src/resume_industry.tex` (outputs `resume_industry.pdf`)
- run test & build: `make all`

## Credits

The list of some third party components used in this project, with due credits to their authors and license terms. More details can be found in their README documentations.

- [posquit0/Awesome-CV](https://github.com/posquit0/Awesome-CV)
- [xu-cheng/latex-action](https://github.com/xu-cheng/latex-action)

Forked from `https://github.com/kirintwn/resume`.

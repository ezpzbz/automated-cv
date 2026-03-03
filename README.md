# Pezh Zarabadi's resume

[![Release](https://img.shields.io/github/release/ezpzbz/automated-resume-build.svg?style=for-the-badge)](https://github.com/ezpzbz/automated-resume-build/releases/latest)
[![Software License](https://img.shields.io/badge/license-MIT-brightgreen.svg?style=for-the-badge)](./LICENSE)
[![Build status](https://img.shields.io/github/workflow/status/ezpzbz/automated-resume-build/general/main?style=for-the-badge)](https://github.com/ezpzbz/automated-resume-build/actions?workflow=general)
[![semantic-release](https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg?style=for-the-badge)](https://github.com/semantic-release/semantic-release)

My resume written in LaTeX based on [Awesome-CV](https://github.com/posquit0/Awesome-CV) with complete CI/CD pipline. Fully automated testing, building & release process is powered by GitHub Actions & [semantic-release](https://github.com/semantic-release/semantic-release). The output pdf can be found in the [releases section](https://github.com/ezpzbz/automated-resume-build/releases/latest), or the preview is available [here](https://ezpzbz.github.io/automated-resume-build/resume.pdf) with GitHub Pages.

## Download: [resume.pdf](https://ezpzbz.github.io/automated-resume-build/resume.pdf)

## Local Development

### Setup

The following tools are recommended for local work:

- `git`: `>=2`
- Build: TeX Live with `latexmk` (LuaLaTeX) **or** Docker (`>=18.09`) for a containerized build
- Tests: Node.js `>=16` to install and run Prettier locally
- `make` (standard on macOS/Linux)

First clone the repository:

```shell
git clone git@github.com:ezpzbz/automated-resume-build.git
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

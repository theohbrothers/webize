# webize

[![github-actions](https://github.com/theohbrothers/webize/workflows/ci-master-pr/badge.svg)](https://github.com/theohbrothers/webize/actions)
[![github-release](https://img.shields.io/github/v/release/theohbrothers/webize?style=flat-square)](https://github.com/theohbrothers/webize/releases/)

Move away from proprietary apps to focus on a browser-first workflow.

`webize` aims to provide the most basic tools to move to a browser-first workflow. For a start, `webize` can generate a local image gallery that may be previewed in the browser at `file:///path/to/index.htm` so that local filesystem images may be consumed in the local browser.

## Philosophy

There are many OSes (platforms) with their own apps for previewing and consuming files. Among all of these interfaces, the most consistent interface is the web browser. We consume websites using the web browser, all apps are powered by the web, and almost every proprietary app out there can be replaced with a web app. So, since we are already familiar with the web browser, why aren't we using it more?

The goal of `webize` is to help the user move another step away from proprietary, platform-specific apps. Any workflow change that reduce reliance on non-browser apps is progress toward this goal.

`webize` is primarily for the use on client side for consuming local content (especially thin clients without or with limited virtualization capability). One may use `webize` on the server, but there should be better static site generators out there.

## Install

```sh
wget -qO- https://raw.githubusercontent.com/theohbrothers/webize/master/webize | sudo tee /usr/local/bin/webize && sudo chmod +x /usr/local/bin/webize
```

## Usage

### Gallery

At present, gallery is kept as minimalistic as possible. But it might already be better than many \[bloated\] previewing apps out there.

![](doc/assets/gallery-sample.png)

```sh
# Generate a `index.htm` in every descendent folder of /path/to with image files, and opens them in firefox
cd /path/to
webize gallery . | xargs firefox

# Cleanup once you are done
webize clean .
```

Keyboard shortcuts:

| Key| Behavior |
|---|---|
| LEFT | Previous image
| RIGHT | Next image
| UP | Previous image (or previous row in tiled view)
| DOWN | Next image (or previous row in tiled view)
| SPACE | Next image
| BACKSPACE | Previous image
| ESC | Back to tiled view

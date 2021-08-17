# webize

Generates a `index.htm` so that local filesystem files may be viewed in the local browser.

## Philosophy

There are many OSes (platforms) with their own apps for previewing and consuming files. Among all of these interfaces, the most consistent interface is the web browser. We consume websites using the web browser, and almost every proprietary app out there can be replaced with a web app. So, since we are already familiar with the web browser, why aren't we using it more?

The goal of `webize` is to help the user move another step away from proprietary, platform-specific apps. Any workflow change that reduce reliance on non-browser apps is progress toward this goal.

`webize` is primarily for the use on client side for consuming local content (especially thin clients without or with limited virtualization capability). One may use `webize` on the server, but there should be better static site generators out there.

## Usage

### Gallery

The web browser is incredibly powerful for consuming media files. So we deserve a more polished and consistent experience across all our OSes and platforms.

```sh
# Generate a `index.htm` in every descendent folder of /path/to with image files and opens them in firefox
cd /path/to
webize gallery . | xargs firefox

# Clean
webize clean .
```

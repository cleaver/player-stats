# PlayerStats

List, filter and sort NFL Rushing data. Developed as a programming exercise with a minimum of a added components.

## Installation

To install the application:

- Install dependencies with `mix deps.get`
- Create and migrate your database with `mix ecto.setup`
- Install Node.js dependencies with `npm install` inside the `assets` directory
- Start Phoenix endpoint with `mix phx.server`
- Load data with `mix load_rushing rushing.json`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Features

- Dark mode (if JavaScript enabled).
- Stateless, no sessions.
- Any view can be bookmarked.
- Easily cacheable.
- Javascript not required.
- Accessible. Tested with [WAVE evaluation tool](https://chrome.google.com/webstore/detail/wave-evaluation-tool/jbbplnpkjmmeebjpijfedlgcdilocofh)

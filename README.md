# hubot-skyweb

This is a [Skype](http://www.skype.com/) adapter for [Hubot](https://hubot.github.com/) using [Skyweb](https://github.com/ShyykoSerhiy/skyweb).

[![Build Status](https://travis-ci.org/EllisV/hubot-skyweb.svg)](https://travis-ci.org/EllisV/hubot-skyweb)

## Why another Skype adapter?

There are two popular approaches for having scriptable Skype:

* Launch desktop application and communicate using Skype desktop API
* Use PhantomJS to control Skype via Skype Web

In some cases those approaches make sense but Skyweb project proved that you do
not need to spin desktop application or use PhantomJS to have control over
Skype. What instead it does is use Skype HTTP protocol (which is not an
official one and you should read a
[Skyweb Disclaimer](https://github.com/ShyykoSerhiy/skyweb#disclaimer)).

## Getting Started

* Add `hubot-skyweb` as dependency in hubot's `package.json` via `npm install --save hubot-skyweb`
* Export necessary environment variables (see Configuration part)
* Start your hubot with Skyweb adapter: `bin/hubot -a skyweb`

## Configuration

This adapter uses the following environment variables:

* `HUBOT_SKYPE_USERNAME`
* `HUBOT_SKYPE_PASSWORD`

You can export them by running `export HUBOT_SKYPE_USERNAME=my.skype.username` or specify them before running hubot
like so `HUBOT_SKYPE_USERNAME=my.skype.username bin/hubot -a skyweb`.

## License

See the [LICENSE](LICENSE) file for license rights and limitations (MIT).

## hubot-zerocater-lunch [![NPM version](https://badge.fury.io/js/hubot-zerocater-lunch.png)](http://badge.fury.io/js/hubot-zerocater-lunch)

A [Hubot](https://github.com/github/hubot) plugin to query the ZeroCater API to see what's for lunch.

It does not know when lunch has been delivered, but all it takes is one person to say "lunch"
in a channel where your Hubot is listening.

### Usage

    lunch - Display what's for lunch
    hubot what's for lunch
    hubot what's for lunch tomorrow?

### Screenshot (textual irc)
![image](https://cloud.githubusercontent.com/assets/145113/10708989/fdd405aa-79d1-11e5-9b47-970d22428358.png)

### Configuration

You'll need your four character ZeroCater tag.  Visit your ZeroCater menu and it'll
be at the end of the URL: https://zerocater.com/m/[TAG-HERE].

Put that tag in the environment variable ZEROCATER_TAG. 

### Installation (old style):

Place lunch.coffee to your hubot/scripts directory. Restart hubot.

### Installation (new style):

1. cd into your hubot dir, run `npm install --save hubot-zerocater-lunch` (adds a dependency in package.json).
2. Add `"hubot-zerocater-lunch"` to your `external-scripts.json` file.
3. Restart Hubot.

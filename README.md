<div align="center">

<img src="docs/title.png" width="620" alt="DemonicPactAnnounce">

[![Game Version](https://img.shields.io/badge/wow-3.3.5a-blue.svg)](https://github.com/arkrosclou/DemonicPactAnnounce)

For Demonology warlocks: tells the raid how much spell power your **Demonic Pact** just gave them.

<sub>An addon for World of Warcraft 3.3.5a (Wrath of the Lich King) — Warmane, Icecrown, Lordaeron and other 3.3.5 realms.</sub>

</div>

Every time your pet procs Demonic Pact, you emote the amount, plus the weakest and strongest Pact of this fight:

```
Warlock [Demonic Pact] +281 spell power
Warlock [Demonic Pact] 281 - 306 | +306 spell power
```

- Only **your own** proc is announced. Another Demonology warlock's Pact in the raid does not trigger it.
- The weakest/strongest range starts over on every pull.
- Only a real proc counts. Your pet putting its Pact back on itself after a loading screen or a resummon
  is not announced.
- In a dungeon or raid it is an emote the group sees. Outside of instances it only prints to your own chat.
- It works only with Metamorphosis talented, and does nothing on other classes.

There are no settings: install it and it works.

## How to install

1. Download the addon: **[DemonicPactAnnounce-master.zip](https://github.com/arkrosclou/DemonicPactAnnounce/archive/refs/heads/master.zip)**.
2. Open the zip. Inside is a folder called `DemonicPactAnnounce-master`. Copy it into your addons folder
   (`Interface/AddOns`) and **rename it to `DemonicPactAnnounce`**. With the `-master` ending the game will not load it.
3. Start the game. At the character selection screen, click **AddOns** (bottom left) and make sure
   **DemonicPactAnnounce** is enabled.

## How to update

Download the zip again and replace the `DemonicPactAnnounce` folder with the new one.

## Problems

Found a bug or got a Lua error? Please [open an issue](https://github.com/arkrosclou/DemonicPactAnnounce/issues).

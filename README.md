<div align="center">

# DemonicPact Announce

[![Game Version](https://img.shields.io/badge/wow-3.3.5a-blue.svg)](https://github.com/arkrosclou/DemonicPactAnnounce)

For Demonology warlocks: tells the raid how much spell power your **Demonic Pact** just gave them.

</div>

Every time your pet procs Demonic Pact, you emote the amount, plus the weakest and strongest Pact of this fight:

```
Daliaty [Demonic Pact] +281 spell power
Daliaty [Demonic Pact] 281 - 306 | +306 spell power
```

- Only **your own** proc is announced. Another Demonology warlock's Pact in the raid does not trigger it.
- The weakest/strongest range starts over on every pull.
- In a dungeon or raid it is an emote the group sees. Outside of instances it only prints to your own chat.
- It works only with Metamorphosis talented, and does nothing on other classes.

There are no settings: install it and it works.

## How to install

1. Download the addon: **[DemonicPactAnnounce-master.zip](https://github.com/arkrosclou/DemonicPactAnnounce/archive/refs/heads/master.zip)**.
2. Open the zip. Inside is a folder called `DemonicPactAnnounce-master`. Copy it into your addons folder
   (`Interface/AddOns`) and **rename it to `DemonicPactAnnounce`**. With the `-master` ending the game will not load it.
3. Start the game. At the character selection screen, click **AddOns** (bottom left) and make sure
   **DemonicPact Announce** is enabled.

## How to update

Download the zip again and replace the `DemonicPactAnnounce` folder with the new one.

## Problems

Found a bug or got a Lua error? Please [open an issue](https://github.com/arkrosclou/DemonicPactAnnounce/issues).

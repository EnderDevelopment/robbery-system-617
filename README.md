# Robbery System

Enhance your FiveM server with a realistic robbery system

## Features

- Target player detection with distance-based interaction
- Robbery animations and progress bars for realism
- Inventory integration for both ox_inventory and qb-inventory
- Random item selection and amount generation for varied gameplay
- Database logging of robberies for server tracking

## Requirements

- FiveM server with QB-Core framework
- ox_inventory or qb-inventory plugin
- oxmysql for database operations

## Installation

1. Download the script files
2. Place them in your resources folder
3. Add `start robbery-system` to your server.cfg
4. Configure the config.lua file to match your server setup

## Usage

Players can initiate a robbery by approaching another player and pressing the interaction key (default: E). The robbery will trigger animations, a progress bar, and transfer items from the target to the robber.

## Configuration

Edit the config.lua file to adjust:

- Robbery distance and time
- Animation settings
- Inventory type (ox_inventory or qb-inventory)
- Items that can be stolen

---

## Generated with EnderDevelopment

This plugin was generated in minutes with [EnderDevelopment](https://enderdevelopment.com) — the AI platform that turns your ideas into working Minecraft plugins, Discord bots and FiveM scripts.

**Want your own?** [Generate this project on EnderDevelopment](https://dash.enderdevelopment.com?utm_source=github&utm_medium=readme&utm_campaign=robbery-system&utm_content=bottom) — describe it in one sentence and get the full source code.
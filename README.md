# Workouter plugin for Claude Code

Design structured workouts in plain English with Claude and send them
straight to your Apple Watch through [Workouter](https://workouter.co).

## Requirements

- A Workouter account on the **Pro** plan (the MCP server is Pro-only).
- The Workouter iOS app with an Apple Watch paired, for automatic delivery.
  If you don't have one, Workouter gives you a link to open on your iPhone.
- There is no Garmin support.

## Install

```
/plugin marketplace add TomBarta/workouter-claude-plugin
/plugin install workouter@workouter
```

Then run `/mcp`, pick **workouter**, and sign in. A browser window opens for
Workouter's OAuth consent. There is no API key to copy.

## OpenClaw

OpenClaw installs this plugin as a Claude bundle, and turns the skill and
the commands into OpenClaw skills. Sign-in is a separate step, because
`openclaw mcp login` only works with servers in OpenClaw's own config:

```
openclaw plugins install workouter --marketplace TomBarta/workouter-claude-plugin
openclaw mcp add workouter --url https://workouter.co/api/mcp --transport streamable-http --auth oauth
openclaw mcp login workouter
```

`login` opens Workouter's consent page and picks up the loopback callback
automatically. To see the inline workout card, turn on OpenClaw's MCP Apps
host bridge (`openclaw config set mcp.apps.enabled true --strict-json`), then
restart the gateway.

## What you get

| | |
|---|---|
| `/workouter:create <description>` | Build a workout from a description and deliver it |
| `/workouter:list [limit]` | Your recent workouts |
| `/workouter:status` | Plan, remaining weekly quota, and whether an Apple Watch is registered |
| `build-workout` skill | Used automatically when you ask Claude for a workout. It asks when details are missing, handles swim send-offs vs fixed rest, and maps EMOM, AMRAP, and circuits onto WorkoutKit |

Examples:

```
/workouter:create 10 min warmup, 6x800m hard with 400m easy jog, 10 min cooldown
/workouter:create 8 x 50 free on the 1:00, then 4 x 100 kick with 20s rest (yards)
build me a 12 minute EMOM: 10 burpees
```

## Development

```
scripts/validate.sh          # manifest validation + WORKO-224 checks
/plugin marketplace add ./   # install from a local checkout
```

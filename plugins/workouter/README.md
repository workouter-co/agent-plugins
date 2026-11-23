# Workouter plugin for Claude

Workouter turns any workout description into a structured workout and sends it to your Apple Watch. Describe a session in plain English or paste your coach's notes, and Claude builds the warmup, intervals, recoveries and cooldown, with time or distance goals and heart-rate, pace or power targets where your watch supports them. This plugin adds two skills and three commands to Claude and connects it to the Workouter service.

This plugin goes alongside the Workouter connector. It uses the same server, so if you have both installed you see one set of tools.

## What it does

| Part | Use it when you want to |
| --- | --- |
| `build-workout` skill | Turn typed or spoken text, a coach's notes, or another assistant's plan into a workout. Claude asks only for what is missing, shows a short summary, then saves and sends it. |
| `training-plan` skill | Build a multi-week plan from a goal, such as a 10k in 8 weeks, and save its workouts to Workouter. |
| `/workouter:create <description>` | Build a workout from a description and deliver it |
| `/workouter:list [limit]` | List your recent workouts |
| `/workouter:status` | Check your plan, remaining weekly quota, and whether an Apple Watch is registered |

Worked examples live in `skills/build-workout/references/`.

## Requirements

- A Workouter account on the Pro plan. See https://workouter.co for current plans.
- The Workouter iPhone app, signed in, with an Apple Watch paired, for automatic delivery to the watch. Without a registered watch, Workouter gives you a link and QR code to open on your iPhone, and the iPhone app sends the workout over.
- There is no Garmin support.

## Install

**Claude Code**

```
/plugin marketplace add workouter-co/agent-plugins
/plugin install workouter@workouter
```

Then run `/mcp`, choose **workouter** and sign in. A browser window opens for Workouter's consent page. There is no API key to copy.

**Claude on the web, desktop and mobile, and Cowork**

1. Open Customize > Plugins, find Workouter in the directory (or use Add > Upload plugin with a zip of this folder), and install it.
2. Open the plugin's Connectors tab, connect Workouter, and sign in. Leave creating workouts allowed. Emailing a workout link to yourself is optional.

## Supported surfaces

The plugin contains only skills, commands and a remote MCP server, and all of them load everywhere Claude plugins run. Commands load as skills in chat, and you run them by typing `/workouter:<command>` in Cowork and Claude Code.

| Surface | Skills and commands | Workouter connection |
| --- | --- | --- |
| Chat (web, desktop, mobile) | Yes | Connect on the plugin's Connectors tab |
| Cowork | Yes | Connect on the plugin's Connectors tab |
| Claude Code | Yes | Connects with `/mcp` |

## Privacy and data

- The plugin has no code, scripts, hooks or telemetry of its own. Its only network destination is the Workouter server at https://workouter.co/api/mcp.
- When you ask for a workout, Claude sends that workout (activity, goals, targets, names) to your Workouter account.
- Sign-in uses OAuth with Workouter. The plugin stores no keys or tokens. Workouter asks for permission to read your account and workouts, and optionally to create workouts and to email a workout link to the address on your account.
- Workouter keeps the workouts you save in your account. Privacy policy: https://workouter.co/privacy

## Limits to know about

- Workouter has no reps, sets or load for gym sessions. They appear in each timed step's name.
- Delivery is requested, not confirmed. Workouter reports what it has observed and never claims a workout is on your watch.
- Saving a workout counts toward your weekly workout limit.
- Claude saves a training plan to Workouter when plan tools are available, and otherwise gives you the schedule in the chat. Planned days are sent to your iPhone ahead of their date, so a day with no registered Apple device is skipped once its date passes. A day can only be changed while it is upcoming.

## Support

Email support@workouter.co, or see https://workouter.co/docs/mcp for the tool reference.

## License

MIT. See `LICENSE`.

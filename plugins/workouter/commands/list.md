---
description: List your recent Workouter workouts
argument-hint: "[limit, 1-50, default 20]"
---

Call the `workouter` server's `list_workouts` tool. If "$ARGUMENTS" is a
number from 1 to 50, pass it as `limit`. Otherwise leave `limit` out.

Show the result as a compact table with columns Name, Activity, and Created
(a short local date), newest first. Keep the ids so a follow-up like "show
me the second one" can call `get_workout`. If there are no workouts, say so
and suggest `/workouter:create`.

If the tool returns `subscription_required`, relay its message and
`upgrade_url`. On an auth error, ask the user to re-authenticate the
`workouter` server with `/mcp`.

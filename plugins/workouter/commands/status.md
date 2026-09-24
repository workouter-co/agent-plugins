---
description: Show your Workouter plan, remaining weekly quota, and whether workouts push to your watch automatically
---

Call the `workouter` server's `get_quota` and `get_delivery_status` tools
(they are independent, so call them together). Report in two or three
lines:

- Tier, and how many workouts are left this week out of the limit.
- Whether an Apple Watch is registered. If one is, workouts push to it
  automatically. If not, `create` returns a link to open on the iPhone.

If either tool returns `subscription_required`, relay its message and
`upgrade_url`. On an auth error, ask the user to re-authenticate the
`workouter` server with `/mcp`.

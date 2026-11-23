---
name: training-plan
description: Build a multi-week training plan toward a goal, such as a 10k in 8 weeks, a first marathon, a cycling event or getting back into regular gym sessions, and schedule its workouts with Workouter. Use when the user asks for a plan, program or weekly schedule that spans more than one session.
---

# Training plan

Design the whole plan in the chat first. Save workouts to Workouter only after the user has agreed to the plan and to how many workouts to save.

## Steps

1. **Gather the basics,** in one short message, only what is missing: the goal and date (or number of weeks), current level (recent weekly volume or a recent race time), days per week, time per session, start date, timezone, and any injury or constraint. For injuries or health concerns, suggest checking with a professional, and keep the plan conservative.
2. **Design the plan in the chat.** Show a week-by-week table: sessions, purpose and rough length. Build load gradually, include easier weeks and a taper before an event, and keep rest days. Ask for changes before saving anything.
3. **Check the limits before saving.**
   - Call `get_quota`. Every `create_workout` counts toward the weekly limit, and each workout is sent to the watch as soon as it is saved. A whole multi-week plan will usually not fit in one week.
   - Call `list_devices`. If there are several devices and none is preferred, ask which one to use and save it with `set_preferred_device` before saving any workout, as the `build-workout` skill describes.
   - Check that `create_plan` is among your available tools.
4. **Agree what to save now.** Offer the sessions that fit the remaining quota, usually the next one or two weeks, and say plainly that they will all be sent to the watch now. Get a clear yes.
5. **Create the workouts.** For each session, build and call `create_workout` as the `build-workout` skill describes, with its worked examples in [../build-workout/references/examples.md](../build-workout/references/examples.md). The agreed list counts as the confirmation, so don't ask again per workout. Keep each `workout_id` with its intended date.
6. **Schedule them if you can.**
   - If `create_plan` is available, call it once with the plan `name`, `start_date`, `timezone` and `days`, each day a `date` (YYYY-MM-DD) and a `workout_id`. A `workout_id` can appear only once, so every day needs its own workout. Days can later be moved, swapped or skipped with `update_plan_day`, or removed with `remove_plan_day`, but only while they are upcoming. Days can't be added to an existing plan. Confirm with `get_plan`. Each planned day is sent to the user's iPhone ahead of its date, and the Workouter app schedules it for that day; don't promise how far ahead. A day that can't be sent, for example because no Apple device is registered, is marked skipped once its date has passed. So call `get_delivery_status` first, and warn the user if it reports `can_auto_push: false`.
   - If it isn't available, don't say the plan is scheduled in Workouter. Give the full schedule in the chat, and offer to save each following week's workouts when the user is ready.
7. **Close with what happened:** which workouts were saved, which weeks remain unsaved, and how to continue. Report delivery and errors the way the `build-workout` skill does, including its one-time app note.

## Rules

- Never invent a workout, date or `workout_id`. Use only IDs returned by tools.
- Stop and tell the user if the quota would be exceeded, rather than saving some and dropping the rest silently.
- Treat a goal like "a 10k in 8 weeks" as the user's, and be honest when it looks unrealistic for their level.

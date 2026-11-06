# WORKO-605: accurate delivery and host recovery

## Current behavior

- PRESERVE: the bundle uses the production HTTP server and native OAuth.
- CHANGE: the skill equates pushed with Watch receipt; report delivery requested/unconfirmed and inspect the existing workout's status/fallback.
- CHANGE: auth recovery names only Claude's /mcp; include OpenClaw login.
- CHANGE: subscription refusal assumes an upgrade URL; relay the returned entitlement message.

## Target behavior

- WHEN the bundle is validated, its manifests and marketplace SHALL pass the existing CLI validator at version 0.1.2.
- WHEN the skill is inspected, its pushed branch SHALL leave Watch receipt unconfirmed, preserve the existing workout for recovery and identify host-specific reauthorization commands.

## Invariants and scope

No endpoint/authentication change, no extra delivery/creation, no credentials in the bundle and no repository visibility/publication change. Scope: this skill and plugin patch version; the server correctness tests and main requirement spec are in Workouter's WORKO-605 change.

## Human checkpoints

Actual host interaction and physical Watch observations remain in the existing release QA tickets; static skill instructions do not establish successful delivery.

## Decision

Use the same shared skill with explicit host recovery rather than maintaining divergent Claude and OpenClaw copies.

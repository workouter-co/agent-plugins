#!/usr/bin/env bash
# Validates the marketplace, the plugin manifest, the MCP server wiring and the
# skill and command files. Run from anywhere; exits non-zero on failure.
set -uo pipefail
cd "$(dirname "$0")/.."

PLUGIN=plugins/workouter
fail=0
check() {
  local name="$1"; shift
  if "$@" >/dev/null 2>&1; then echo "ok   $name"; else echo "FAIL $name"; fail=1; fi
}

check "marketplace validates" claude plugin validate .
check "plugin validates" claude plugin validate "$PLUGIN"

# "auth": "oauth" is for OpenClaw, which only runs OAuth for servers that
# declare it. Claude Code ignores the key.
check ".mcp.json declares only the production HTTP server, with OAuth" python3 - "$PLUGIN/.mcp.json" <<'PY'
import json, sys
servers = json.load(open(sys.argv[1]))["mcpServers"]
assert list(servers) == ["workouter"], servers
s = servers["workouter"]
assert s == {"type": "http", "url": "https://workouter.co/api/mcp", "auth": "oauth"}, s
PY

has_frontmatter() { # file, key...
  local f="$1"; shift
  [ -f "$f" ] || return 1
  local fm; fm="$(awk 'NR==1 && $0=="---"{on=1; next} on && $0=="---"{exit} on' "$f")"
  for key in "$@"; do grep -q "^$key:" <<<"$fm" || return 1; done
}
for cmd in create list status; do
  check "command $cmd has a description" has_frontmatter "$PLUGIN/commands/$cmd.md" description
done
for skill in build-workout training-plan; do
  check "$skill skill has name and description" \
    has_frontmatter "$PLUGIN/skills/$skill/SKILL.md" name description
done

for f in README.md LICENSE assets/icon.png; do
  check "plugin folder has $f" test -f "$PLUGIN/$f"
done

no_garmin_claims() {
  ! grep -rn -i garmin "$PLUGIN/skills" "$PLUGIN/commands" | grep -v -i "coming soon"
}
check "Garmin only mentioned as coming soon" no_garmin_claims

# This repository is public. The pattern's brackets keep this line from matching itself.
no_ticket_refs() {
  ! grep -rqE 'WORK[O]-[0-9]+' --exclude-dir=.git .
}
check "no ticket references in files" no_ticket_refs

exit $fail

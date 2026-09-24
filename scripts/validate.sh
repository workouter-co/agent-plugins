#!/usr/bin/env bash
# Checks the WORKO-224 acceptance criteria (specs/WORKO-224-claude-plugin.md
# in the Workouter monorepo). Run from anywhere; exits non-zero on failure.
set -uo pipefail
cd "$(dirname "$0")/.."

PLUGIN=plugins/workouter
fail=0
check() {
  local name="$1"; shift
  if "$@" >/dev/null 2>&1; then echo "ok   $name"; else echo "FAIL $name"; fail=1; fi
}

check "WORKO-224: marketplace validates" claude plugin validate .
check "WORKO-224: plugin validates" claude plugin validate "$PLUGIN"

check "WORKO-224: .mcp.json declares only the production HTTP server" python3 - "$PLUGIN/.mcp.json" <<'PY'
import json, sys
servers = json.load(open(sys.argv[1]))["mcpServers"]
assert list(servers) == ["workouter"], servers
s = servers["workouter"]
assert s == {"type": "http", "url": "https://workouter.co/api/mcp"}, s
PY

has_frontmatter() { # file, key...
  local f="$1"; shift
  [ -f "$f" ] || return 1
  local fm; fm="$(awk 'NR==1 && $0=="---"{on=1; next} on && $0=="---"{exit} on' "$f")"
  for key in "$@"; do grep -q "^$key:" <<<"$fm" || return 1; done
}
for cmd in create list status; do
  check "WORKO-224: command $cmd has a description" has_frontmatter "$PLUGIN/commands/$cmd.md" description
done
check "WORKO-224: build-workout skill has name and description" \
  has_frontmatter "$PLUGIN/skills/build-workout/SKILL.md" name description

no_garmin_claims() {
  ! grep -rn -i garmin "$PLUGIN/skills" "$PLUGIN/commands" | grep -v -i "no Garmin support"
}
check "WORKO-224: Garmin only mentioned as unsupported" no_garmin_claims

exit $fail

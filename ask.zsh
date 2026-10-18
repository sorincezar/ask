# ask: quick questions to Claude from the terminal, via Claude Code (`claude -p`).
#   ask  "..."  start a new conversation
#   askf "..."  follow up on the most recent conversation
#   askr ["..."] pick one of the last 10 conversations and follow up on it
# Sessions all run from ~/.ask so they stay separate from other Claude Code work.

ASK_DIR=~/.ask
ASK_MODEL=${ASK_MODEL:-haiku}
mkdir -p $ASK_DIR

ask()  { (cd $ASK_DIR && claude --model $ASK_MODEL -p "$*"); }
askf() { (cd $ASK_DIR && claude --model $ASK_MODEL -c -p "$*"); }

askr() {
  # Claude Code stores sessions under a folder named after the path, non-alphanumerics -> '-'
  local dir=~/.claude/projects/${ASK_DIR//[^[:alnum:]]/-}
  local -a files; files=(${(f)"$(ls -t $dir/*.jsonl 2>/dev/null | head -10)"})
  (( ${#files} )) || { echo "No ask sessions yet."; return 1; }
  local i=1 f q
  for f in $files; do
    q=$(jq -r 'select(.type=="user" and (.message.content|type)=="string") | .message.content' "$f" | head -1 | cut -c1-70)
    printf '%2d) %s  %s\n' $i "$(date -r "$f" '+%b %d %H:%M')" "$q"
    (( i++ ))
  done
  local n; read "n?Pick a session: "
  [[ $n == <-> ]] && (( n >= 1 && n <= ${#files} )) || { echo "Cancelled."; return 1; }
  local prompt="$*"
  [[ -z $prompt ]] && read "prompt?Follow-up: "
  (cd $ASK_DIR && claude --model $ASK_MODEL -r "${files[n]:t:r}" -p "$prompt" < /dev/null)
}

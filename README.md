# ask

Tiny zsh helpers for asking Claude quick questions from the terminal, with follow-ups across sessions. Uses Claude Code (`claude -p`), so it runs on your Claude subscription.

| Command | What it does |
|---|---|
| `ask "..."` | Start a new conversation |
| `askf "..."` | Continue the most recent conversation |
| `askr` | Pick one of the last 10 conversations and continue it |

## Install

Requires [Claude Code](https://claude.com/claude-code) (logged in), `jq`, and zsh.

```sh
git clone git@github.com:sorin-brompton/ask.git ~/workspace/ask
echo 'source ~/workspace/ask/ask.zsh' >> ~/.zshrc
```

Set `ASK_MODEL` before the `source` line to use a different model (default: `haiku`).

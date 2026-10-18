# ask

Tiny zsh helpers for asking Claude quick questions from the terminal, with follow-ups across sessions. Uses Claude Code (`claude -p`), so it runs on your Claude subscription.

| Command | What it does |
|---|---|
| `ask "..."` | Start a new conversation |
| `askf "..."` | Continue the most recent conversation |
| `askr` | Pick one of the last 10 conversations and continue it |

## Piping input

`ask` and `askf` include anything piped in alongside your question:

```sh
tail -50 app.log | ask "why is this failing?"
git diff | askf "and does this change fix it?"
```

This also works for a remote machine without logging into Claude there: the command runs remotely, the question is asked from your own machine.

```sh
ssh shared-box 'tail -50 /var/log/app.log' | ask "why is this failing?"
```

## Install

Requires [Claude Code](https://claude.com/claude-code) (logged in), `jq`, and zsh.

```sh
git clone git@github.com:sorincezar/ask.git ~/workspace/ask
echo 'source ~/workspace/ask/ask.zsh' >> ~/.zshrc
```

Set `ASK_MODEL` before the `source` line to use a different model (default: `haiku`).

## Using a separate Claude account

To have `ask` use a different login than your normal `claude` (e.g. personal vs work), give it its own config folder and log in once:

```sh
CLAUDE_CONFIG_DIR=~/.claude-personal claude   # then run /login with the other account
echo 'export ASK_CLAUDE_CONFIG_DIR=~/.claude-personal' >> ~/.zshrc
```

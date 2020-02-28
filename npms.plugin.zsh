function npms() {
  if [ ! -f package.json ]; then
    echo "package.json not found" >&2
  else 
    local command=$(jq '.scripts | keys[]' package.json -r | tr -d '"' | 
    fzf --reverse \
      --preview-window=:wrap \
      --preview "jq '.scripts.\"{}\"' package.json -r | tr -d '\"' | sed 's/^[[:blank:]]*//'")

    if [ -n "$command" ]; then
      eval "npm run $command"
    fi
  fi
}

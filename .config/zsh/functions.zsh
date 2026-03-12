mkpatch () {
  local oldest_ancestor=$(git oldest-ancestor $1 $2)
  local patch_name=$(echo $1 | sed 's/\//_/g')
  git diff $oldest_ancestor..$1 > ../$patch_name.patch
}

pin () {
  echo "current git HEAD \`$(git rev-parse HEAD)\`" | pbcopy
}

ezpull () {
  node /Users/ryan/Projects/FOSS/ezpull/dist/index.js $@
}

yay () {
  confetti
  afplay ~/.sounds/yay.mp3
}

sadtrombone () {
  afplay ~/.sounds/sadtrombone.mp3
}

noisy () {
  $@ && yay || sadtrombone
}

function list_all() {
    emulate -L zsh
    ls -a
}
chpwd_functions=(${chpwd_functions[@]} "list_all")

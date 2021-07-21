# Helper function to clone into local directory without knowing the org the repo lives in
moz-clone() {
  repo=$1
  for org in mozilla-it mozilla-services mozilla mozilla-iam mozmeao; do
    if ls ~/work/$org/$repo 2> /dev/null ; then
      echo "Repo $repo already checked out, changing directories"
      cd ~/work/$org/$repo
      return
    fi
    echo "Checking org $org for $repo"
    if git ls-remote git@github.com:$org/$repo.git 2> /dev/null ; then
      echo "Found $repo in $org"
      git clone git@github.com:$org/$repo ~/work/$org/$repo
      echo "Changing to ~/work/$org/$repo"
      cd ~/work/$org/$repo
    fi
  done
}

alias mc=moz-clone
alias cw="cd ~/work/"

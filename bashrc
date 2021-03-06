# Helper function to clone into local directory without knowing the org the repo lives in
moz-clone() {
  repo=$1
  for org in mozilla-it mozilla-services mozilla mozilla-iam mozmeao mdn pocket; do
    if ls ~/work/$org/$repo > /dev/null 2>&1 ; then
      echo "Repo $repo already checked out, changing directories"
      cd ~/work/$org/$repo
      return
    fi

    echo "Checking org $org for $repo"

    if git ls-remote git@github.com:$org/$repo.git > /dev/null 2>&1 ; then
      echo "Found $repo in $org"

      if ! ls ~/work/$org > /dev/null 2>&1 ; then
        mkdir ~/work/$org
      fi

      git clone git@github.com:$org/$repo ~/work/$org/$repo
      echo "Changing to ~/work/$org/$repo"
      cd ~/work/$org/$repo
    fi
  done
}

moz-dir() {
  repo=$1
  directories=$(find ~/work -maxdepth 2 -type d -name $repo)
  if test $(echo "${directories[@]}" | wc -l) -eq 1 ; then
    cd $directories
  else
    echo "multiple directories found for $repo. Select desired location:"
    select dir in $(echo -n $directories); do
      case $dir in
        *) cd $dir;
          break ;;
      esac
    done
  fi
}

alias mc=moz-clone
alias cw="cd ~/work/"
alias m=moz-dir

#!/usr/bin/env bash


# This quick and dirty script will check for PRs pending my approval
# This will do nothing if it can't establish a connection to REDACTED Enterprise Github.
# If there is a PR pending my approval, it'll display a notification
# Alerting me to review the PR.
# Otherwise, It shouldn't do anything else
# If it hits an error, it will display the error as a notification
# It might be better to send that to stdout so I see it in `mail`

function check_git_access(){
	echo -e "GET https://REDACTED HTTP/1.1\n\n" | timeout 10 nc REDACTED 443 &> /dev/null 2>&1 || exit 1
}

function notify(){
  # $1 = title
  # $2 = message
  /usr/bin/osascript -e "display notification \"$2\" with title \"$1\"" > /dev/null 2>&1
}

function err(){
  notify "Error" "Failed to check for PRs pending my approval." && exit 1
}


check_git_access
cd REDACTED || err
retval=$(/usr/local/bin/gh pr list --search "review:required review-requested:@me" || err)
if [[ -z $retval ]]; then
  # No pending PRs. Don't annoy me.
  exit 0
fi

notify "Pending PRs" "$retval"

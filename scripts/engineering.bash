#!/bin/bash
# script name : edit.bash
# script args : $1 -- file to be edited [ALL for working+sub directories]
#       $2 -- comments for git
#       $3 -- remove interactivity if parameter equals "noprompting"
#
# The script ensures that edits are pushed to the engineering
# on Heroku. 
#
# git remote rm origin
# git remote add origin https://github.com/capoeiraretreats/engineering-capoeiraretreats-com.git

git init
if [ $1 == "ALL" ] ; then
	git add --all .
else
	git add $1
fi
git commit -m "$2"
cat ~/.netrc | grep heroku || heroku login && heroku keys:add ~/.ssh/id_rsa.pub
heroku apps:destroy engineering-capoeiraretreats-com --confirm engineering-capoeiraretreats-com
heroku apps:create engineering-capoeiraretreats-com
heroku domains:add engineering.capoeiraretreats.com --app engineering-capoeiraretreats-com
heroku git:remote -a engineering-capoeiraretreats-com
git push heroku master

# Setup Environment

1. `oc login https://api.pro-us-east-1.openshift.com --token=xxx`
1. `oc new-project laravel-realworld-example-app`
1. `cp .env.example .evn`
1. `oc process -f https://raw.githubusercontent.com/openshift/origin/master/examples/db-templates/mysql-persistent-template.json | oc create -f -`
1. Look at the secret `mysql` on the web console and add the database-name, database-user, database-password into `.env` and set the database host to the string ouput by `echo "mysql.$( oc project --short=true).svc"`
1. `NAME=realworld ./create-env-secret.sh .env`
1. `oc new-app uniqkey/s2i-nginx-php72~https://github.com/simbo1905/laravel-realworld-example-app.git`
1. `oc expose svc/laravel-realworld-example-app`

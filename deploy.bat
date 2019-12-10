echo off

set MSG=%1

echo "MSG="%MSG%

IF [%MSG%] == [] (
    echo "Post MSG can be empty"
    GOTO:EOF
)

git status
git add .
git commit -a -m %MSG%
git push

# build static resource
hugo -s back
git status
git add .
git commit -a -m "deploy:%MSG%"
git push
git status



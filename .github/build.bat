npm install;
npm i -g rollup eslint eslint-plugin-jsdoc jsdoc prettier terser figlet-cli @babel/core @babel/cli @babel/preset-env @babel/plugin-transform-modules-commonjs
npm install eslint-plugin-jsdoc @babel/plugin-transform-spread @babel/plugin-transform-template-literals @babel/preset-env babel @babel/plugin-transform-arrow-functions @babel/plugin-transform-sticky-regex @babel/plugin-transform-shorthand-properties

COMMIT=$(git status --porcelain)
rm bijou_node.js
rm bijou.js
cat ./js/_copyright.js ./js/array.js ./js/color.js ./js/date.js ./js/element.js ./js/event.js ./js/function.js ./js/object.js ./js/math.js ./js/string.js ./js/utility.js ./js/_end.js > bijou.js
rm -r docs/docs
rm bijou-min.js
jsdoc -c jsdoc.json
eslint --fix ./
prettier --write -- .
rollup bijou.js --file bijou_node.js --format cjs
terser --comments false --ecma 6 --ie8 --module --compress --drop-console --mangle -o docs/bijou.js -- bijou.js
terser --comments false --ecma 6 --ie8 --module --compress --drop-console --mangle -o bijou-min.js -- bijou.js
if [[ ${#COMMIT} -ge 1 ]] ; then
    COMMIT_CUSTOM_MSG="Automated CI build"
    COMMIT_FILE=$(git diff --name-only)
    git stage .
    DATE=$(date +"%F %H:%M:%S")
    USER=$(git config user.name)
    EMAIL=$(git config user.email)
    REPO="BIJOU.JS"
    FIGLET_REPO=$(figlet -kf Big -- $REPO)
    BR=$'\n'
    COMMIT_MSG=$"${FIGLET_REPO}${BR}Files changed: ${BR}${BR}${COMMIT}${BR}${BR}Date: ${DATE}${BR}User: ${USER}${BR}Email: ${EMAIL}"
    git commit -m "${COMMIT_CUSTOM_MSG}${BR}${BR}" -m "${COMMIT_MSG}"
fi
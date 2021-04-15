const fs = require("fs");

const groups = ["array", "color", "math", "function", "element", "object", "event", "string", "utility", "date"];

groups.forEach(group => {
  let js = fs.readFileSync(`./js/${group}.js`, { encoding: "utf8" });
  const jsdocRe = /\/\*\*\s*\n([^\*]|(\*(?!\/)))*\*\//gm
  const jsdocs = js.match(jsdocRe);
  
});

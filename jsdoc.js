const fs = require("fs");

const groups = ["array", "color", "math", "function", "element", "object", "event", "string", "utility"];

groups.forEach(group => {
  let js = fs.readFileSync(`./js/${group}.js`, { encoding: "utf8" });
  
});

const fs = require("fs");

const groups = ["array", "color", "math", "function", "element", "object", "event", "string", "utility", "date"];

let errors = [];

groups.forEach(group => {
  const js = fs.readFileSync(`./js/${group}.js`, { encoding: "utf8" });
  const jsdocRe = /\/\*\*\s*\n([^\*]|(\*(?!\/)))*\*\//gm
  const jsdocs = js.match(jsdocRe);
  const tags = [/@example/, new RegExp("@memberOf " + group), /@author/];
  
  jsdocs.forEach(jsdoc => {
    if (jsdoc.test(/@file/)) return;
    let split = js.split(jsdoc)[1];
    let isFunction = split.split(/(function|\)\s*=>)/gm).match(/export/g).length === 1;
    let name = split.split(/(let|function)/)[1].split(/\s/)[0].trim();
    let errorName = `${isFunction ? "function" : "object"} ${name} at js/${group}.js: `;
    tags.forEach(tag => {
      if (!jsdoc.test(tag)) errors.push(errorName + "missing tag: " + tag.source);
    });
  });
});

if (errors.length) throw errors.join("\n");

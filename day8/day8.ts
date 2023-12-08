console.log("Day 8");
type Node = {
  id: string;
  left: string;
  right: string;
};
const nodes: { [id: string]: Node } = {};
import { readFileSync } from "node:fs";
const input = readFileSync("./input.txt", "utf-8").split("\n");
const instructions = input[0].split("");
for (let i = 2; i < input.length - 1; i++) {
  const match = input[i].match(/(\w+).+\((\w+), (\w+)\)/);
  if (!match) {
    continue;
  }
  const node: Node = {
    id: match[1],
    left: match[2],
    right: match[3],
  };
  nodes[node.id] = node;
}
let node = nodes["AAA"];
let i = 0,
  steps = 0;
while (node.id !== "ZZZ" || 1) {
  steps++;
  const next = instructions[i] === "R" ? node.right : node.left;
  node = nodes[next];
  if (!node) {
    console.log("Node not found:", next);
    break;
  }
  if (node.id === "ZZZ") {
    console.log("found at", steps);
    steps = 0;
  }

  i++;
  if (i == instructions.length) {
    i = 0;
  }
}
console.log(steps);

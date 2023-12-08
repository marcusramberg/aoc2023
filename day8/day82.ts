console.log("Day 8");
import { readFileSync } from "node:fs";
type Node = {
  id: string;
  left: string;
  right: string;
};
const nodes: { [id: string]: Node } = {};
const start: { [id: string]: Node } = {};
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
  if (node.id.endsWith("A")) {
    start[node.id] = node;
  }
}
console.log(start);
const nums = [];
for (let id in start) {
  let i = 0,
    steps = 0;
  while (!id.endsWith("Z")) {
    const node = nodes[id];
    id = instructions[i] === "R" ? node.right : node.left;
    steps++;
    i++;
    if (i == instructions.length) {
      i = 0;
    }
  }
  nums.push(steps);

  i++;
  if (i == instructions.length) {
    i = 0;
  }
}
console.log(lcmArray(nums));

function gcd(a: number, b: number): number {
  while (b !== 0) {
    const t = b;
    b = a % b;
    a = t;
  }
  return a;
}

// Function to calculate the least common multiple for two numbers
function lcm(a: number, b: number): number {
  return Math.abs(a * b) / gcd(a, b);
}

// Function to calculate the LCM of an array of numbers
function lcmArray(arr: number[]): number {
  return arr.reduce((acc, val) => lcm(acc, val));
}

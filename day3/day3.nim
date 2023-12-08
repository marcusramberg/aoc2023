import std/[strutils, sequtils, tables, strformat]

type NumItem = object
  num: string
  start: (int, int)
var symbolTable = initTable[(int, int), char]()
var foundNums = newSeq[NumItem](0)

for i, line in toSeq("input".lines):
  var inNum = false
  for j, c in toSeq(line.items):
    if isDigit(c):
      if not inNum:
        inNum = true
        foundNums.add(NumItem(num: $c, start: (i, j)))
      else:
        foundNums[foundNums.len - 1].num.add(c)
    elif c != '.':
      symbolTable[(i, j)] = c
      inNum = false
    else:
      inNum = false
var sum: int = 0
for num in foundNums:
  block found:
    for i in num.start[0]-1..num.start[0]+1:
      for j in num.start[1]-1..num.start[1] + num.num.len:
        if (i, j) in symbolTable:
          sum += parseInt(num.num)
          break found
echo sum

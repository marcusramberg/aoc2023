import std/[strutils, sequtils, tables]
type NumItem = object
  num: string
  start: (int, int)
var
  symbolTable = initTable[(int, int), char]()
  foundNums = newSeq[NumItem](0)
  sum: int
  sum2: int
for i, line in toSeq("input".lines):
  var inNum: bool
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
for num in foundNums:
  block found:
    for i in num.start[0]-1..num.start[0]+1:
      for j in num.start[1]-1..num.start[1] + num.num.len:
        if (i, j) in symbolTable:
          sum += parseInt(num.num)
          break found
echo sum
for k, v in symbolTable:
  if v != '*': continue
  let (sx, sy) = k
  var nums = newSeq[int](0)
  for num in foundNums:
    let (nx, ny) = num.start
    if (nx-1..nx+1).contains(sx) and (ny-1..ny+num.num.len).contains(sy):
      nums.add(parseInt(num.num))
  if nums.len == 2:
    sum2 += nums[0] * nums[1]
echo sum2

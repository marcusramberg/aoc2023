import itertools
import re

nums = []
map = []
with open("input") as f:
    ls= f.read().strip().strip().split("\n")
    for i, l in enumerate(ls):
        parts = l.split(" ");
        if parts[0]=="seeds:":
            nums = [int(x) for x in parts[1:]]
        elif parts[-1]=="map:":
            mnums = nums.copy()
            for m in map:
                (dest, source,len) = m
                for j,n in enumerate(nums):
                    if n>= source and n<(source+len):
                        mnums[j]=dest+(n-source)
                        print(f"mapped {n} to {nums[j]}")
            map=[]
            nums=mnums
            print(nums)
            print(l)
        elif parts[0]!="":
            map.append([int(x) for x in parts])
    mnums = nums.copy()
    for m in map:
        (dest, source,len) = m
        for j,n in enumerate(nums):
            if n>= source and n<(source+len):
                mnums[j]=dest+(n-source)
                print(f"mapped {n} to {nums[j]}")
    map=[]
    nums=mnums
    print(nums)
print(min(nums))

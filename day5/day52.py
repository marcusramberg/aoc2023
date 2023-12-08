
ranges = []
maps=[]
map = []
smallest = -1
def transform(num):
    res=num
    for m in maps:
        num = res
        for transforms in m:
            (dest, source,len) = transforms
            if num>= source and num<(source+len):
                # print(f"num:{num} source:{source} len:{len} dest:{dest}")
                res=dest+(num-source)
        # print(res)
    return res

with open("input") as f:
    ls= f.read().strip().strip().split("\n")
    for i, l in enumerate(ls):
        parts = l.split(" ");
        if parts[0]=="seeds:":
            for start,r in zip(parts[1::2], parts[2::2]):
                ranges.append([int(start),int(r)])
        elif parts[-1]=="map:":
            maps.append(map)
            map=[]
        elif parts[0]!="":
            map.append([int(x) for x in parts])
    maps.append(map)
    for r in ranges:
        print(f"r:{r}")
        for i in range(r[0],r[0]+r[1]):
            res = transform(i)
            if res<smallest or smallest==-1:
                smallest=res
        
print(smallest)

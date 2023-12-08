from concurrent.futures import ProcessPoolExecutor

ranges = []
maps=[]
map = []
smallest = -1

def checkValues(r):
    smallest = -1
    print(f"r:{r}")
    for i in range(r[0],r[0]+r[1]):
        result=transform(i, maps)
        if result<smallest or smallest==-1:
            smallest=result
    return smallest
def transform(num, maps):
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

    result=[]
    with ProcessPoolExecutor(15) as exe:
        for res in exe.map(checkValues, ranges):
            print(res)
        
print(smallest)

s = "racecar"
t = "carrace"
if s != t:
    for i in s:
        for j in t:
            if(i == j):
                count =+ 1
                print(count, len(s))
        if(count == len(s)):
            print('ok')
        else:
            print('not ok')
    else:
        print('not ok')
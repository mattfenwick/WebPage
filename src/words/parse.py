c = []
opener()
puttogeth()
        
def opener():
    a = open('C:\\Python26\\languages\\wordsl.txt', 'r')
    b = a.read().split('\n')
    a.close()
    i = 0
    d = []
    for x in b:
        d.append(x)
        if x == '':
            print i
            c.append(d[:-1])
            d = []
        i += 1
    c.append(d)
    

def puttogeth():
    i = 0
    while i < len(c):
        q = c[i][1]
        for x in c[i][2:]:
            q += "\n" + x
        try:
            a = open('fil\\' + c[i][0] + '.txt', 'w')
            a.write(q)
            a.close()
        except IOError:
            a = open('fil\\' + 'Office & Computers.txt', 'w')
            a.write(q)
            a.close()
        i+=1

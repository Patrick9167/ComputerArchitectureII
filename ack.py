#!/usr/bin/env python
def ack(m,n):
    if m == 0:
        return (n + 1, 1)
    elif m > 0 and n == 0:
        a, count = ack(m - 1.0, 1.0)
        return a, count+1
    elif m > 0 and n > 0:
        a1, count1 = ack(m, n - 1.0)
        a2, count2 = ack(m - 1.0, a1)
        return a2, 1 + count1 + count2
print ack(1,1)

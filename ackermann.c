#include <stdio.h>
#include <sys/time.h>
int stack;
int regWins;
int of;
int uf;
int maxDepth;
int count=0;
int rfs=16;




int main(int argc, char const *argv[]) {
struct timeval stop, start;

  int ackermann(int x, int y) {
    int temp;
    regWins++;
    count++;
    if(regWins>rfs)
    {
      regWins--;
      of++;
      stack++;
      if((stack+rfs) > maxDepth)
        maxDepth = (stack+rfs);

    }

    if (x == 0) {
      return y+1;
    } else if (y == 0) {
      temp= ackermann(x-1, 1);
      regWins--;
      if(regWins<2)
      {
        uf++;
        stack--;
        regWins++;
      }
      return temp;
      } else {
      temp = ackermann(x-1, ackermann(x, y-1));
      regWins-=2;
      if(regWins<2)
      {
          uf++;
          stack--;
          regWins++;
      }
      return temp;
    }

  }
  gettimeofday(&start, NULL);
  ackermann(3,6);
  gettimeofday(&stop, NULL);
  int msecs=(int)((stop.tv_usec - start.tv_usec)/100);
  if(msecs<0) msecs=10000-msecs;
  printf("Time Taken: %d.%dms\n", (msecs%10), (msecs/10));
  printf("Procedure calls: %d\nOverflows: %d\nUnderflows: %d\n%d\n%d\nMax Depth: %d\n", count, of, uf, regWins, stack, maxDepth);
  return 0;

}

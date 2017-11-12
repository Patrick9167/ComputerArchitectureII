int stack;
int regWins;
int of;
int uf;
int count=0;
int rfs=8;
int main(int argc, char const *argv[]) {
  /* code */

  int ackermann(int x, int y) {
    int temp;
    regWins++;
    count++;
    if(regWins>rfs)
    {
      regWins--;
      of++;
      stack++;
    }

    if (x == 0) {
      return y+1;
    } else if (y == 0) {
      temp= ackermann(x-1, 1);
      regWins--;
      if(regWins<2 && stack>0)
      {
        uf++;
        stack--;
        regWins++;
      }
      return temp;
      } else {
      temp = ackermann(x-1, ackermann(x, y-1));
      regWins-=2;
      if(regWins<2 && stack>0)
      {
          uf++;
          stack--;
          regWins++;
      }
      return temp;
    }

  }
  printf("%d\n", ackermann(3,6));
  printf("%d\n %d\n %d\n %d\n %d\n", count, of, uf, regWins, stack);
  return 0;
}

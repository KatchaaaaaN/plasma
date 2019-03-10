#include <stdio.h>
#include <math.h>

double E[4],B[4];
void runge( void (*func)(double x0[],double f0[],double t0), double x[],double f[],double t,double wrk1[],double wrk2[], double h, int n);
void larmor(double x[],double f[], double t);

FILE *fp;

int main(){
    fp = fopen("larmor0.txt", "w+");
    
//入力******************************
    int n=7;//添え字０は使わないので＋１の大きさ
    double x[n];
    printf("x = {\n");
    for(int i=1;i<=n-2;i++){
        scanf("%lf",&x[i]);
        printf(", ");
    }
    scanf("%lf",&x[n]);
    printf("}\n");

    printf("E = {\n");
    for(int i=1;i<=2;i++){
        scanf("%lf",&E[i]);
        printf(", ");
    }
    scanf("%lf",&E[3]);
    E[1]=cos(x[2]);
    printf("}\n");

    printf("B = {\n");
    for(int i=1;i<=2;i++){
        scanf("%lf",&B[i]);
        printf(", ");
    }
    scanf("%lf",&B[3]);
    printf("}\n");
//********************************
    double f[n],wrk1[n],wrk2[n],t,h;
    h=0.01;

    fprintf(fp,"%lf %lf %lf %lf\n",t,x[1],x[2],x[3]);
    for(t=h;t<=20;t+=h)
        runge(larmor,x,f,t,wrk1,wrk2,h,n);
        

        printf("%lf\n",B[3]);

    fclose(fp);

    return 0;
}

void runge( void (*func)(double x0[],double f0[],double t0), double x[],double f[],double t,double wrk1[],double wrk2[], double h, int n)
{
    

    int i;
    func(x,wrk2,t);
    for(i=1;i<=n;i++){
        f[i]=x[i]+h*wrk2[i]/6;
        wrk1[i]=x[i]+h*wrk2[i]/2;
    }

    func(wrk1,wrk2,t+h/2);
    for(i=1;i<=n;i++){
        f[i]+=h*wrk2[i]/3;
        wrk1[i]=x[i]+h*wrk2[i]/2;
    }

    func(wrk1,wrk2,t+h/2);
    for(i=1;i<=n;i++){
        f[i]+=h*wrk2[i]/3;
        wrk1[i]=x[i]+h*wrk2[i];
    }
    func(wrk1,wrk2,t+h);
    for(i=1;i<=n;i++)
        x[i]=f[i]+h*wrk2[i]/6;
    
    fprintf(fp,"%lf %lf %lf %lf\n",t,x[1],x[2],x[3]);
}


void larmor(double x[],double f[], double t)//質量、電荷はいずれも１
{
    f[1]=x[4];
    f[2]=x[5];
    f[3]=x[6];
    f[4]=E[1]+x[5]*B[3]-x[6]*B[2];
    f[5]=E[2]+x[6]*B[1]-x[4]*B[3];
    f[6]=E[3]+x[4]*B[2]-x[5]*B[1];
}
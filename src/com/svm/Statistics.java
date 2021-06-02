/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.svm;

/**
 *
 * @author Technowings
 */


public class Statistics 
{
    public static String deltaArray="";
    public static String MiddleGammaArray="";
    public static String lowGammaArray="";
    public static String lowBetaArray="";
    public static String lowAlphaArray="";
    public static String highBetaArray="";
    public static String thetaArray="";
    public static String highAlphaArray="";
    double[] data;
    
    int size;   
public static String AttentionMean="";
public static String MeditationMean="";
public double getSD(double[] data) 
    {
        this.data = data;
        size = data.length;
        getMean();
        getVariance();
        double sd=getStdDev();
        median();
        return sd;
    }   
    double getMean()
    {
        double sum = 0.0;
        for(double a : data)
            sum += a;
        System.out.println("Mean :"+(sum/size));
        return sum/size;
    }

    double getVariance()
    {
        double mean = getMean();
        deltaArray=mean+"";
        AttentionMean=mean+"";
        MeditationMean=mean+"";
        MiddleGammaArray=mean+"";
        lowGammaArray=mean+"";
        lowBetaArray=mean+"";
        lowAlphaArray=mean+"";
        highBetaArray=mean+"";
        thetaArray=mean+"";
        highAlphaArray=mean+"";
        double temp = 0;
        for(double a :data)
            temp += (a-mean)*(a-mean);
        return temp/size;
    }
    double getAmplitude(double[] data1){
         double amplitude = 0;
        for (int j = 0; j < data1.length; j = j +2 ){
            if (data1[j] > data1[j+1])
                amplitude = amplitude + data1[j] - data1[j+1];
            else amplitude = amplitude + data1[j + 1] - data1[j];
        }
        amplitude = amplitude / data1.length * 2;
        return amplitude;
        
    }
    double getStdDev()
    {
//        System.out.println("Sd is:"+Math.sqrt(getVariance()));
        return Math.sqrt(getVariance());
        
    }

    public double median() 
    {
//       Arrays.sort(data);

       if (data.length % 2 == 0) 
       {
          return (data[(data.length / 2) - 1] + data[data.length / 2]) / 2.0;
       } 
       return data[data.length / 2];
    }
    public static void main(String args[]){
        double data[]={53,78,61,74,53,53,60,64,44,30,50,64,70,51,48,44,27,37,63,83,64,54,66,40,50,61,66,44,60,69}; 
        Statistics sta=new Statistics();
       double d1=sta.getSD(data);
//       double d=sta.getAmplitude(data);
        System.out.println("d1:"+d1);
    }
}

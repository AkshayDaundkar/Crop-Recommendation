package com.helper;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import com.constants.ServerConstants;
import com.database.ConnectionManager;

public class PearsonsCorrelation {
	public static void main(String[] args) {
	    double[] x = {1, 2, 4, 8};
	    double[] y = {2, 4, 8, 16};
//	    double corr = new PearsonsCorrelation().correlation(y, x);

//	    System.out.println(corr);
	   // double[] arr = { 18.0, 329.0, 2230.0, 1.0, 4.0};
	    double[] arr = { 18.0, 329.0, 1.0, 4.0, 2230.0};
	    double[][] d= new PearsonsCorrelation().getPiersonCoefficient2(4,arr);
//	    new PearsonsCorrelation().getPiersonCoefficient(10);
//	    new PearsonsCorrelation().getPiersonCoefficient(11);
//	    new PearsonsCorrelation().getPiersonCoefficient(12);
	    System.out.println(d.length);
	    for(int i=0;i<d.length;i++){
	    	System.out.println("d["+i+"][0] = "+d[i][0]+" d["+i+"][1] = "+d[i][1]+" d["+i+"][2] = "+d[i][2]);
	    }
//	    System.out.println(new PearsonsCorrelation().getPiersonCoefficient2(1));
	}
	
	public ArrayList<String> getRatings(ArrayList<String> userArray){
		ArrayList<String> arr = new ArrayList<String>();
		
		return arr; 
	}
	
	
	public static double[][] getPiersonCoefficient2(int userId,double[] currentUserRatings){
		HashMap hm = null, hm1=null;
		List list = DBUtils.
				getMapList("SELECT state,district,cost,season,acre,cname,uid,hid FROM `croprecommendation`.`userhistory` order by uid;");
		
		List totalUser = DBUtils.getMapList("select distinct uid from `croprecommendation`.`userhistory` order by uid") ;
		System.out.println(totalUser.size());
		
		ArrayList<double[]> userrating = new ArrayList<double[]>();
		if(list != null) {
			for(int j=0;j<list.size();j++){
				hm1 = (HashMap) list.get(j);
				String uid = StringHelper.n2s(hm1.get("uid"));
				double[] d=new double[]{StringHelper.n2d(hm1.get("state")),StringHelper.n2d(hm1.get("district")),StringHelper.n2d(hm1.get("cost")),StringHelper.n2d(hm1.get("season")),StringHelper.n2d(hm1.get("acre"))};
	//			System.out.println(d);
				userrating.add(d);			
			}
		}
		int currentUserIndex=0;
//		=null;
		
		
		
		if(currentUserRatings==null){
			return null;
		}
		
		double piersson[][]=new double[totalUser.size()][3];	// Piersson coeefficient for all other users	id=0 piersson id=1 users
		System.out.println("\n-----------------------------------------------------");
		System.out.println("Calculating for User with ID: "+userId+" | "+totalUser);
		for (int i = 0; i < totalUser.size(); i++) {
			hm = (HashMap) totalUser.get(i);
			
			double d[]=userrating.get(i);
			piersson[i][0]=correlation(d, currentUserRatings);
			piersson[i][1]=StringHelper.n2i(hm.get("uid"));
			piersson[i][2]=StringHelper.n2i(hm.get("hid"));
//			users[i]=StringHelper.n2i(usersArray.get(i));
			System.out.print("\n"+piersson[i][0]+"  -  "+piersson[i][1]+"  -  "+piersson[i][2]);
		}
		
		System.out.println();
		System.out.println("-----------------------------------------------------");
		System.out.println(piersson.length);
			
			
		for (int i = 0; i <= piersson.length; i++) {
			for (int j = i+1; j < piersson.length; j++) {
				if(piersson[i][0]<piersson[j][0]){
					double d=piersson[i][0];
					piersson[i][0]=piersson[j][0];
					piersson[j][0]=d;
					System.out.println(piersson[i][0]+" "+piersson[j][0]);
					d=piersson[i][1];
					piersson[i][1]=piersson[j][1];
					piersson[j][1]=d;
					System.out.println(piersson[i][1]+" "+piersson[j][1]);
				}
			}
		}
		
		for (int i = 0; i < piersson.length; i++) {
			if((piersson[i][0]<ServerConstants.PIERSSON_COEF)||(piersson[i][1]==userId)){
				piersson[i][0]=0;
				piersson[i][1]=0;
				
			}	
			System.out.println(piersson[i][0]+" "+piersson[i][1]+" "+piersson[i][2]);
		}			
		return piersson;
	}

	public static double correlation(double[] xs, double[] ys) {
		// TODO: check here that arrays are not null, of the same length etc

		double sx = 0.0;
		double sy = 0.0;
		double sxx = 0.0;
		double syy = 0.0;
		double sxy = 0.0;

		int n = xs.length;

		for (int i = 0; i < n; ++i) {
			double x = xs[i];
			double y = ys[i];

			sx += x;
			sy += y;
			sxx += x * x;
			syy += y * y;
			sxy += x * y;
		}

		// covariation
		double cov = sxy / n - sx * sy / n / n;
		// standard error of x
		double sigmax = Math.sqrt(sxx / n - sx * sx / n / n);
		// standard error of y
		double sigmay = Math.sqrt(syy / n - sy * sy / n / n);

		// correlation is just a normalized covariation
		//System.out.println("\ncov / sigmax / sigmay="+cov / sigmax / sigmay);
		return cov / sigmax / sigmay;
	}
	
	
}

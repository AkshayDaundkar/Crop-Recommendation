package com.database;

import java.io.FileWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Vector;

import javax.swing.JOptionPane;

import com.constants.ServerConstants;
import com.helper.DBUtils;
import com.helper.PearsonsCorrelation;
import com.helper.StringHelper;
import com.model.CropDataSetModel;
import com.model.CropHistoryModel;
import com.model.DataModel;
import com.model.UserModel;
import com.svm.SvmClassifier;
import com.svm.SvmClassifierAll;

public class ConnectionManager {

	public static HashMap hm = null;
	public static ArrayList al = null;
	public static FileWriter writer = null;
	public static final Vector<String> prevrequest = new Vector<>();

	// public static final Vector<String> voiceTagsCommands=new Vector<>();
	public static Connection getDBConnection() {
		Connection conn = null;
		try {
			Class.forName(ServerConstants.db_driver);
			conn = DriverManager.getConnection(ServerConstants.db_url,
					ServerConstants.db_user, ServerConstants.db_pwd);
			System.out.println("Got Connection" + ServerConstants.db_url);
		} catch (SQLException ex) {
			ex.printStackTrace();
			JOptionPane.showMessageDialog(
					null,
					"Please start the mysql Service from XAMPP Console.\n"
							+ ex.getMessage());
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		return conn;
	}
	
	public static String getHistory(HashMap parameters) {
		double state = StringHelper.n2f(parameters.get("state"));
		double dist = StringHelper.n2f(parameters.get("dist"));
		int stateInt = new Double(state).intValue();
		int distInt =  new Double(dist).intValue();
		List<CropHistoryModel> list =
			DBUtils.getBeanList(CropHistoryModel.class,
				" select * from crophistory where state_name= '"+stateInt+"' and district_name='" + distInt + "'");
		StringBuilder data = new StringBuilder();
		data.append("<thead> <tr><th>chid</th><th>State</th><th>District</th><th>Crop</th><th>Season</th><th>Crop</th><th>Area</th><th>Production</th></tr> </thead>");
		data.append("<tbody>");
		for(CropHistoryModel cropHistoryModel: list) {
			
			List<CropDataSetModel> stateList = DBUtils.getBeanList(CropDataSetModel.class,
					"select * from cropdataset where dataid = '"+cropHistoryModel.getState_Name()+"' AND datatype='state' ");
			cropHistoryModel.setState_Name(stateList.get(0).getName());
			
			List<CropDataSetModel> districtList = DBUtils.getBeanList(CropDataSetModel.class,
					"select * from cropdataset where dataid = '"+cropHistoryModel.getDistrict_Name()+"' AND datatype='district' ");
			cropHistoryModel.setDistrict_Name(districtList.get(0).getName());
			
			data.append("<tr>");
			data.append("<td>").append(cropHistoryModel.getChid()).append("</td>");
			data.append("<td>").append(cropHistoryModel.getState_Name()).append("</td>");
			data.append("<td>").append(cropHistoryModel.getDistrict_Name()).append("</td>");
			data.append("<td>").append(cropHistoryModel.getCrop_Year()).append("</td>");
			data.append("<td>").append(cropHistoryModel.getSeason()).append("</td>");
			data.append("<td>").append(cropHistoryModel.getCrop()).append("</td>");
			data.append("<td>").append(cropHistoryModel.getArea()).append("</td>");
			data.append("<td>").append(cropHistoryModel.getProduction()).append("</td>");
			data.append("</tr>");
		}
		data.append("</tbody>");
		return data.toString();
	}

	// SELECT * FROM `torproject`.`requesttable` where date(udate) =
	// date(now());
	public static String getProductName(HashMap parameters) {
		String brandName = StringHelper.n2s(parameters.get("brand"));
		List list = DBUtils.getBeanList(CropDataSetModel.class,
				"SELECT distinct(district)as name FROM cropdataset where state like '"
						+ brandName + "';");
		String dataList = "";
		if (list.size() > 0) {
//			dataList = new String[list.size()];
			for (int i = 0; i < list.size(); i++) {
				CropDataSetModel rm = (CropDataSetModel) list.get(i);
				dataList += rm.getName() + ",";
			}
			return dataList;
		} else {
//			dataList = new String[1];
			dataList = "Data Fetch Failed Please Try Again,";
		}
		return dataList;
	}
	public static UserModel checkLogin(HashMap parameters) {
		String userNameId = StringHelper.n2s(parameters.get("uname"));
		String pass = StringHelper.n2s(parameters.get("password"));

		String query = "SELECT * FROM useraccounts where uname like ? and password = ?";
		UserModel um = null;
		List list = DBUtils.getBeanList(UserModel.class, query, userNameId,
				pass);
		if (list.size() > 0) {
			um = (UserModel) list.get(0);
		}
		return um;
	}

	public static String insertUser(HashMap parameters) {
		System.out.println(parameters);
		String success = "";
		// phone, email, address
		String fname = StringHelper.n2s(parameters.get("fname"));
		String lname = StringHelper.n2s(parameters.get("lname"));
		String name = fname + " " + lname;
		String uname = StringHelper.n2s(parameters.get("uname"));
		String pass = StringHelper.n2s(parameters.get("password"));
		String phone = StringHelper.n2s(parameters.get("phone"));
		String email = StringHelper.n2s(parameters.get("email"));
		String address = StringHelper.n2s(parameters.get("address"));

		System.out.println("param = " + fname + lname + uname + pass);
		String sql = "insert into useraccounts (name, uname, password, email, phone, address) values(?,?,?,?,?,?)";

		int list = DBUtils.executeUpdate(sql, name, uname, pass, email, phone,
				address);
		if (list > 0) {
			success = "User registered Successfully";

		} else {
			success = "Error";
		}
		return success;
	}

	public static String getCombo(String sql) {
		List list = DBUtils.getMapList(sql);
		StringBuffer sb = new StringBuffer();
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			HashMap record = (HashMap) iterator.next();
			String key = StringHelper.n2s(record.get("ke"));
			String value = StringHelper.n2s(record.get("val"));
			sb.append("<option value='" + key + "' onclick=\"getProduct('"+key+"');\">" + value + "</option>");
		}
		return sb.toString();
	}

	public static List getDataSet() {
		return DBUtils.getBeanList(DataModel.class, "select * from dataset");
	}

	public static List getHistoryDataSet() {
		List<CropHistoryModel> list = DBUtils.getBeanList(CropHistoryModel.class,
				"select * from crophistory limit 500");
		for(CropHistoryModel cropHistoryModel : list) {
			List<CropDataSetModel> stateList = DBUtils.getBeanList(CropDataSetModel.class,
					"select * from cropdataset where dataid = '"+cropHistoryModel.getState_Name()+"' AND datatype='state' ");
			cropHistoryModel.setState_Name(stateList.get(0).getName());
			
			List<CropDataSetModel> districtList = DBUtils.getBeanList(CropDataSetModel.class,
					"select * from cropdataset where dataid = '"+cropHistoryModel.getDistrict_Name()+"' AND datatype='district' ");
			cropHistoryModel.setDistrict_Name(districtList.get(0).getName());
		}
		return list;
	}

	public static void main(String[] args) {
		getDBConnection();
		double[] datais = {5.0};
		System.out.println(getFilteredCrop(datais));
	}

	public static String predictCrop(HashMap parameters) {
		double area = StringHelper.n2f(parameters.get("area"));
		double state = StringHelper.n2f(parameters.get("state"));
		double dist = StringHelper.n2f(parameters.get("dist"));
		double cost = StringHelper.n2f(parameters.get("cost"));
		double season = StringHelper.n2f(parameters.get("season"));
		int uid = StringHelper.n2i(parameters.get("uid"));
		double features1[] = { state, dist,cost, season, area}; //cf
		double features[] = { state, dist,season, area,cost}; //svm
		
		System.out.println("##################################"+state);
		if(state==18.0){
			String output = SvmClassifier.applySvmClassifier(features);
			String crop = getCrop(output);
			System.out.println();
			DBUtils.executeUpdate(
					"insert into crophistory (State_name, district_name, crop_year, season, crop, area, production) values(?, ?, ?, ?, ?, ?,?)", 
					state, dist, "2011", season, crop, area, cost);
			double[][] resu = PearsonsCorrelation.getPiersonCoefficient2(uid, features1);
			System.out.println(resu.length);
			double[] datais = new double[resu.length];
			for(int i=0;i<=resu.length-2;i++){
				if(resu[i][1]!= 0.0){
					datais[i] = resu[i][1];
				}
			}
			HashMap colab = getFilteredCrop(datais);
			output = "Crop Predicted by SVM : <BR> "+crop+"<BR> <BR> <BR> Crop Predicted by Collaborative Filtering is : <BR> "+colab.keySet();	
			System.out.println("output :" + output);
			return output;
		}else{
			String output = SvmClassifierAll.applySvmClassifier(features);
			String crop = getCrop(output);
			System.out.println();
			DBUtils.executeUpdate(
					"insert into crophistory (State_name, district_name, crop_year, season, crop, area, production) values(?, ?, ?, ?, ?, ?,?)", 
					state, dist, "2011", season, crop, area, cost);
			double[][] resu = PearsonsCorrelation.getPiersonCoefficient2(uid, features1);
			System.out.println(resu.length);
			double[] datais = new double[resu.length];
			for(int i=0;i<=resu.length-1;i++){
				if(resu[i][1]!= 0.0){
					datais[i] = resu[i][1];
				}
			}
			HashMap colab = getFilteredCropall(datais);
			output = "Crop Predicted by SVM : <BR> "+crop+"<BR> <BR> <BR> Crop Predicted by Collaborative Filtering is : <BR> "+colab.keySet();	
			System.out.println("output :" + output);
			return output;
		}
		//			String output = SvmClassifier.applySvmClassifier(features);
		//String crop = getCrop(output);
		//hid, state, district, cost, season, acre, cname
		//System.out.println();
		//DBUtils.executeUpdate("insert into userhistory (state, district, cost, season, acre, cname,uid) values(?, ?, ?, ?, ?, ?,?)", state,dist,cost,season,area,output,uid);
		
		
		// return "";
	}

	private static HashMap getFilteredCrop(double[] datais) {
		// TODO Auto-generated method stub
		HashMap result = new HashMap();
		for (int i = 0; i < datais.length; i++) {
			System.out.println(datais[i]);
			List l = DBUtils.getMapList( "select * from userhistory where uid like '"+StringHelper.n2i(datais[i])+ "';");
			if(l.size()>0){
				for (int j = 0; j < l.size(); j++) {
					HashMap map = (HashMap) l.get(j);
					List ll = DBUtils.getBeanList(CropDataSetModel.class, "select name from cropdataset where dataid like '"+map.get("cname")+"' and datatype like 'crop'");
					CropDataSetModel c  = (CropDataSetModel) ll.get(0);
					
					result.put(c.getName(), "");
				}
			}
		}
		return result;
	}

	private static HashMap getFilteredCropall(double[] datais) {
		// TODO Auto-generated method stub
		HashMap result = new HashMap();
		for (int i = 0; i < datais.length; i++) {
			System.out.println(datais[i]);
			List l = DBUtils.getMapList( "select * from userhistoryall where uid like '"+StringHelper.n2i(datais[i])+ "';");
			if(l.size()>0){
				for (int j = 0; j < l.size(); j++) {
					HashMap map = (HashMap) l.get(j);
					List ll = DBUtils.getBeanList(CropDataSetModel.class, "select name from cropdataset where dataid like '"+map.get("cname")+"' and datatype like 'crop'");
					CropDataSetModel c  = (CropDataSetModel) ll.get(0);
					
					result.put(c.getName(), "");
				}
			}
		}
		return result;
	}
	public static String getCrop(String cropId) {
		List list = DBUtils.getBeanList(CropDataSetModel.class,
				"SELECT * FROM `cropdataset` where dataid like '" + cropId
						+ "' and datatype like 'crop'; ");
		System.out.println("*************"+cropId);
		if(list.size()>0){
			CropDataSetModel dm = (CropDataSetModel) list.get(0);
			return dm.getName();
		}
		return "";
	}

	public static String addNewCrop(HashMap parameters) {
		String success = "";
		System.out.println(parameters);
		// cid, cname, state, district, cost, season, acre
		String name = StringHelper.n2s(parameters.get("name"));
		String state = StringHelper.n2s(parameters.get("state"));
		String dist = StringHelper.n2s(parameters.get("dist"));
		double cost = StringHelper.n2f(parameters.get("cost"));
		String season = StringHelper.n2s(parameters.get("season"));
		// double aera=1;

		for (int area = 1; area <= 10; area++) {
			double c = cost * area;
			String sql = "insert into crop (cname, state, district, cost, season, acre) values(?,?,?,?,?,?)";
			int list = DBUtils.executeUpdate(sql, name, state, dist, c, season,
					area);
		}
		return "1";
	}

	public static void closeConnection(Connection conn) {
		try {
			conn.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

}

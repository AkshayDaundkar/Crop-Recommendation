package com.model;

public class CropHistoryModel {
Integer chid;
String State_Name, District_Name, Crop_Year, Season, Crop, Area, Production;

public Integer getChid() {
	return chid;
}

public void setChid(Integer chid) {
	this.chid = chid;
}

public String getState_Name() {
	return State_Name;
}

public void setState_Name(String state_Name) {
	State_Name = state_Name;
}

public String getDistrict_Name() {
	return District_Name;
}

public void setDistrict_Name(String district_Name) {
	District_Name = district_Name;
}

public String getCrop_Year() {
	return Crop_Year;
}

public void setCrop_Year(String crop_Year) {
	Crop_Year = crop_Year;
}

public String getSeason() {
	return Season;
}

public void setSeason(String season) {
	Season = season;
}

public String getCrop() {
	return Crop;
}

public void setCrop(String crop) {
	Crop = crop;
}

public String getArea() {
	return Area;
}

public void setArea(String area) {
	Area = area;
}

public String getProduction() {
	return Production;
}

public void setProduction(String production) {
	Production = production;
}
}

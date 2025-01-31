package org.mve.dom.pojo;

import javax.persistence.Table;

@Table(name = "COUNTRY")
public class Country
{
	public int ID;
	public String NICKNAME;
	public String FULLNAME;
	public String CODE2;
	public String CODE3;
	public String SN;
}

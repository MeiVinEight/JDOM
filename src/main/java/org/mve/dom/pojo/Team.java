package org.mve.dom.pojo;

import javax.persistence.Column;
import javax.persistence.Table;

@Table(name = "TEAM")
public class Team
{
	public int ID;
	@Column(name = "NAME")
	public String name;
	@Column(name = "CATEGORY")
	public String category;
	@Column(name = "AFFILIATION")
	public String affiliation;
	@Column(name = "COUNTRY")
	public String country;
	@Column(name = "LOCATION")
	public String location;
}

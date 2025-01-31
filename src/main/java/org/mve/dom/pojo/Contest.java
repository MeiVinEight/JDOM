package org.mve.dom.pojo;

import lombok.Data;

import javax.persistence.Table;

@Data
@Table(name = "CONTEST")
public class Contest
{
	public int ID;
	public String NAME;
	public long CREATE;
	public long ACTIVE;
	public long START;
	public long END;
	public CPROBLEM[] PROBLEM;
}

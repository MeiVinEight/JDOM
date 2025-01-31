package org.mve.dom.pojo;

import lombok.Data;

import javax.persistence.Table;

@Data
@Table(name = "CPROBLEM")
public class CPROBLEM
{
	public int PID;
	public int CID;
	public int IDX;
	public String NAME;
	public int COLOR;
}

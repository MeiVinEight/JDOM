package org.mve.dom.pojo;

import com.baomidou.mybatisplus.extension.activerecord.Model;
import lombok.Data;
import lombok.EqualsAndHashCode;

import javax.persistence.Column;
import javax.persistence.Table;

@EqualsAndHashCode(callSuper = false)
@Data
@Table(name = "SUBMISSION")
public class Submission extends Model<Submission>
{
	@Column(name = "ID")
	public long ID;
	@Column(name = "STATUS")
	public int status;
}

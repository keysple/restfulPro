package cn.jxufe.database.entity;

import javax.persistence.Entity;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name = "T_Department")
@NamedQueries({
    @NamedQuery(name = "Department.findAll", query = "SELECT department FROM Department department"),    
    @NamedQuery(name = "Department.findIDByDepartmentName", query = "SELECT department FROM Department department where departmentName = :departmentName")
})

public class Department extends IdEntity {

	private String departmentName ="";

	public String getDepartmentName() {
		return departmentName;
	}

	public void setDepartmentName(String departmentName) {
		this.departmentName = departmentName;
	}	
}

package cn.jxufe.restful.api;

import java.util.List;

import javax.ejb.Stateful;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import cn.jxufe.database.entity.Department;
import cn.jxufe.database.helper.EM;

@Stateful
@Path("/app/department")
public class DepartmentAPI {
	
	@GET
	@Path("/list")
	@Produces("application/json;charset=UTF-8")
	public List<Department> getList() {	
	    return EM.getEntityManager().createNamedQuery("Department.findAll", Department.class).getResultList();
	}
	
	@POST
	@Path("/add")
	@Consumes("application/json;charset=UTF-8")
	@Produces("text/html;charset=UTF-8")
	public String add(Department department) throws Exception {
		department.setId(0);
		EM.getEntityManager().persist(EM.getEntityManager().merge(department));
	    EM.getEntityManager().getTransaction().commit();
	    return Long.toString(department.getId());
	}
	
	@POST
	@Path("/save")
	@Consumes("application/json;charset=UTF-8")
	@Produces("text/html;charset=UTF-8")
	public String save(Department department) throws Exception {
		EM.getEntityManager().persist(EM.getEntityManager().merge(department));
	    EM.getEntityManager().getTransaction().commit();
	    return Long.toString(department.getId());
	}
	
	@POST
	@Path("/delete")
	@Consumes("application/json;charset=UTF-8")
	@Produces("text/html;charset=UTF-8")
	public String delete(Department department) throws Exception {
		department =(Department)EM.getEntityManager() .createNamedQuery("Department.findIDByDepartmentName", Department.class)
				.setParameter("departmentName",  department.getDepartmentName()).getResultList().get(0);
		EM.getEntityManager().remove(EM.getEntityManager().merge(department));
	    EM.getEntityManager().getTransaction().commit();
	    return Long.toString(department.getId());
	}
	
	
}

package cn.jxufe.restful.api;

import java.util.List;

import javax.ejb.Stateful;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import cn.jxufe.database.entity.Employee;
import cn.jxufe.database.helper.EM;
import net.sf.json.JSONObject;

@Stateful
@Path("/app/employee")
public class EmployeeAPI {
	
	@GET
	@Path("/list")
	@Produces("application/json;charset=UTF-8")
	public List<Employee> getList() {	
	    return EM.getEntityManager().createNamedQuery("Employee.findAll", Employee.class).getResultList();
	}
	
	@POST
	@Path("/add")
	@Consumes("application/json;charset=UTF-8")
	@Produces("text/html;charset=UTF-8")
	public String add(Employee employee) throws Exception {
		employee.setId(0);
		EM.getEntityManager().persist(EM.getEntityManager().merge(employee));
	    EM.getEntityManager().getTransaction().commit();
	    return Long.toString(employee.getId());
	}
	
	@POST
	@Path("/save")
	@Consumes("application/json;charset=UTF-8")
	@Produces("text/html;charset=UTF-8")
	public String save(Employee employee) throws Exception {
		//System.out.print(JSONObject.fromObject(employee).toString());
		EM.getEntityManager().persist(EM.getEntityManager().merge(employee));
	    EM.getEntityManager().getTransaction().commit();
	    return Long.toString(employee.getId());
	}
	
	@POST
	@Path("/delete")
	@Consumes("application/json;charset=UTF-8")
	@Produces("text/html;charset=UTF-8")
	public String delete(Employee employee) throws Exception {
		EM.getEntityManager().remove(EM.getEntityManager().merge(employee));
	    EM.getEntityManager().getTransaction().commit();
	    return Long.toString(employee.getId());
	}
	
	
}

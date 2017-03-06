<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="js/jquery-3.1.0.min.js" type="text/javascript"></script>
<script src="js/jquery.form.js" type="text/javascript"></script>
<title>用户管理</title>
<style>
#employeeList{
	top:-10px;
	border:0px solid green;
}

.employeeCard{
	float:left;
	border:1px solid blue;
	padding:2px;
	margin:2px;
}
.employeeCard input {
	width: 60px;
}

.employeeCard select{
	width: 65px;
}

.employeeCard button {
	color:red;
	width: 185px;
}

.controller input{
	float:right;
	width: 60px;
}

</style>
<script>

$(document).ready(function(){
	refreshDepartment();	
});

 function Employee(id,employeeCode,employeeName,sex,salary,photo,department){
	 var o = {};
	 o.id = id;
	 o.employeeCode = employeeCode;
	 o.employeeName = employeeName;
	 o.sex = sex;
	 o.salary = salary;
	 o.photo = photo;
	 o.department = department;
	 return o;
 }
 
 function Department(id,departmentName){
	 var o = {};
	 o.id = id;
	 o.departmentName = departmentName;
	 return o;
 }
 
 function refreshDepartmentList(data){	 
	 var selector = $("#employeeEmpty").find("#employeeDepartment");
	 selector.html("");
	 $(data).each(function (index,department){
		 var option="<option>"+department.departmentName+"</option>";
		 selector.append(option);
	 });
	 refreshEmployee();
 }
 
 function createDepartment(){
	 var departmentName = prompt("输入部门名称","");
	 var department = new Department(0,departmentName );
	 request(department,"POST","app/department/add",refreshDepartment);	 
 }
 
 function deleteDepartment(departmentName){
	 var department = new Department(0,departmentName);
	 request(department,"POST","app/department/delete",refreshDepartment);	
 }
 
 function refreshEmployeeList(data){	 
	 var list =$("#employeeList");
	 list.html("");
	 $(data).each(function (index,employee){
		 var card = $("#employeeEmpty").clone(true);
		 card.attr("id","employeeCard"+employee.id);
		 card.find("#employeeID").val(employee.id);
		 card.find("#employeeCode").val(employee.employeeCode);
		 card.find("#employeeName").val(employee.employeeName);
		 card.find("#employeeSex").val(employee.sex);
		 card.find("#employeeSalary").val(employee.salary);
		 card.find("#employeePhoto").attr("photoUrl",employee.photo);
		 card.find("#employeePhotoImg").attr("src",employee.photo);
		 card.find("#employeeDepartment").val(employee.department);
		 card.find("#btCreateDepartment").css("display","none");
		 card.find("#btDeleteDepartment").css("display","none");
		 card.find("#btCreate").css("display","none");
		 card.find("#btModify").css("display","");
		 card.find("#btDelete").css("display","");
		 card.find("#btModify").attr("employeeID",employee.id);
		 card.find("#btDelete").attr("employeeID",employee.id);		
		  
		 list.append(card);
	 });
 }

 function refreshDepartment () {
	 request({},"GET","app/department/list",refreshDepartmentList);
 }
 
 function refreshEmployee () {
	 request({},"GET","app/employee/list",refreshEmployeeList);
 }
 
 function createEmployee(){
	 var employee = new Employee(0,
			 $("#employeeEmpty").find("#employeeCode").val(),
			 $("#employeeEmpty").find("#employeeName").val(),
			 $("#employeeEmpty").find("#employeeSex").val(),
			 $("#employeeEmpty").find("#employeeSalary").val(),
			 $("#employeeEmpty").find("#employeePhoto").attr("photoUrl"),
			 $("#employeeEmpty").find("#employeeDepartment").val()
	 );
	 request(employee,"POST","app/employee/add",refreshEmployee);	 
 }
 
 function modifyEmployee(id){
	 console.log(id);
	 var card =$("#employeeCard"+id);
	 console.log(card.find("#employeeDepartment").val());
	 var employee = new Employee(card.find("#employeeID").val(),
			 card.find("#employeeCode").val(),
			 card.find("#employeeName").val(),
			 card.find("#employeeSex").val(),
			 card.find("#employeeSalary").val(),
			 card.find("#employeePhoto").attr("photoUrl"),
			 card.find("#employeeDepartment").val()
			 );	 
	 console.log(employee);
	 request(employee,"POST","app/employee/save",refreshEmployee);
 }
 
 function deleteEmployee(id){
	 var employee = new Employee(id);
	 request(employee,"POST","app/employee/delete",refreshEmployee);	
 }
 
 function savePhoto(obj){
	 var url =prompt("粘帖入照片的URL地址","");
 	 obj.attr('photoUrl',url);
 	 return false;
 }
 
 function request(object,method,methodURL,successFunction){	
	$.ajax({
        cache: true,
        type: method,
        datatype:"json",
        contentType: "application/json",
        url:methodURL,
        data:JSON.stringify(object),
        error: function(XMLHttpRequest, textStatus, errorThrown) {
        	 alert(XMLHttpRequest.status+"\r\n"+XMLHttpRequest.readyState+"\r\n"+textStatus);
        },
        success: successFunction
    });			
 }
 
</script>
</head>
<body>

<div width="100%" height="100px" style="border:0px solid red;">
	<form id="employeeForm">
	<div id="employeeEmpty"  class="employeeCard" >
		<img id="employeePhotoImg" src="images/employeeEmpty.jpg" height="130px" style="float:left">
		<div style="float:left">
			<input id = "employeeID"  type="hidden">
			编号：<input id = "employeeCode"  type="text" value="000" >
			姓名：<input id = "employeeName" type="text" ><br/>
			性别：<select id = "employeeSex" ><option>男</option><option>女</option></select>
			工资：<input id = "employeeSalary" type="text" value="100" ><br/>
			照片：<button id="employeePhoto" onclick="return savePhoto($(this));">上传照片</button><br/>
			部门：<select id = "employeeDepartment" ></select>
			<input id="btCreateDepartment" type="button" value="+"  onclick="createDepartment()">
			<input id="btDeleteDepartment" type="button" value="-"  onclick="deleteDepartment($('#employeeEmpty').find('#employeeDepartment').val())">
		</div>		
		<div class="controller">
			<input id="btCreate" type="button" value="添加" onclick="createEmployee()">
			<input id="btModify" type="button" value="修改" style="display:none"  onclick="modifyEmployee($(this).attr('employeeID'))">
			<input id="btDelete" type="button" value="删除" style="display:none"  onclick="deleteEmployee($(this).attr('employeeID'))">
		</div>
	</div>	
	</form>
	<div id="employeeList"></div>
</div>
</body>
</html>
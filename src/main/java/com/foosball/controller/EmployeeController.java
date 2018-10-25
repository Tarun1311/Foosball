package com.foosball.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.foosball.model.Employee;
import com.foosball.service.EmployeeService;

@Controller
@RequestMapping(value = "/employee")
public class EmployeeController {

	@Autowired
	EmployeeService employeeService;
	
	@RequestMapping(value="/", method=RequestMethod.GET)
	public ModelAndView toAddPlayers(){
		List<Employee> emps = employeeService.getEmployees();
		ModelAndView model = new ModelAndView("addplayers");
		model.addObject("listPlayers",emps);
		return model;
	}
	
	@RequestMapping(value="/save", method=RequestMethod.POST)
	public String save(@RequestParam(value = "id", required = false) Integer id, @RequestParam("employeeId") String employeeId, @RequestParam("employeeName") String employeeName){
		Employee employee = new Employee();
		if(id!=null)
			employee.setId(id);
		employee.setEmployeeId(employeeId);
		employee.setEmployeeName(employeeName);
		List<Employee> e = employeeService.getByEmployeeId(employeeId);
		if(e.isEmpty() || (!e.isEmpty() && id!=null && e.get(0).getId()==id)){
			employeeService.saveEmployee(employee);
			return "redirect:/employee/list";
		}
			return "redirect:/employee/error";
	}
	
	@RequestMapping(value="/update", method=RequestMethod.POST)
	public void update(@ModelAttribute("employee") Employee employe){
		employeeService.updateEmployee(employe);
	}
	
	@RequestMapping(value="/delete", method=RequestMethod.GET)
	public String delete(@RequestParam("id") int id){
		employeeService.deleteEmployee(id);
		return "redirect:/employee/list";
	}
	
	@RequestMapping(value="/get/{id}", method=RequestMethod.GET)
	public void getById(@PathVariable("id") int id){
		employeeService.getById(id);
	}
	
	@RequestMapping(value="/list", method=RequestMethod.GET)
	public void list(HttpServletResponse response) throws IOException{
		List<Employee> emps = employeeService.getEmployees();
		JSONArray array = new JSONArray();
		response.setContentType("application/json");
		for(Employee e:emps){
			JSONObject obj = new JSONObject();
			obj.put("id", e.getId());
			obj.put("employeeId", e.getEmployeeId());
			obj.put("employeeName", e.getEmployeeName());
			array.put(obj);
		}
		JSONObject object = new JSONObject();
		object.put("error", false);
		object.put("list", array);
		response.getWriter().print(object);
	}
	
	@RequestMapping(value="/error", method=RequestMethod.GET)
	public void error(HttpServletResponse response) throws IOException{
		response.setContentType("application/json");
		JSONObject obj = new JSONObject();
		obj.put("error", true);
		response.getWriter().print(obj);
	}
}

package com.foosball.service;

import java.util.List;


import com.foosball.model.Employee;

public interface EmployeeService {
	
	//method to save employee  
		public void saveEmployee(Employee e);
		//method to update employee  
		public void updateEmployee(Employee e);
		//method to delete employee  
		public void deleteEmployee(int id);
		//method to return one employee of given id  
		public Employee getById(int id);
		public List<Employee> getByEmployeeId(String employeeId);
		//method to return all employees  
		public List<Employee> getEmployees();
}

package com.foosball.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.foosball.dao.IEmployeeDao;
import com.foosball.model.Employee;
@Service
public class EmployeeServiceImpl implements EmployeeService{
	
	@Autowired 
	private IEmployeeDao employeeDao;
	//method to save employee  
		public void saveEmployee(Employee e){
			employeeDao.saveEmployee(e);
		}
		//method to update employee  
		public void updateEmployee(Employee e){
			employeeDao.updateEmployee(e);
		}
		//method to delete employee  
		public void deleteEmployee(int id){
			employeeDao.deleteEmployee(id);
		}
		//method to return one employee of given id  
		public Employee getById(int id){
			return employeeDao.getById(id);
		}
		public List<Employee> getByEmployeeId(String employeeId){
			return employeeDao.getByEmployeeId(employeeId);
		}
		//method to return all employees  
		public List<Employee> getEmployees(){
			return employeeDao.getEmployees();
		}

}

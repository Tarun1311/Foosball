package com.foosball.dao;

import java.util.List;

import javax.persistence.Query;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.foosball.model.Employee;

@Repository
@Transactional
public class EmployeeDao implements IEmployeeDao {

@Autowired
HibernateTemplate template;  
	
	public void setTemplate(HibernateTemplate template) {  
	    this.template = template;  
	}  
	//method to save employee  
	public void saveEmployee(Employee e){  
		try{
			template.saveOrUpdate(e);
		}catch(DataIntegrityViolationException ex){
		}catch(Exception ex){
		}
	}  
	//method to update employee  
	public void updateEmployee(Employee e){  
	    template.update(e);  
	}  
	//method to delete employee  
	public void deleteEmployee(int id){
		String hql = "UPDATE Employee set deleted = true WHERE id = :employeeId";
		Query query = template.getSessionFactory().getCurrentSession().createQuery(hql);
		query.setParameter("employeeId", id);
		query.executeUpdate();
//		Employee e=(Employee)template.get(Employee.class, id);
//	    template.delete(e);  
	}  
	//method to return one employee of given id  
	public Employee getById(int id){  
	    Employee e=(Employee)template.get(Employee.class,id);  
	    return e;  
	} 
	
	@SuppressWarnings("unchecked")
	public List<Employee> getByEmployeeId(String employeeId){ 
		String hql = "FROM Employee E where employeeId = :employeeId";
		Query query = template.getSessionFactory().getCurrentSession().createQuery(hql);
		query.setParameter("employeeId", employeeId);
		return query.getResultList();
//	    Employee e=(Employee)template.get(Employee.class,id);  
//	    return e;  
	}
	//method to return all employees  
	@SuppressWarnings("unchecked")
	public List<Employee> getEmployees(){  
//	    List<Employee> list=new ArrayList<Employee>();
	    String hql = "FROM Employee E WHERE deleted = false order by id desc";
//	    list=template.loadAll(Employee.class);  
	    Query query = template.getSessionFactory().getCurrentSession().createQuery(hql);
	    return query.getResultList();  
	}
}

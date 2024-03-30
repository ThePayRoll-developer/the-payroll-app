package com.shohab.CreateApi.services;

import com.shohab.CreateApi.model.Employee;
import com.shohab.CreateApi.repository.EmployeeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeService {
    @Autowired
    private EmployeeRepository employeeRepo;

    public void saveEmployee(Employee employee) {
        employeeRepo.save(employee);

    }

    public List<Employee> getAllEmployee() {
        return employeeRepo.findAll();
    }

    public void deleteById(long id) {
        employeeRepo.deleteById(id);
    }

    public Employee findBy(long id) {
        return employeeRepo.findById(id).get();
    }

    //This method for showing employees according to departments
    public List<Employee> getEmployeesByDepartment(int id) {
        return employeeRepo.findByDepartmentId(id);
    }
}

package com.shohab.CreateApi.RestController;

import com.shohab.CreateApi.model.Department;
import com.shohab.CreateApi.model.Employee;
import com.shohab.CreateApi.repository.EmployeeRepository;
import com.shohab.CreateApi.repository.IDepartmentRepo;
import org.apache.velocity.exception.ResourceNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/employee")
@CrossOrigin("*")
public class EmployeeRestController {

    @Autowired
    private EmployeeRepository employeeRepository;

    @Autowired
    IDepartmentRepo iDepartmentRepo;

//    @PostMapping("/saveEmployee")
//    public ResponseEntity<String> saveEmployee(@RequestBody Employee employee) {
//        employeeRepository.save(employee);
//        return ResponseEntity.ok("Employee saved successfully.");
//    }

    @PostMapping("")
    public ResponseEntity<Employee> saveEmployee(@RequestBody Employee employee) {

        String name = employee.getDepartment().getDeptName();
        Department department = iDepartmentRepo.findByDeptName(name);

        employee.setDepartment(department);

        Employee savedEmployee = employeeRepository.save(employee);
        return ResponseEntity.ok(savedEmployee);

    }

    // flutter rest api
    @GetMapping("/{email}")
    public ResponseEntity<Employee> getEmployees(@PathVariable String email) {
        Employee employees = employeeRepository.findByEmail(email);
        return ResponseEntity.ok(employees);
    }
    // flutter rest api

//    @PostMapping("")
//    public ResponseEntity<String> saveEmployee(@RequestBody Employee employee){
//
//        Department department = employee.getDepartment();
//        if (department == null) {
//            // Handle the scenario where the department is not provided
//            return ResponseEntity.ok(department).badRequest().body("Department is required");
//        }
//
//        String departmentName = department.getDeptName();
//        if (departmentName == null) {
//            // Handle the scenario where the department name is not provided
//            return ResponseEntity.ok(departmentName).badRequest().body("Department name is required");
//        }
//
//        Department existingDepartment = iDepartmentRepo.findByDeptName(departmentName);
//        if (existingDepartment == null) {
//            // Handle the scenario where the department with the given name does not exist
//            return ResponseEntity.notFound().build();
//        }
//
//        // Set the existing department to the employee
//        employee.setDepartment(existingDepartment);
//
//        // Save the employee object
//        Employee savedEmployee = employeeRepository.save(employee);
//        return ResponseEntity.ok(savedEmployee).badRequest().body("Employee Saved");
//    }


    @GetMapping("")
    public ResponseEntity<List<Employee>> getAllEmployees() {
        List<Employee> employees = employeeRepository.findAll();
        return ResponseEntity.ok(employees);
    }

//    @PutMapping("/{id}")
//    public ResponseEntity<Employee> updateEmployee(@PathVariable Long id, @RequestBody Employee updatedEmployee) {
//        Employee employee = employeeRepository.findById(id)
//                .orElseThrow(() -> new ResourceNotFoundException("Employee not found with id: " + id));
//
//        String name = updatedEmployee.getDepartment().getDeptName();
//        Department department = iDepartmentRepo.findByDeptName(name);
//
//        employee.setDepartment(department);
//        employee.setName(updatedEmployee.getName());
//        // Set other fields as needed
//
//        Employee updated = employeeRepository.save(employee);
//        return ResponseEntity.ok(updated);
//    }

    @PutMapping("/{id}")
    public ResponseEntity<Employee> updateEmployee(@PathVariable Long id, @RequestBody Employee updatedEmployee) {
        // Check if the employee exists in the database
        Employee employee = employeeRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Employee not found with id: " + id));

        // Update the department if needed
        Department department = updatedEmployee.getDepartment();
        if (department != null) {
            Department existingDepartment = iDepartmentRepo.findById(department.getId())
                    .orElseThrow(() -> new ResourceNotFoundException("Department not found with id: " + department.getId()));
            employee.setDepartment(existingDepartment);
        }

        // Update other fields
        employee.setName(updatedEmployee.getName());
        employee.setJoiningDate(updatedEmployee.getJoiningDate());
        employee.setEmail(updatedEmployee.getEmail());
        employee.setGender(updatedEmployee.getGender());
        employee.setContact(updatedEmployee.getContact());
        employee.setSalary(updatedEmployee.getSalary());

        // Save the updated employee
        Employee updated = employeeRepository.save(employee);

        // Return the updated employee in the response
        return ResponseEntity.ok(updated);
    }


    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteEmployee(@PathVariable Long id) {
        Employee employee = employeeRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Employee not found with id: " + id));

        employeeRepository.delete(employee);
        return ResponseEntity.ok().build();
    }

    @GetMapping("/emp_details")
    public List<Object[]> getEmpDetails() {
        List<Object[]> employeeLIst = employeeRepository.findEmployeeDetails();
        return employeeLIst;

    }


}

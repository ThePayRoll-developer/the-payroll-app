package com.shohab.CreateApi.RestController;


import com.shohab.CreateApi.model.Employee;
import com.shohab.CreateApi.model.Salary;
import com.shohab.CreateApi.repository.EmployeeRepository;
import com.shohab.CreateApi.repository.SalaryRepository;
import com.shohab.CreateApi.services.SalaryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/salaries")
@CrossOrigin("*")
public class SalaryRestController {


    @Autowired
    public SalaryRepository salaryRepository;

    @Autowired
    private EmployeeRepository employeeRepository;
    @Autowired
    private SalaryService salaryService;

    //   This method will show how much took advance and got bonus and calculated final salary
//    @PostMapping("")
//    public ResponseEntity<String> paySalary(@RequestBody Salary salaryPayment) {
//        String employeeName = salaryPayment.getEmployee().getName();
//        Long employeeId = salaryPayment.getEmployee().getId();
//
//        // Fetch the employee by ID or name. Here i used findByName method for getting employee name.
//        // if i want to unique result from this, i hava to use findById method
//        Optional<Employee> optionalEmployee = employeeRepository.findByName(employeeName);
//        if (optionalEmployee.isEmpty()) {
//            return ResponseEntity.badRequest().body("Employee not found");
//        }
//
//
//        //This section is created for getting employee by fetching by employee name.
//        Employee employee = optionalEmployee.get();
//        employee = employeeRepository.save(employee);
//        salaryPayment.setEmployee(employee);
//
//        // Initialize final salary as the original salary amount
//        BigDecimal finalSalary = salaryPayment.getAmount();
////        BigDecimal empBonus=salaryPayment.getEmpBonus();
////        BigDecimal empAdvance=salaryPayment.getEmpAdvance();
//
//        StringBuilder message = new StringBuilder();
//
//        // Check if the employee has taken an advance
//        if (salaryService.hasTakenAdvance(employee)) {
//            BigDecimal advanceAmount = salaryService.getAdvanceAmount(employee);
//            finalSalary = finalSalary.subtract(advanceAmount);
//            message.append("Advance amount deducted: ").append(advanceAmount).append("\n");
//        }
//
//        // Check if the employee has taken a bonus
//        if (salaryService.hasTakenBonus(employee)) {
//            BigDecimal bonusAmount = salaryService.getBonusAmount(employee);
//            finalSalary = finalSalary.add(bonusAmount);
//            message.append("Bonus amount added: ").append(bonusAmount).append("\n");
//        }
//
//        // Save the final salary to the salaryPayment object
//        salaryPayment.setTotalAmount(finalSalary);
////        salaryPayment.setEmpAdvance(empAdvance);
////        salaryPayment.setEmpBonus(empBonus);
//
//        // Save the salaryPayment object to the database
//        salaryRepository.save(salaryPayment);
//
//        // Process salary payment
//        // Your code to pay salary goes here
//
//        message.append("Final Salary calculated and paid successfully: ").append(finalSalary);
//
//
//
//    }

    @PostMapping("/salary_save")
    public ResponseEntity<Salary> saveEmpSalary(@RequestBody Salary salary) {
        String employeeName = salary.getEmployee().getName();
        Employee employee = employeeRepository.findByName(employeeName).get();
        salary.setEmployee(employee);
        salaryRepository.save(salary);
        return ResponseEntity.ok(salary);

    }

    @GetMapping("")
    public ResponseEntity<List<Salary>> getAllSalaries() {
        List<Salary> salaries = salaryRepository.findAll();
        return ResponseEntity.ok(salaries);
    }

    // flutter rest api
    @GetMapping("/emp/{email}")
    public ResponseEntity<List<Salary>> getAllSalaryByEmp(@PathVariable String email) {
        List<Salary> salaries = salaryRepository.findSalaryByEmp(email);
        return ResponseEntity.ok(salaries);
    }
    // flutter rest api


    // Update method
    @PutMapping("/{id}")
    public ResponseEntity<String> updateSalary(@PathVariable Long id, @RequestBody Salary updatedSalary) {
        Optional<Salary> optionalSalary = salaryRepository.findById(id);
        if (optionalSalary.isEmpty()) {
            return ResponseEntity.notFound().build();
        }

        Salary existingSalary = optionalSalary.get();
        // Update the existing salary with the new data
        existingSalary.setEmployee(updatedSalary.getEmployee());
        existingSalary.setAmount(updatedSalary.getAmount());
        existingSalary.setDate(updatedSalary.getDate());
//        existingSalary.setTotalAmount(updatedSalary.getTotalAmount());
        // Update other fields as needed

        // Save the updated salary
        salaryRepository.save(existingSalary);

        return ResponseEntity.ok("Salary updated successfully");
    }

    // Delete method
    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteSalary(@PathVariable Long id) {
        Optional<Salary> optionalSalary = salaryRepository.findById(id);
        if (optionalSalary.isEmpty()) {
            return ResponseEntity.notFound().build();
        }

        // Delete the salary
        salaryRepository.delete(optionalSalary.get());

        return ResponseEntity.ok("Salary deleted successfully");
    }

    @GetMapping("/{name}")
    public ResponseEntity<Employee> findByEmployeeName(@PathVariable String name) {
        Employee employee = employeeRepository.findByName(name).get();
        return ResponseEntity.ok(employee);
    }


}

package com.shohab.CreateApi.controller;

import com.shohab.CreateApi.model.Employee;
import com.shohab.CreateApi.model.Salary;
import com.shohab.CreateApi.repository.EmployeeRepository;
import com.shohab.CreateApi.repository.SalaryRepository;
import com.shohab.CreateApi.services.SalaryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/salary")
public class SalaryController {
    @Autowired
    public SalaryRepository salaryRepository;

    @Autowired
    private EmployeeRepository employeeRepository;
    @Autowired
    private SalaryService salaryService;


    @GetMapping("/addform")
    public String addSalary(Model model) {
        //this section for showing all salary in table
        List<Salary> salaryList = salaryService.getAllSalary();
        model.addAttribute("salaryList", salaryList);

        //this section for showing employee wise bonus, advance,salary
        List<Object[]> empList = employeeRepository.findEmployeeDetails();
        model.addAttribute("empList", empList);

        //this section for salary form
        model.addAttribute("empSalary", new Salary());
        return "salaryform";
    }

    @PostMapping("/salary_save")
    public String saveSalary(@ModelAttribute Salary salary) {
        String employeeName = salary.getEmployee().getName();
        Employee employee = employeeRepository.findByName(employeeName).get();
        salary.setEmployee(employee);
        salaryRepository.save(salary);
        return "redirect:/salary/addform";
    }






//    @GetMapping("")
//    public ResponseEntity<List<com.shohab.CreateApi.model.Salary>> getAllSalaries() {
//        List<com.shohab.CreateApi.model.Salary> salaries = salaryRepository.findAll();
//        return ResponseEntity.ok(salaries);
//    }


//    // Update method
//    @PutMapping("/{id}")
//    public ResponseEntity<String> updateSalary(@PathVariable Long id, @RequestBody com.shohab.CreateApi.model.Salary updatedSalary) {
//        Optional<com.shohab.CreateApi.model.Salary> optionalSalary = salaryRepository.findById(id);
//        if (optionalSalary.isEmpty()) {
//            return ResponseEntity.notFound().build();
//        }
//
//        com.shohab.CreateApi.model.Salary existingSalary = optionalSalary.get();
//        // Update the existing salary with the new data
//        existingSalary.setEmployee(updatedSalary.getEmployee());
//        existingSalary.setAmount(updatedSalary.getAmount());
//        existingSalary.setDate(updatedSalary.getDate());
////        existingSalary.setTotalAmount(updatedSalary.getTotalAmount());
//        // Update other fields as needed
//
//        // Save the updated salary
//        salaryRepository.save(existingSalary);
//
//        return ResponseEntity.ok("Salary updated successfully");
//    }

//    @PostMapping("/update/{id}")
//    public String updateSalary(@PathVariable("id") long id, @Valid User user,
//                               BindingResult result, Model model) {
//        if (result.hasErrors()) {
//            user.setId(id);
//            return "update-user";
//        }
//
//        userRepository.save(user);
//        return "redirect:/index";
//    }

    // Delete method
    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteSalary(@PathVariable Long id) {
        Optional<com.shohab.CreateApi.model.Salary> optionalSalary = salaryRepository.findById(id);
        if (optionalSalary.isEmpty()) {
            return ResponseEntity.notFound().build();
        }

        // Delete the salary
        salaryRepository.delete(optionalSalary.get());

        return ResponseEntity.ok("Salary deleted successfully");
    }

    @GetMapping("/{name}")
    public ResponseEntity<com.shohab.CreateApi.model.Employee> findByEmployeeName(@PathVariable String name) {
        Employee employee = employeeRepository.findByName(name).get();
        return ResponseEntity.ok(employee);
    }

    //this section for showing employee salary,bonus,advance
//    @GetMapping("/employee_details")
//    public String getEmpDetails(Model model) {
//        List<Object[]> empList = employeeRepository.findEmployeeDetails();
//        model.addAttribute("empList", empList);
//        return "salaryform";
//
//    }
}

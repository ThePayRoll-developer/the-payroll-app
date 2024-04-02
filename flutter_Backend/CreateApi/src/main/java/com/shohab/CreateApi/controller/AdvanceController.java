package com.shohab.CreateApi.controller;

import com.shohab.CreateApi.model.Advance;
import com.shohab.CreateApi.model.Employee;
import com.shohab.CreateApi.repository.AdvanceRepository;
import com.shohab.CreateApi.repository.EmployeeRepository;
import com.shohab.CreateApi.services.AdvanceService;
import org.apache.velocity.exception.ResourceNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/advance")
public class AdvanceController {
    @Autowired
    private AdvanceRepository advanceRepository;

    @Autowired
    private EmployeeRepository employeeRepository;

    @Autowired
    private AdvanceService advanceService;

//    @PostMapping("/save")
//    public ResponseEntity<String> saveAdvance(@RequestBody com.shohab.CreateApi.model.Advance advance) {
//        String employeeName = advance.getEmployee().getName();
//        BigDecimal amount = advance.getAmount();
//        String reason=advance.getReason();
//        String date=advance.getDate();
//        Long employeeId = advance.getEmployee().getId(); // New parameter for specifying employee ID
//
//        // Fetch the employee by ID
//        Optional<Employee> optionalEmployee = employeeRepository.findByName(employeeName);
//        if (optionalEmployee.isEmpty()) {
//            return ResponseEntity.badRequest().body("Employee not found");
//        }
//        Employee employee = optionalEmployee.get();
//
//        // Check if the employee name matches the provided name
//        if (!employee.getName().equals(employeeName)) {
//            return ResponseEntity.badRequest().body("Employee name does not match the provided ID");
//        }
//
//        // Create and save the Advance for the Employee
//        com.shohab.CreateApi.model.Advance advance_1 = new com.shohab.CreateApi.model.Advance();
//        advance_1.setEmployee(employee);
//        advance_1.setAmount(amount);
//        advance_1.setReason(reason);
//        advance_1.setDate(date);
//        advanceRepository.save(advance_1);
//
//        return ResponseEntity.ok("Advance saved successfully.");
//    }

    //fetch all  advance
    @GetMapping("")
    public String showAllAdvance(Model model){
        List<Advance>advanceList=advanceService.getAllAdvance();
        model.addAttribute("advanceList",advanceList);
        return "alladvance";

    }




//    @PutMapping("/{id}")
//    public ResponseEntity<com.shohab.CreateApi.model.Advance> updateAdvance(@PathVariable Long id, @RequestBody com.shohab.CreateApi.model.Advance updatedAdvance) {
//        com.shohab.CreateApi.model.Advance advance = advanceRepository.findById(id)
//                .orElseThrow(() -> new ResourceNotFoundException("Advance not found with id: " + id));
//
//        advance.setAmount(updatedAdvance.getAmount());
//        // Set other fields as needed
//
//        com.shohab.CreateApi.model.Advance updated = advanceRepository.save(advance);
//        return ResponseEntity.ok(updated);
//    }
//
//    @DeleteMapping("/{id}")
//    public ResponseEntity<?> deleteAdvance(@PathVariable Long id) {
//        com.shohab.CreateApi.model.Advance advance = advanceRepository.findById(id)
//                .orElseThrow(() -> new ResourceNotFoundException("Advance not found with id: " + id));
//
//        advanceRepository.delete(advance);
//        return ResponseEntity.ok().build();
//    }
}

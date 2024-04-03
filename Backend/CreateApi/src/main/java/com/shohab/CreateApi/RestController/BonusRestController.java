package com.shohab.CreateApi.RestController;

import com.shohab.CreateApi.model.Bonus;
import com.shohab.CreateApi.model.Employee;
import com.shohab.CreateApi.repository.BonusRepository;
import com.shohab.CreateApi.repository.EmployeeRepository;
import org.apache.velocity.exception.ResourceNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/bonus")
@CrossOrigin("*")
public class BonusRestController {
    //Save Bonus
    @Autowired
    private BonusRepository bonusRepository;
    @Autowired
    private EmployeeRepository employeeRepository;


    //    @PostMapping("")
//    public ResponseEntity<String> saveBonus(@RequestBody Bonus request) {
//        String employeeName = request.getEmployee().getName();
//        BigDecimal amount = request.getAmount();
//        String bonusDate=request.getBonusDate();
//        Long employeeId = request.getEmployee().getId(); // New parameter for specifying employee ID
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
//        // Create and save the Bonus for the Employee
//        Bonus bonus = new Bonus();
//        bonus.setEmployee(employee);
//        bonus.setAmount(amount);
//        bonus.setBonusDate(bonusDate);
//        bonusRepository.save(bonus);
//
//        return ResponseEntity.ok("Bonus saved successfully.");
//    }
// flutter rest api
    @GetMapping("/{email}")
    public ResponseEntity<List<Bonus>> getAllBonusByEmp(@PathVariable String email) {
        List<Bonus> bonus = bonusRepository.findBonusByEmp(email);
        return ResponseEntity.ok(bonus);
    }
// flutter rest api

    @PostMapping("")
    public ResponseEntity<String> saveBonus(@RequestBody Bonus request) {
        // Null check for request.getEmployee()
        if (request.getEmployee() == null) {
            return ResponseEntity.badRequest().body("Employee information is missing");
        }

        String employeeName = request.getEmployee().getName();
        BigDecimal amount = request.getAmount();
        String bonusDate = request.getBonusDate();
//        Long employeeId = request.getEmployee().getId(); // Use employee ID for consistency

        // Fetch the employee by ID
        Optional<Employee> optionalEmployee = employeeRepository.findByName(employeeName);
        if (optionalEmployee.isEmpty()) {
            return ResponseEntity.badRequest().body("Employee not found");
        }
        Employee employee = optionalEmployee.get();

        // Check if the employee name matches the provided name
        if (!employee.getName().equals(employeeName)) {
            return ResponseEntity.badRequest().body("Employee name does not match the provided ID");
        }

        // Create and save the Bonus for the Employee
        Bonus bonus = new Bonus();
        bonus.setEmployee(employee);
        bonus.setAmount(amount);
        bonus.setBonusDate(bonusDate);
        bonusRepository.save(bonus);

        // Return more detailed response
        return ResponseEntity.ok("Bonus saved successfully. Bonus ID: " + bonus.getId());
    }


    //All bonus List
    @GetMapping("")
    public ResponseEntity<List<Bonus>> getAllBonus() {
        List<Bonus> advances = bonusRepository.findAll();
        return ResponseEntity.ok(advances);
    }

    // Update Bonus
    @PutMapping("/{id}")
    public ResponseEntity<Bonus> updateBonus(@PathVariable Long id, @RequestBody Bonus updatedBonus) {
        Bonus bonus = bonusRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Bonus not found with id: " + id));

        bonus.setAmount(updatedBonus.getAmount());
        // Set other fields as needed

        Bonus updated = bonusRepository.save(bonus);
        return ResponseEntity.ok(updated);
    }

    // Delete Bonus
    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteBonus(@PathVariable Long id) {
        Bonus bonus = bonusRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Bonus not found with id: " + id));

        bonusRepository.delete(bonus);
        return ResponseEntity.ok().build();
    }

}

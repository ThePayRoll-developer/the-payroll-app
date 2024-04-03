package com.shohab.CreateApi.RestController;

import com.shohab.CreateApi.model.Advance;
import com.shohab.CreateApi.model.Employee;
import com.shohab.CreateApi.repository.AdvanceRepository;
import com.shohab.CreateApi.repository.EmployeeRepository;
import org.apache.velocity.exception.ResourceNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/advance")
@CrossOrigin("*")
public class AdvanceRestController {

    @Autowired
    private AdvanceRepository advanceRepository;

    @Autowired
    private EmployeeRepository employeeRepository;

    @PostMapping("")
    public ResponseEntity<String> saveAdvance(@RequestBody Advance advance) {
        String employeeName = advance.getEmployee().getName();
        BigDecimal amount = advance.getAmount();
        String reason=advance.getReason();
        String date=advance.getDate();
        Long employeeId = advance.getEmployee().getId(); // New parameter for specifying employee ID

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

        // Create and save the Advance for the Employee
        Advance advance_1 = new Advance();
        advance_1.setEmployee(employee);
        advance_1.setAmount(amount);
        advance_1.setReason(reason);
        advance_1.setDate(date);
        advanceRepository.save(advance_1);

        return ResponseEntity.ok("Advance saved successfully.");
    }

    @GetMapping("")
    public ResponseEntity<List<Advance>> getAllAdvance() {
        List<Advance> advances = advanceRepository.findAll();
        return ResponseEntity.ok(advances);
    }

    // flutter rest api
    @GetMapping("/{email}")
    public ResponseEntity<List<Advance>> getAllAdvanceByEmp(@PathVariable String email) {
        List<Advance> adv = advanceRepository.findAdvanceByEmp(email);
        return ResponseEntity.ok(adv);
    }

    @PostMapping ("/flutter")
    public ResponseEntity<Advance>saveEmpLeave(@RequestBody Advance advance){
        String employeeName = advance.getEmployee().getName();
        Employee employee = employeeRepository.findByName(employeeName).get();
        advance.setEmployee(employee);
        advanceRepository.save(advance);
        return ResponseEntity.ok(advance);

    }
    // flutter rest api


    @PutMapping("/{id}")
    public ResponseEntity<Advance> updateAdvance(@PathVariable Long id, @RequestBody Advance updatedAdvance) {
        Advance advance = advanceRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Advance not found with id: " + id));

        advance.setAmount(updatedAdvance.getAmount());
        // Set other fields as needed

        Advance updated = advanceRepository.save(advance);
        return ResponseEntity.ok(updated);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteAdvance(@PathVariable Long id) {
        Advance advance = advanceRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Advance not found with id: " + id));

        advanceRepository.delete(advance);
        return ResponseEntity.ok().build();
    }
}

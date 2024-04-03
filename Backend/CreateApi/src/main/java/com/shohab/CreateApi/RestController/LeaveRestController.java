package com.shohab.CreateApi.RestController;

import com.shohab.CreateApi.model.Employee;
import com.shohab.CreateApi.model.Leave;
import com.shohab.CreateApi.repository.EmployeeRepository;
import com.shohab.CreateApi.repository.LeaveRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/leave")
@CrossOrigin("*")
public class LeaveRestController {
    @Autowired
    private LeaveRepository leaveRepository;

    @Autowired
    private EmployeeRepository employeeRepository;

    // GET all leaves
    @GetMapping("")
    public ResponseEntity<List<Leave>> getAllLeaves() {
        List<Leave> leaves = leaveRepository.findAll();
        return ResponseEntity.ok(leaves);
    }

    // flutter rest api
    @GetMapping("/{email}")
    public ResponseEntity<List<Leave>> getAllLeaveByEmp(@PathVariable String email) {
        List<Leave> attendances = leaveRepository.findLeaveByEmp(email);
        return ResponseEntity.ok(attendances);
    }

    @PostMapping ("/flutter")
    public ResponseEntity<Leave>saveEmpLeave(@RequestBody Leave leave){
        String employeeName = leave.getEmployee().getName();
        Employee employee = employeeRepository.findByName(employeeName).get();
        leave.setEmployee(employee);
        leaveRepository.save(leave);
        return ResponseEntity.ok(leave);

    }
    // flutter rest api

    // GET a leave by ID
//    @GetMapping("/{id}")
//    public ResponseEntity<Leave> getLeaveById(@PathVariable int id) {
//        Optional<Leave> leaveOptional = leaveRepository.findById(id);
//        if (leaveOptional.isPresent()) {
//            return ResponseEntity.ok(leaveOptional.get());
//        } else {
//            return ResponseEntity.notFound().build();
//        }
//    }

    // POST a new leave
    @PostMapping("")
    public ResponseEntity<String> saveBonus(@RequestBody Leave leave) {
        // Null check for request.getEmployee()
        if (leave.getEmployee() == null) {
            return ResponseEntity.badRequest().body("Employee information is missing");
        }

        String employeeName = leave.getEmployee().getName();
        String contact = leave.getContact();
        String leaveDate = leave.getLeaveDate();
        String leaveReason = leave.getLeaveReason();
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
        Leave leave1 = new Leave();
        leave1.setEmployee(employee);
        leave1.setContact(contact);
        leave1.setLeaveDate(leaveDate);
        leave1.setLeaveReason(leaveReason);
        leaveRepository.save(leave1);

        // Return more detailed response
        return ResponseEntity.ok("Leave saved successfully. Bonus ID: " + leave1.getId());
    }

    // PUT update an existing leave
    @PutMapping("/{id}")
    public ResponseEntity<Leave> updateLeave(@PathVariable int id, @RequestBody Leave leave) {
        if (!leaveRepository.existsById(id)) {
            return ResponseEntity.notFound().build();
        }
        Leave optionalLeave = leaveRepository.findById(id).get();
        optionalLeave.setId(leave.getId());
        optionalLeave.setGrant(true);

        leaveRepository.save(optionalLeave);
//        Leave updatedLeave = leaveRepository.save(leave);
        return ResponseEntity.ok(optionalLeave);
    }

    // DELETE a leave by ID
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteLeave(@PathVariable int id) {
        if (!leaveRepository.existsById(id)) {
            return ResponseEntity.notFound().build();
        }
        leaveRepository.deleteById(id);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/count")
    public ResponseEntity<String> getTotalleaveDays(@RequestParam("empname") String name, @RequestParam("month") String month){

        Employee employee = employeeRepository.findByName(name).get();
        Long empId = employee.getId();
        int totalDays =leaveRepository.findLeaveByCount(empId,month);
        String empDays = String.valueOf(totalDays);

        return ResponseEntity.ok(empDays);
    }
    @GetMapping("/flutter/count")
    public ResponseEntity<String> getTotalleaveDaysByFlutter(@RequestParam("empname") String name, @RequestParam("month") String month){

        Employee employee = employeeRepository.findByName(name).get();
        Long empId = employee.getId();
        int totalDays =leaveRepository.findLeaveByCountforFlutter(empId,month);
        String empDays = String.valueOf(totalDays);

        return ResponseEntity.ok(empDays);
    }
}

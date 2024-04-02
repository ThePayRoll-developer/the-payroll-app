package com.shohab.CreateApi.controller;

import com.shohab.CreateApi.model.Employee;
import com.shohab.CreateApi.model.Leave;
import com.shohab.CreateApi.repository.EmployeeRepository;
import com.shohab.CreateApi.repository.LeaveRepository;
import com.shohab.CreateApi.services.LeaveService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/leave")
public class LeaveController {
    @Autowired
    private LeaveRepository leaveRepository;

    @Autowired
    private EmployeeRepository employeeRepository;

    @Autowired
    private LeaveService leaveService;


    @GetMapping("")
    public String showAllLeaves(Model model) {
        List<Leave> leaveList = leaveService.getAllLeaves();
        model.addAttribute("leaveList", leaveList);
        return "allleave";

    }

    //    @PutMapping("/grant/{id}")
//    public String editLeave(@PathVariable int id, Model model){
//        Leave leave=leaveService.findById(id);
////        Leave leave1= new Leave();
//        leave.setGrant(true);
//        return "alleave";
//
//    }
    @PostMapping("/grant/{id}")
    public String editLeave(@PathVariable int id) {
        Leave leave = leaveService.findById(id);
        if (leave != null) {
            leave.setGrant(true); // Update the grant status to true
            leaveService.saveLeave(leave); // Save the updated leave object
        }
        return "redirect:/leave"; // Redirect to the page displaying all leaves
    }


    //this section for counting leave
//    @GetMapping("/count")
//    public ResponseEntity<String> getTotalleaveDays(@RequestParam("empname") String name, @RequestParam("month") String month) {
//
//        Employee employee = employeeRepository.findByName(name).get();
//        Long empId = employee.getId();
//        int totalDays = leaveRepository.findLeaveByCount(empId, month);
//        String empDays = String.valueOf(totalDays);
//
//        return ResponseEntity.ok(empDays);
//    }
}

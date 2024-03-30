package com.shohab.CreateApi.controller;

import com.shohab.CreateApi.model.Attendance;
import com.shohab.CreateApi.repository.AttendanceRepo;
import com.shohab.CreateApi.repository.EmployeeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/attendance")
public class AttendanceController {
    @Autowired
    private AttendanceRepo attendanceRepo;

    @Autowired
    private EmployeeRepository employeeRepository;



//    @PostMapping("/save")
//    public ResponseEntity<com.shohab.CreateApi.model.Attendance> saveEmpAttendance(@RequestBody com.shohab.CreateApi.model.Attendance attendance){
//        String employeeName = attendance.getEmployee().getName();
//        Employee employee = employeeRepository.findByName(employeeName).get();
//        attendance.setEmployee(employee);
//        attendanceRep.save(attendance);
//        return ResponseEntity.ok(attendance);
//
//    }

    @GetMapping("")
    public String showAllAttendance(Model model) {
        List<Attendance> attendanceList = attendanceRepo.findAll();
        model.addAttribute("attendanceList", attendanceList);
        return "allattendance"; // Assuming your Thymeleaf template is named "attendance.html"
    }

//    @GetMapping("/present")
//    public ResponseEntity<String> getTotalDays(@RequestParam("empname") String name, @RequestParam("month") String month){
//
//        Employee employee = employeeRepository.findByName(name).get();
//        Long empId = employee.getId();
//        int totalDays =attendanceRep.findAttendanceByCount(empId,month);
//        String empDays = String.valueOf(totalDays);
//
//        return ResponseEntity.ok(empDays);
//    }

//    @PutMapping("/{id}")
//    public ResponseEntity<com.shohab.CreateApi.model.Attendance> updateAttendance(@PathVariable int id, @RequestBody com.shohab.CreateApi.model.Attendance updatedAttendance) {
//        Optional<com.shohab.CreateApi.model.Attendance> optionalAttendance = attendanceRep.findById(id);
//        if (optionalAttendance.isPresent()) {
//            com.shohab.CreateApi.model.Attendance existingAttendance = optionalAttendance.get();
//            // Assuming you also want to update employee information
//            String employeeName = updatedAttendance.getEmployee().getName();
//            Employee employee = employeeRepository.findByName(employeeName).orElseThrow(() -> new RuntimeException("Employee not found"));
//            existingAttendance.setEmployee(employee);
//            attendanceRep.save(existingAttendance);
//            return ResponseEntity.ok(existingAttendance);
//        } else {
//            return ResponseEntity.notFound().build();
//        }
//    }
}

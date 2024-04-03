package com.shohab.CreateApi.RestController;

import com.shohab.CreateApi.model.Attendance;
import com.shohab.CreateApi.model.Employee;
import com.shohab.CreateApi.repository.AttendanceRepo;
import com.shohab.CreateApi.repository.EmployeeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/attendance")
@CrossOrigin("*")
public class AttendanceRestController {

    @Autowired
    private AttendanceRepo attendanceRep;

    @Autowired
    private EmployeeRepository employeeRepository;

    @PostMapping ("")
    public ResponseEntity<Attendance>saveEmpAttendance(@RequestBody Attendance attendance){
        String employeeName = attendance.getEmployee().getName();
        Employee employee = employeeRepository.findByName(employeeName).get();
        attendance.setEmployee(employee);
        attendanceRep.save(attendance);
        return ResponseEntity.ok(attendance);

    }

    @GetMapping("")
    public ResponseEntity<List<Attendance>> getAllAttendance() {
        List<Attendance> attendances = attendanceRep.findAll();
        return ResponseEntity.ok(attendances);
    }

    // flutter rest api
    @GetMapping("/{email}")
    public ResponseEntity<List<Attendance>> getAllAttendanceByEmp(@PathVariable String email) {
        List<Attendance> attendances = attendanceRep.findAttendanceByEmp(email);
        return ResponseEntity.ok(attendances);
    }

    @GetMapping("/latest/{email}")
    public ResponseEntity<List<Attendance>> getLatestAttendanceByEmp(@PathVariable String email) {
        List<Attendance> attendances = attendanceRep.findLatestAttendanceByEmp(email);
        return ResponseEntity.ok(attendances);
    }



    //not used
    @PostMapping ("/{email}")
    public ResponseEntity<Attendance>saveEmpAttendanceFlutter(@PathVariable String email){
        if(email != null){
            Employee employee = employeeRepository.findByEmail(email);
            Attendance attendance = new Attendance();
            attendance.setEmployee(employee);
            attendanceRep.save(attendance);
            return ResponseEntity.ok(attendance);

        }else {
            return ResponseEntity.notFound().build();
        }
    }

    @PostMapping ("/flutter")
    public ResponseEntity<Attendance>saveEmpAttendanceOg(@RequestBody Attendance attendance){
        String employeeName = attendance.getEmployee().getName();
        Employee employee = employeeRepository.findByName(employeeName).get();
        attendance.setEmployee(employee);
        attendanceRep.save(attendance);
        return ResponseEntity.ok(attendance);

    }
    // flutter rest api

    @GetMapping("/present")
    public ResponseEntity<String> getTotalDays(@RequestParam("empname") String name, @RequestParam("month") String month){

        Employee employee = employeeRepository.findByName(name).get();
        Long empId = employee.getId();
        int totalDays =attendanceRep.findAttendanceByCount(empId,month);
        String empDays = String.valueOf(totalDays);

        return ResponseEntity.ok(empDays);
    }
    @GetMapping("/flutter/present")
    public ResponseEntity<String> getTotalDaysWithFlutter(@RequestParam("empname") String name, @RequestParam("month") String month){

        Employee employee = employeeRepository.findByName(name).get();
        Long empId = employee.getId();
        int totalDays =attendanceRep.findAttendanceByCountWithFlutter(empId,month);
        String empDays = String.valueOf(totalDays);

        return ResponseEntity.ok(empDays);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Attendance> updateAttendance(@PathVariable int id, @RequestBody Attendance updatedAttendance) {
        Optional<Attendance> optionalAttendance = attendanceRep.findById(id);
        if (optionalAttendance.isPresent()) {
            Attendance existingAttendance = optionalAttendance.get();
            // Assuming you also want to update employee information
            String employeeName = updatedAttendance.getEmployee().getName();
            Employee employee = employeeRepository.findByName(employeeName).orElseThrow(() -> new RuntimeException("Employee not found"));
            existingAttendance.setEmployee(employee);
            attendanceRep.save(existingAttendance);
            return ResponseEntity.ok(existingAttendance);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

}

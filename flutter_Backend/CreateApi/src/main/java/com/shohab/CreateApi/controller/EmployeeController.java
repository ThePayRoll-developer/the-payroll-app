package com.shohab.CreateApi.controller;

import com.shohab.CreateApi.model.Department;
import com.shohab.CreateApi.model.Employee;
import com.shohab.CreateApi.repository.EmployeeRepository;
import com.shohab.CreateApi.repository.IDepartmentRepo;
import com.shohab.CreateApi.services.DepartmentService;
import com.shohab.CreateApi.services.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/employee")
public class EmployeeController {
    @Autowired
    private EmployeeRepository employeeRepository;

    @Autowired
    IDepartmentRepo iDepartmentRepo;

    @Autowired
    private DepartmentService departmentService;
    @Autowired
    private EmployeeService employeeService;


    //this section for getting form
    @GetMapping("/addform")
    public  String addEmployee(Model m){
// data comes from Department table using List, DepartmentService
        List<Department>depList=departmentService.getAllDepartment();
//        List<com.shohab.CreateApi.model.Employee> employeeList = employeeService.getAllEmployee();
        List<com.shohab.CreateApi.model.Employee> employeeList=employeeService.getAllEmployee();


        m.addAttribute("employeeList", employeeList);
//        m.addAttribute("department", depList);
        // to add department as dropdown from Department Model using Join Querry
        m.addAttribute("department",new Department());
        m.addAttribute("deplist",depList);


        //Employee Part
        m.addAttribute("employee", new Employee());
        m.addAttribute("title", "Add Employee");
        return  "employee";
    }

//    @GetMapping("/index")
//    public String home(){
//        return "index";
//    }



    @PostMapping("/save")
    public String saveEmployee(@ModelAttribute com.shohab.CreateApi.model.Employee e) {
        employeeService.saveEmployee(e);
        return "redirect:/employee";
    }

    @DeleteMapping ("/delete/{id}")
    public String deleteEmployee(@PathVariable int id){
        employeeService.deleteById(id);
        return "redirect:/employee";
    }

    @PutMapping("/edit/{id}")
    public String editEmployee(@PathVariable int id, Model m){
        List<Department>depList=departmentService.getAllDepartment();
        // to add department as dropdown from Department Model using Join Querry
        m.addAttribute("department",new Department());
        m.addAttribute("deplist",depList);
        com.shohab.CreateApi.model.Employee e=employeeService.findBy(id);
        m.addAttribute("employee", e);
        return "redirect:/employee";

    }


    @PutMapping("/department/{id}")
    public String getEmployeesByDepartment(@PathVariable int id, Model model) {
        // Fetch employees by department
        List<com.shohab.CreateApi.model.Employee> employees = employeeService.getEmployeesByDepartment(id);

        // Fetch the selected department
        Department department = iDepartmentRepo.findById(id)
                .orElseThrow(() -> new RuntimeException("Department not found"));

        // Fetch all departments to populate the dropdown
        List<Department> departments = iDepartmentRepo.findAll();

        // Add data to the model
        model.addAttribute("department", departments);  // Corrected attribute name
        model.addAttribute("employeeList", employees);
        model.addAttribute("selectedDepartment", department);

        return "employee";
    }
//    @GetMapping("/emp_details")
//    public List<Object[]> getEmpDetails() {
//        List<Object[]> employeeLIst = employeeRepository.findEmployeeDetails();
//        return employeeLIst;
//
//    }





}

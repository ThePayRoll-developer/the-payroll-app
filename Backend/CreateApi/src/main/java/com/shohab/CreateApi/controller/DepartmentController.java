package com.shohab.CreateApi.controller;

import com.shohab.CreateApi.model.Department;
import com.shohab.CreateApi.services.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/department")
public class DepartmentController {

    @Autowired
    private DepartmentService service;

    @GetMapping("/addform")
    public String addForm(Model model) {
        model.addAttribute("department", new Department());
        model.addAttribute("title", "Add Department");

        List<Department> departmentList = service.getAllDepartment();
        model.addAttribute("deplist", departmentList);
        model.addAttribute("title", "All Department");
        return "department";
    }

    @PostMapping("/save")
    public String addDepartment(@ModelAttribute Department department) {
        service.saveDepartment(department);
        return "redirect:/department/addform";
    }

//    @GetMapping("")
//    public String getAllDepartments(Model model) {
//        List<Department> departmentList = service.getAllDepartment();
//        model.addAttribute("deplist", departmentList);
//        model.addAttribute("title", "All Department");
//        return "department";
//    }

    @DeleteMapping("/delete/{id}")
    public String deleteDepartment(@PathVariable int id) {
        service.deleteById(id);
        return "redirect:/department/addform";
    }

    @PutMapping("/edit/{id}")
    public String editDepartment(@PathVariable int id, Model model) {
        Department department = service.editById(id);
        model.addAttribute("department", department);
        return "redirect:/department/addform";
    }
}

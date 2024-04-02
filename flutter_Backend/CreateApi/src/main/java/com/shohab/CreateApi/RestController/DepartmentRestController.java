package com.shohab.CreateApi.RestController;

import com.shohab.CreateApi.model.Department;
import com.shohab.CreateApi.repository.IDepartmentRepo;
import com.shohab.CreateApi.services.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/department")
@CrossOrigin(origins = "*")

public class DepartmentRestController {

    @Autowired
    public IDepartmentRepo iDepartmentRepo;
    @Autowired
    private DepartmentService departmentService;

    @GetMapping("")
    public List<Department> allDep() {
        return iDepartmentRepo.findAll();
    }

    //    @PostMapping("")
//    public Department saveDep(@RequestBody Department department) {
//        return iDepartmentRepo.save(department);
//    }
    @PostMapping("")
    public ResponseEntity<Department> saveDepartment(@RequestBody Department department) {
        Department savedDepartment = departmentService.saveDepartment(department);
//        return new ResponseEntity<>(savedDepartment, HttpStatus.CREATED);
        return ResponseEntity.ok(savedDepartment);
    }


    @DeleteMapping("/{id}")
    public ResponseEntity<String> delete(@PathVariable("id") int id) {
        boolean exist = iDepartmentRepo.existsById(id);
        if (exist) {
            iDepartmentRepo.deleteById(id);
            return new ResponseEntity<>("Department is deleted", HttpStatus.OK);
        }
        return new ResponseEntity<>("Department is not exist", HttpStatus.BAD_REQUEST);
    }


    @PutMapping("/{id}")
    public ResponseEntity<String> update(@PathVariable("id") int id, @RequestBody Department department) {
        boolean exist = iDepartmentRepo.existsById(id);

        if (exist) {
            Department department1 = iDepartmentRepo.getById(id);
            department1.setDeptName(department.getDeptName());
            department1.setId(id);
            iDepartmentRepo.save(department);
            return new ResponseEntity<>("Department is Updated", HttpStatus.OK);
        }
        return new ResponseEntity<>("Department is not Exist", HttpStatus.BAD_REQUEST);


    }


}

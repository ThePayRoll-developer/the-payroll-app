package com.shohab.CreateApi.repository;

import com.shohab.CreateApi.model.Department;

import org.springframework.data.jpa.repository.JpaRepository;

public interface IDepartmentRepo extends JpaRepository<Department,Integer> {
Department findByDeptName(String deptName);


}

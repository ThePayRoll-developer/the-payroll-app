package com.shohab.CreateApi.repository;

import com.shohab.CreateApi.model.Employee;
import com.shohab.CreateApi.model.Salary;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;


@Repository
public interface SalaryRepository extends JpaRepository<Salary,Long> {


    @Query("select s from Salary s where s.employee.email =?1 order by s.id desc limit 2")
    public List<Salary> findSalaryByEmp(String email);
}

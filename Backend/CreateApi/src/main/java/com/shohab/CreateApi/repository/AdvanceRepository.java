package com.shohab.CreateApi.repository;

import com.shohab.CreateApi.model.Advance;
import com.shohab.CreateApi.model.Employee;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository
public interface AdvanceRepository extends JpaRepository<Advance,Long> {

    List<Advance> findByEmployee(Employee employee);

    @Query("select a from Advance a where a.employee.email =?1 order by a.id desc limit 10")
    public List<Advance> findAdvanceByEmp(String email);
}

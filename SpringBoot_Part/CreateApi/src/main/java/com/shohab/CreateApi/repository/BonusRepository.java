package com.shohab.CreateApi.repository;

import com.shohab.CreateApi.model.Bonus;
import com.shohab.CreateApi.model.Employee;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface BonusRepository extends JpaRepository<Bonus,Long> {
    List<Bonus>findByEmployee(Employee bonus);
}

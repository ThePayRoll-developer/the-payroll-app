package com.shohab.CreateApi.repository;

import com.shohab.CreateApi.model.Employee;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;


@Repository
public interface EmployeeRepository extends JpaRepository<Employee ,Long> {

    Optional<Employee> findByName(String name);

    @Query("SELECT e.name, e.salary, b.amount,a.amount from Employee e join Bonus b on e.id = b.employee.id join Advance a on e.id = a.employee.id")
    public List<Object[]>findEmployeeDetails();
    List<Employee> findByDepartmentId(int id);

    @Query("select e from  Employee e where e.email =?1")
    Employee findByEmail(String email);


}

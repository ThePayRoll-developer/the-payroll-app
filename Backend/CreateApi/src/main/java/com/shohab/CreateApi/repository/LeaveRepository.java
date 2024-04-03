package com.shohab.CreateApi.repository;

import com.shohab.CreateApi.model.Leave;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface LeaveRepository extends JpaRepository<Leave,Integer> {

    @Query(value = "select count(id) from emp_leave where employee_id =:id and is_grant=true and substring(leave_date, 6, 2) =:month", nativeQuery = true)
int findLeaveByCount(Long id, String month);
    @Query(value = "select count(id) from emp_leave where employee_id =:id and is_grant=true and substring(leave_date, 7, 1) =:month", nativeQuery = true)
    int findLeaveByCountforFlutter(Long id, String month);
    
}

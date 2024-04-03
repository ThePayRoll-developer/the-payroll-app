package com.shohab.CreateApi.repository;

import com.shohab.CreateApi.model.Attendance;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.sql.Date;
import java.util.List;

@Repository
public interface AttendanceRepo extends JpaRepository<Attendance,Integer> {

//    @Query("select count(a.employee.id) from Attendance a where a.employee.id = :id and Date(a.checkIn) like %:days%")
    @Query(value="select count(id) from Attendance where empid = :id and substring(check_in, 6, 2) = :month",nativeQuery = true)
    int findAttendanceByCount(Long id, String month);
    @Query(value="select count(id) from Attendance where empid = :id and substring(check_in, 7, 1) = :month",nativeQuery = true)
    int findAttendanceByCountWithFlutter(Long id, String month);

    @Query("select a from Attendance a where a.employee.email =?1 order by a.checkIn desc limit 10")
    public List<Attendance> findAttendanceByEmp(String email);

    @Query("select a from Attendance a where a.employee.email =?1 order by a.checkIn desc limit 1")
    public List<Attendance> findLatestAttendanceByEmp(String email);
}

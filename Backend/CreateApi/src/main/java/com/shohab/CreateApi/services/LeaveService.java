package com.shohab.CreateApi.services;

import com.shohab.CreateApi.model.Leave;
import com.shohab.CreateApi.repository.LeaveRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class LeaveService {
    @Autowired
    private LeaveRepository leaveRepository;

    public List<Leave>getAllLeaves(){
        return leaveRepository.findAll();
    }
    public Leave findById(int id){
        return leaveRepository.findById(id).get();
    }

    public Leave saveLeave(Leave leave){
        return leaveRepository.save(leave);
    }

}

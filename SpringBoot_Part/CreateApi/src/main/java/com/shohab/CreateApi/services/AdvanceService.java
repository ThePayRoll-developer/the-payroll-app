package com.shohab.CreateApi.services;

import com.shohab.CreateApi.model.Advance;
import com.shohab.CreateApi.repository.AdvanceRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AdvanceService {
    @Autowired
    private AdvanceRepository advanceRepository;

    public List<Advance>getAllAdvance(){
        return advanceRepository.findAll();
    }
}

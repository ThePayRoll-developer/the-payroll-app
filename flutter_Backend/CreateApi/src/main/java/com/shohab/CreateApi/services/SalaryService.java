package com.shohab.CreateApi.services;


import com.shohab.CreateApi.model.Advance;
import com.shohab.CreateApi.model.Bonus;
import com.shohab.CreateApi.model.Employee;
import com.shohab.CreateApi.model.Salary;
import com.shohab.CreateApi.repository.AdvanceRepository;
import com.shohab.CreateApi.repository.BonusRepository;
import com.shohab.CreateApi.repository.SalaryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

@Service
public class SalaryService {
    @Autowired
    private SalaryRepository salaryRepository;

    @Autowired
    private  AdvanceRepository advanceRepository;

    @Autowired
    private BonusRepository bonusRepository;

    //This method works for showing who have taken advance
    public boolean hasTakenAdvance(Employee employee) {
        // Assuming advanceRepository.findByEmployee(employee) returns a List<Advance>
        List<Advance> advances = advanceRepository.findByEmployee(employee);
        return !advances.isEmpty(); // Return true if advances list is not empty
    }

    //This method works for showing who have gotten bonus
    public boolean hasTakenBonus(Employee employee) {
        // Assuming bonusRepository.findByEmployee(employee) returns a List<Bonus>
        List<Bonus> bonuses = bonusRepository.findByEmployee(employee);
        return !bonuses.isEmpty(); // Return true if bonuses list is not empty
    }


    //This method shows how much advance amount has taken
    public BigDecimal getAdvanceAmount(Employee employee) {
        // Assuming there's a method in your AdvanceRepository to find advances by employee
        List<Advance> advances = advanceRepository.findByEmployee(employee);
        BigDecimal totalAdvanceAmount = BigDecimal.ZERO; // Initialize total advance amount to zero

        for (Advance advance : advances) {
            totalAdvanceAmount = totalAdvanceAmount.add(advance.getAmount());
        }
        return totalAdvanceAmount;
    }

    //This method shows how much bonus amount will be given
    public BigDecimal getBonusAmount(Employee employee) {
        // Assuming there's a method in your BonusRepository to find bonuses by employee
        List<Bonus> bonuses = bonusRepository.findByEmployee(employee);
        BigDecimal totalBonusAmount = BigDecimal.ZERO; // Initialize total bonus amount to zero

        for (Bonus bonus : bonuses) {
            totalBonusAmount = totalBonusAmount.add(bonus.getAmount());
        }
        return totalBonusAmount;
    }

    //this section for showing all employee salary
    public List<Salary>getAllSalary(){
        return  salaryRepository.findAll();
    }


   














}

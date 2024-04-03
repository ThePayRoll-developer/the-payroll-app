package com.shohab.CreateApi.services;

import com.shohab.CreateApi.model.Bonus;
import com.shohab.CreateApi.repository.BonusRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class BonusService {
    @Autowired
    private BonusRepository bonusRepository;

    public List<Bonus>getAllBonus(){
        return bonusRepository.findAll();
    }

    public void savedBonus(Bonus bonus){
        bonusRepository.save(bonus);
    }

    public Bonus findById(Long id) {
        Optional<Bonus> optionalBonus = bonusRepository.findById(id);
        return optionalBonus.orElse(null); // Handle case where Bonus is not found
    }

    public void  deleteId(Long id){
        bonusRepository.deleteById(id);
    }

}

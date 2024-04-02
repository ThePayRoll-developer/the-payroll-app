package com.shohab.CreateApi.controller;

import com.shohab.CreateApi.model.Bonus;
import com.shohab.CreateApi.model.Employee;
import com.shohab.CreateApi.repository.BonusRepository;
import com.shohab.CreateApi.repository.EmployeeRepository;
import com.shohab.CreateApi.services.BonusService;
import com.shohab.CreateApi.services.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/bonus")
public class BonusController {
    @Autowired
    private BonusRepository bonusRepository;
    @Autowired
    private EmployeeRepository employeeRepository;

    @Autowired
    private BonusService bonusService;

    @Autowired
    private EmployeeService employeeService;

    //This section for getting request for a form
    @GetMapping("/addform")
    public String addBonus(Model m) {
        //this section for showing all bonus
        List<Bonus> bonusList = bonusService.getAllBonus();

        List<Employee> employeeList = employeeService.getAllEmployee();

        //this section for showing all bonus in table
        m.addAttribute("bonusList", bonusList);
        //then i will create a object of bonus
        m.addAttribute("bonus", new Bonus());

        //this section for showing title in bonus form
        m.addAttribute("title", "Add Bonus");

        //this section for getting name as dropdown in form
        m.addAttribute("employeeList", employeeList);
        m.addAttribute("employee", new Employee());
        return "bonusform";
    }

    @PostMapping("/save")
    public String saveBounus(@ModelAttribute Bonus bonus) {
        bonusService.savedBonus(bonus);
        return "redirect:/bonus/addform";
    }

//    @GetMapping("/buyers_edit/{id}")
//    public String buyersEdit(@PathVariable int id,Model m){
//        Buyers buyersname=buyerRepo.findById(id).get();
//        m.addAttribute("title","Update Buyers");
//        m.addAttribute("buyers",buyersname);
//        return "buyers/buyersForm";
//
//    }

    //    @GetMapping("edit/{id}")
//    public String bonusEdit(@PathVariable Long id,Model m){
//        List<Employee> employeeList=employeeService.getAllEmployee();
//
//        m.addAttribute("employeeList", employeeList);
//        m.addAttribute("employee", new Employee());
//
//        Bonus bonusEdit=bonusService.findById((long) id);
//        m.addAttribute("title","Update Bonus");
//        m.addAttribute("bonus",bonusEdit);
//        return "redirect:/bonus/addform";
//    }
    @GetMapping("/edit/{id}")
    public String bonusEdit(@PathVariable Long id, Model m) {
        List<Employee> employeeList = employeeService.getAllEmployee();

        // Retrieve the bonus object to edit from the service
        Bonus bonusEdit = bonusService.findById(id);

        // Add the retrieved bonus object and the list of employees to the model
        m.addAttribute("bonus", bonusEdit);
        m.addAttribute("employeeList", employeeList);

        // Add a title to indicate that it's an update operation
        m.addAttribute("title", "Update Bonus");

        // Return the view name where the edit form is defined
        return "bonusform";
    }

    @GetMapping("/delete/{id}")
    public String deleteBonus(@PathVariable Long id){
        bonusRepository.deleteById(id);
        return "redirect:/bonusform/addform";
    }

//    @GetMapping("/delete/{id}")
//    public String deleteUser(@PathVariable("id") long id, Model model) {
//        Bonus bonus = bonusService.findById(id)
//                .orElseThrow(() -> new IllegalArgumentException("Invalid user Id:" + id));
//        bonusService.deleteId(bonus.getId());
//        return "redirect:/index";
//    }




}

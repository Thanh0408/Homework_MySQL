package tsdv.homework.controller;

import tsdv.homework.model.Car;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import tsdv.homework.repository.CarRepository;

import java.util.List;

@Controller
public class CarController {
    @RequestMapping(value = "")
    public String index() {
        return "index";
    }
}

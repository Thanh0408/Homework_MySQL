package tsdv.homework.controller;
import org.springframework.web.servlet.view.RedirectView;
import tsdv.homework.model.Car;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import tsdv.homework.repository.CarRepository;

import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.io.IOException;
import java.util.List;

@RestController
@RequestMapping("/api")
public class CarAPIController {
    @Autowired
    CarRepository carRepository;

    @GetMapping(value = "")
    public List<Car> showCar(){
        return carRepository.findAll();
//        model.addAttribute(carRepository.findAll());
//        return "carList";
    }

    @GetMapping(value = "/{id}")
    public Car getById(Model model,
                       @PathVariable(value = "id") Long id) {
        Car car = carRepository.findById(id).get();
        return car;
    }

    @PostMapping(value = "/add")
    public Car addCar(@Valid @RequestBody Car car) {
        return carRepository.save(car);
    }

    @PutMapping(value = "/update/{id}")
    public void updateCar(@PathVariable(value = "id") Long id,
                          @Valid @RequestBody Car car) {
        if (carRepository.existsById(id)) {
            car.setId(id);
            carRepository.save(car);
        }
    }

    @RequestMapping(value = "/delete/{id}")
    public void deleteCar(@PathVariable(value = "id") Long id, HttpServletResponse response) throws IOException {
        Car car = carRepository.getById(id);
        carRepository.delete(car);
//        response.sendRedirect("/");
    }

}

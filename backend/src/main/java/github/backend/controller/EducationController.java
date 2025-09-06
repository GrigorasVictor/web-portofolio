package github.backend.controller;

import github.backend.model.Education;
import github.backend.service.EducationService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/education")
public class EducationController extends AbstractController<Education, EducationService> {
    @Override
    public ResponseEntity<Education> delete(Integer id) {
        return new ResponseEntity<>(HttpStatus.NOT_IMPLEMENTED);
    }

    @Override
    public ResponseEntity<Education> add(Education newEntry) throws Exception {
        return new ResponseEntity<>(HttpStatus.NOT_IMPLEMENTED);
    }

    @Override
    public ResponseEntity<Education> update(Integer id, Education updatedEntry) {
        return new ResponseEntity<>(HttpStatus.NOT_IMPLEMENTED);
    }
}

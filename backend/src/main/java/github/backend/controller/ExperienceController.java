package github.backend.controller;

import github.backend.model.Experience;
import github.backend.service.ExperienceService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/experience")
public class ExperienceController extends AbstractController<Experience, ExperienceService> {

    @Override
    public ResponseEntity<Experience> delete(Integer id) {
        return new ResponseEntity<>(HttpStatus.NOT_IMPLEMENTED);
    }

    @Override
    public ResponseEntity<Experience> add(Experience newEntry) throws Exception {
        return new ResponseEntity<>(HttpStatus.NOT_IMPLEMENTED);
    }

    @Override
    public ResponseEntity<Experience> update(Integer id, Experience updatedEntry) {
        return new ResponseEntity<>(HttpStatus.NOT_IMPLEMENTED);
    }
}

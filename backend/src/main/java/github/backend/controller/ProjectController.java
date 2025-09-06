package github.backend.controller;

import github.backend.model.Project;
import github.backend.service.ProjectService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/project")
public class ProjectController extends AbstractController<Project, ProjectService> {

    @Override
    public ResponseEntity<Project> delete(Integer id) {
        return new ResponseEntity<>(HttpStatus.NOT_IMPLEMENTED);
    }

    @Override
    public ResponseEntity<Project> add(Project newEntry) throws Exception {
        return new ResponseEntity<>(HttpStatus.NOT_IMPLEMENTED);
    }

    @Override
    public ResponseEntity<Project> update(Integer id, Project updatedEntry) {
        return new ResponseEntity<>(HttpStatus.NOT_IMPLEMENTED);
    }
}

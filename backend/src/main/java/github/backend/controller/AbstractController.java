package github.backend.controller;

import github.backend.repository.AbstractRepository;
import github.backend.service.AbstractService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

public abstract class AbstractController<T, S extends AbstractService<T, ? extends AbstractRepository<T>>> {

    @Autowired
    S service; // works even if it says error
    @PostMapping
    public ResponseEntity<T> add(@RequestBody T newEntry) throws Exception {
        return new ResponseEntity<>(service.save(newEntry), HttpStatus.OK);
    }
    @DeleteMapping("/{id}")
    public ResponseEntity<T> delete(@PathVariable Integer id){
        service.deleteById(id);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @GetMapping
    public ResponseEntity<List<T>> getAll(){
        return new ResponseEntity<>(service.findAll(), HttpStatus.OK);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Optional<T>> get(@PathVariable Integer id){
        return new ResponseEntity<>(service.findById(id), HttpStatus.OK);
    }

    @PutMapping("/{id}")
    public ResponseEntity<T> update(@PathVariable Integer id, @RequestBody T updatedEntry) {
        T newEntity = service.update(id, updatedEntry);

        return newEntity == null ? new ResponseEntity<>(updatedEntry, HttpStatus.OK) :
                new ResponseEntity<>(HttpStatus.NOT_FOUND);
    }
}
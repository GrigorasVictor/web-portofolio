package github.backend.service;

import github.backend.repository.AbstractRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public abstract class AbstractService<T, R extends AbstractRepository<T>> {
    private static final Logger logger = LoggerFactory.getLogger(AbstractService.class);

    @Autowired
    protected R repository;

    public T save(T entity) throws Exception {
        logger.info("Saving entity: {}", entity);
        return repository.save(entity);
    }

    public void deleteById(Integer id) {
        logger.info("Deleting entity by id: {}", id);
        repository.deleteById(id);
    }

    public List<T> findAll() {
        logger.info("Fetching all entities");
        return repository.findAll();
    }

    public Optional<T> findById(Integer id) {
        logger.info("Finding entity by id: {}", id);
        return repository.findById(id);
    }

    public T update(Integer id, T entity) {
        logger.info("Updating entity with id: {}", id);
        return repository.findById(id).isPresent() ? repository.save(entity) : null;
    }
}
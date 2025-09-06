package github.backend.repository;

import github.backend.model.Tag;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface TagRepository extends AbstractRepository<Tag> {
    Optional<Tag> findByName(String name);

}

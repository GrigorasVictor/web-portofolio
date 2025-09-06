package github.backend.service;

import github.backend.model.Tag;
import github.backend.repository.TagRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class TagService extends AbstractService<Tag, TagRepository> {

    @Autowired
    TagRepository repository;

    @Transactional
    public Tag getOrCreateTag(String name) {
        Tag existingTag = repository.findByName(name).get();
        if (existingTag != null) {
            return existingTag;
        }
        return repository.save(new Tag(name));
    }

}

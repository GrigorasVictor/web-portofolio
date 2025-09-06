package github.backend.util;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.jpa.repository.JpaRepository;

import java.io.IOException;
import java.util.List;

@Slf4j
public class EntityMapper<T> {
    private final Class<T> entityClass;
    private final JpaRepository<T, ?> repository;
    private final ObjectMapper objectMapper;

    public EntityMapper(Class<T> entityClass, JpaRepository<T, ?> repository) {
        this.entityClass = entityClass;
        this.repository = repository;
        this.objectMapper = new ObjectMapper();
        this.objectMapper.registerModule(new JavaTimeModule());
    }

    public List<T> mapAndSaveAll(String content) throws IOException {
        List<T> entities = objectMapper.readValue(content,
                objectMapper.getTypeFactory().constructCollectionType(List.class, entityClass));
        log.info("Successfully mapped {} {} entities", entities.size(), entityClass.getSimpleName());
        return repository.saveAll(entities);
    }
}
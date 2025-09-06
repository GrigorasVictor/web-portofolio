package github.backend.component;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import github.backend.model.Education;
import github.backend.model.Experience;
import github.backend.model.Project;
import github.backend.repository.EducationRepository;
import github.backend.repository.ExperienceRepository;
import github.backend.repository.ProjectRepository;
import github.backend.service.StorageS3Service;
import github.backend.service.TagService;
import github.backend.util.EntityMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.*;

@Component
public class DatabaseMapper {
    private static final Logger logger = LoggerFactory.getLogger(DatabaseMapper.class);
    private final Map<String, EntityMapper<?>> entityMappers = new HashMap<>();
    private final ObjectMapper objectMapper;

    private final EducationRepository educationRepository;
    private final ProjectRepository projectRepository;
    private final ExperienceRepository experienceRepository;
    private final StorageS3Service storageS3Service;

    @Autowired
    public DatabaseMapper(EducationRepository educationRepository,
                          ProjectRepository projectRepository,
                          ExperienceRepository experienceRepository,
                          StorageS3Service storageS3Service,
                          TagService tagService) {
        this.educationRepository = educationRepository;
        this.projectRepository = projectRepository;
        this.experienceRepository = experienceRepository;
        this.storageS3Service = storageS3Service;
        this.objectMapper = new ObjectMapper();
        this.objectMapper.registerModule(new JavaTimeModule());

        initializeMappers();
    }

    private void initializeMappers() {
        logger.info("Initializing mappers, education repo is null: {}", (educationRepository == null));

        entityMappers.put("project", new EntityMapper<>(Project.class, projectRepository));
        entityMappers.put("experience", new EntityMapper<>(Experience.class, experienceRepository));
        entityMappers.put("education", new EntityMapper<>(Education.class, educationRepository));

        logger.warn("Initialized mappers: {}", String.join(", ", entityMappers.keySet()));
    }

    public <T> Optional<List<T>> mapFileToEntity(String objectKey, String entityType) {
        String normalizedType = entityType.toLowerCase().trim();

        EntityMapper<?> mapper = entityMappers.get(normalizedType);
        if (mapper == null) {
            for (String key : entityMappers.keySet()) {
                System.out.println("Available entity type: " + key);
            }
            logger.error("Unsupported entity type: {}", entityType);
            return Optional.empty();
        }

        try {
            byte[] contentBytes = storageS3Service.getObject(objectKey);
            String content = new String(contentBytes, StandardCharsets.UTF_8);

            return Optional.of((List<T>) mapper.mapAndSaveAll(content));
        } catch (IOException e) {
            logger.error("Error reading file from storage {}: {}", objectKey, e.getMessage());
            return Optional.empty();
        } catch (Exception e) {
            logger.error("Error mapping file to {}: {}", entityType, e.getMessage(), e);
            return Optional.empty();
        }
    }
}
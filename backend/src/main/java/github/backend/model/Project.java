package github.backend.model;

import jakarta.persistence.*;
import lombok.Data;

import java.util.Set;
@Entity
@Data
@Table(name = "project")
public class Project {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;

    private String title;

    @Column(length = 1024)
    private String description;

    @ManyToMany(cascade = CascadeType.PERSIST)
    @JoinTable(name = "project_tags",
            joinColumns = @JoinColumn(name = "project_id"),
            inverseJoinColumns = @JoinColumn(name = "tag_id"))
    private Set<Tag> tags;

    @Column(name = "video_url")
    private String videoUrl;
    @Column(name = "github_url")
    private String githubUrl;

}

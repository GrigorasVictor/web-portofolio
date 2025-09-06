package github.backend.model;

import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDate;
import java.util.Set;

@Data
@Entity
@Table(name = "experience")
public class Experience {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;

    private String title;

    @Column(length = 1024)
    private String description;
    private String company;
    private String location;
    private LocalDate startDate;
    private LocalDate endDate;

    @ManyToMany(cascade = CascadeType.PERSIST)
    @JoinTable(name = "experience_tags",
            joinColumns = @JoinColumn(name = "experience_id"),
            inverseJoinColumns = @JoinColumn(name = "tag_id"))
    private Set<Tag> tags;

    @Column(name = "photo_url")
    private String photoUrl;

}

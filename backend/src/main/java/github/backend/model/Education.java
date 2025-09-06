package github.backend.model;

import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDate;

@Data
@Entity
@Table(name = "edcuation")
public class Education {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;

    private String degree;
    private String institution;
    private String location;

    @Column(name = "start_date")
    private LocalDate startDate;

    @Column(name = "end_date")
    private LocalDate endDate;

    @Column(name = "photo_url")
    private String photoUrl;

}

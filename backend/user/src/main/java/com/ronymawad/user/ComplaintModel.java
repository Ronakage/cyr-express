package com.ronymawad.user;

import lombok.*;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Data
@Builder
@Getter
@Setter
@AllArgsConstructor
@Document("complaint")
public class ComplaintModel {
    @Id
    private String id;
    private String complaintFrom;
    private String complaintTo;
    private String complaintTitle;
    private String complaintDesc;
}

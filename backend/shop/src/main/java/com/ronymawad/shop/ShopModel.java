package com.ronymawad.shop;

import lombok.*;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.List;

@Data
@Builder
@Getter
@Setter
@RequiredArgsConstructor
@Document("shop")
public class ShopModel {
    @Id
    private String id;
    private String userID;
    private String shopName;
    private String shopAddress;
    private List<String> shopItems;
}

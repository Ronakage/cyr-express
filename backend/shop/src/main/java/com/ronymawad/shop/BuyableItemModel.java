package com.ronymawad.shop;

import lombok.*;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Data
@Builder
@Getter
@Setter
@AllArgsConstructor
@Document("item")
public class BuyableItemModel {
    @Id
    private String ID;
    private String shopID;
    private String itemName;
    private Double itemPrice;
}

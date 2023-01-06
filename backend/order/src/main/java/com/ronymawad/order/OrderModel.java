package com.ronymawad.order;

import com.ronymawad.shop.BuyableItemModel;
import com.ronymawad.user.ComplaintModel;
import lombok.*;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.time.LocalDateTime;
import java.util.List;

@Data
@Builder
@Getter
@Setter
@AllArgsConstructor
@Document("order")
public class OrderModel {
    @Id
    private String id;
    private String shopID;
    private String driverID;
    private String clientID;
    private String clientFirstName;
    private String clientLastName;
    private String clientPhoneNumber;
    private String clientEmail;

    private List<String> orderItemsIDS;

    private LocalDateTime timeCreated;
    private LocalDateTime timeReadyForDelivery;
    private LocalDateTime timePickedForDelivery;
    private LocalDateTime timeDelivered;

    private Boolean isCreated;
    private Boolean isReadyForDelivery;
    private Boolean isPassedByShop;
    private Boolean isPickedByDriver;
    private Boolean isDroppedByDriver;
    private Boolean isPickedByClient;

    private String complaintID;
}

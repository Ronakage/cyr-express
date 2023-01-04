package com.ronymawad.delivery;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class LocationMessage {
    private String name;
    private double latitude;
    private double longitude;

    public String toString(){
        return String.valueOf(latitude) + "/" +  String.valueOf(longitude);
    }
}

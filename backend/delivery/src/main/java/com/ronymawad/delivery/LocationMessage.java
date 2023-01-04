package com.ronymawad.delivery;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.HashMap;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class LocationMessage {
    private String name;
    private double latitude;
    private double longitude;

    public HashMap<String, Object> toJSON(){
        HashMap<String, Object> map = new HashMap<>();
        map.put("name", name);
        map.put("latitude", latitude);
        map.put("longitude", longitude);
        return map;
        //return String.valueOf(latitude) + "/" +  String.valueOf(longitude);
    }
}

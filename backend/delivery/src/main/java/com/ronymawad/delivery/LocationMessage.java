package com.ronymawad.delivery;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.HashMap;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class LocationMessage {
    private String id;
    private String firstName;
    private String lastName;
    private String role;
    private String status;
    private double latitude;
    private double longitude;

    public HashMap<String, Object> toJSON(){
        HashMap<String, Object> map = new HashMap<>();
        map.put("id", id);
        map.put("firstName", firstName);
        map.put("lastName", lastName);
        map.put("role", role);
        map.put("status", status);
        map.put("latitude", latitude);
        map.put("longitude", longitude);
        return map;
    }
}

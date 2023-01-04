package com.ronymawad.delivery;

import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
@AllArgsConstructor
public class LocationController  {

    private LocationService service;

    @PostMapping("/sendLocation")
    public void sendLocation(@RequestBody final LocationMessage locationMessage){
        service.notifyFrontend(locationMessage.toJSON());
    }
}

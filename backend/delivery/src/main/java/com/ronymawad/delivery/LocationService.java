package com.ronymawad.delivery;

import lombok.AllArgsConstructor;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;

@Service
@AllArgsConstructor
public class LocationService {
    private SimpMessagingTemplate messagingTemplate;

    public void notifyFrontend(final Object message){
        messagingTemplate.convertAndSend("/topic/locations", message);
    }
}

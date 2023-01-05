package com.ronymawad.delivery;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
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

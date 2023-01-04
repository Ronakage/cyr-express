package com.ronymawad.delivery;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.web.util.HtmlUtils;

@Controller
public class MessageController {

    @MessageMapping("/location")
    @SendTo("/topic/locations")
    public ResponseMessage getLocation(final LocationMessage locationMessage){
        return new ResponseMessage(HtmlUtils.htmlEscape(locationMessage.getName()));
    }
}

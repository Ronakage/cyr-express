package com.ronymawad.user;

import com.ronymawad.user.request.UserLoginRequest;
import com.ronymawad.user.request.UserRegistrationRequest;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;


import java.util.List;
@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("api/v0/users")
public class UserController {

    private final UserService userService;
    @PostMapping("/signup")
    public ResponseEntity<String> signupUser(@RequestBody UserRegistrationRequest request) {
        try {
            userService.signupUser(request);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.NOT_ACCEPTABLE).body(e.getMessage());
        }
        return ResponseEntity.status(HttpStatus.OK).body("User created with " + request.email());
    }
    @PostMapping("/signin")
    public ResponseEntity<Object> loginUser(@RequestBody UserLoginRequest request){
        try {
            return ResponseEntity.status(HttpStatus.OK).body(userService.getUserByEmail(request.email()));
        } catch (Exception e) {
            log.info(e.getMessage());
            return ResponseEntity.status(HttpStatus.NOT_ACCEPTABLE).body("Sign-in was unsuccessful");
        }
    }

    @PreAuthorize("hasAuthority('ROLE_ADMIN')")
    @GetMapping
    public List<UserModel> getAllUsers(){
        return userService.getUsers();
    }

    @PreAuthorize("hasAuthority('ROLE_STAFF')")
    @GetMapping("/id/{id}")
    public UserModel getUserByID(@PathVariable String id){
        return userService.getUserByID(id);
    }

    @PreAuthorize("hasAuthority('ROLE_SHOP_OWNER')")
    @GetMapping("/firstName/{firstName}")
    public List<UserModel> getUserByFirstName(@PathVariable String firstName){
        return userService.getUserByFirstName(firstName);
    }

    @PreAuthorize("hasAuthority('ROLE_DRIVER')")
    @GetMapping("/lastName/{lastName}")
    public List<UserModel> getUserByLastName(@PathVariable String lastName){
        return userService.getUserByLastName(lastName);
    }
    @PreAuthorize("hasAuthority('ROLE_CLIENT')")
    @GetMapping("/email/{email}")
    public UserModel getUserByEmail(@PathVariable String email){
        try {
            return userService.getUserByEmail(email);
        } catch (Exception e) {
            log.info(e.getMessage());
            return new UserModel(); //TODO : return status code
        }
    }

    @PatchMapping
    public void patchUserEmail(String id, String newEmail){
        UserModel user = userService.getUserByID(id);
        user.setEmail(newEmail);
    }
}

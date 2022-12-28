package com.ronymawad.user;

import com.ronymawad.user.exception.EmailAlreadyUsedException;
import com.ronymawad.user.request.UserRegistrationRequest;
import com.ronymawad.user.exception.RoleNameNotFound;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public record UserService(UserRepository userRepository) {

    public List<UserModel> getUsers(){
        return userRepository.findAll();
    }
    public UserModel getUserByID(String id){
        return userRepository.findById(id).orElse(new UserModel());
    }
    public List<UserModel> getUserByFirstName(String firstName){
        return userRepository.findByFirstName(firstName);
    }
    public List<UserModel> getUserByLastName(String lastName){
        return userRepository.findByLastName(lastName);
    }
    public UserModel getUserByEmail(String email) throws Exception {
        return userRepository.findByEmail(email).orElseThrow(() -> new Exception(email + " not found.")); //TODO : Create new exception
    }

    public void signupUser(UserRegistrationRequest request) throws EmailAlreadyUsedException, RoleNameNotFound {
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        
        if(userRepository.existsByEmail(request.email())){
            throw new EmailAlreadyUsedException(request.email());
        }
        else{
            UserModel user = UserModel
                    .builder()
                    .firstName(request.firstName())
                    .lastName(request.lastName())
                    .email(request.email())
                    .password(encoder.encode(request.password()))
                    .roles(UserModel.initiateRole((request.roles())))
                    .timeCreated(LocalDateTime.now())
                    .build();
            //Do registration checks
            userRepository.save(user);
        }
    }

}

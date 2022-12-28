package com.ronymawad.user;

import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.List;
import java.util.Optional;

public interface UserRepository extends MongoRepository<UserModel, String> {
    Optional<UserModel> findById(String id);
    List<UserModel> findByFirstName(String firstName);
    List<UserModel> findByLastName(String lastName);
    Optional<UserModel> findByEmail(String email);
    boolean existsByEmail(String email);
}

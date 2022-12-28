package com.ronymawad.user.request;

public record UserRegistrationRequest(
        String firstName,
        String lastName,
        String email,
        String password,
        String roles
) {
}

package com.ronymawad.user.request;

public record UserLoginRequest(
        String email,
        String password
) { }

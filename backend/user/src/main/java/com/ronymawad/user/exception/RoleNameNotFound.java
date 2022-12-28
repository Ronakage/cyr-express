package com.ronymawad.user.exception;

public class RoleNameNotFound extends Exception {
    public RoleNameNotFound(String roleName) {
        super("Role name is not found! User is not created.");
    }
}

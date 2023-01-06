package com.ronymawad.user;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.ronymawad.user.exception.RoleNameNotFound;
import lombok.*;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.Collection;
import java.util.List;

@Data
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Document("user")
public class UserModel implements UserDetails {
    @Id
    private String id;
    @NonNull
    private String firstName;
    @NonNull
    private String lastName;
    @NonNull
    @Indexed(unique = true)
    private String email;
    @NonNull
    @JsonIgnore
    private String password;
    @NonNull
    private String roles;

    private List<String> orderIDS;
    private List<String> complaintIDS;

    private String shopID;

    private LocalDateTime timeCreated;
    private LocalDateTime timeModified;
    private LocalDateTime timeDeleted;

    private LocalDateTime restrictionStartDate;
    private LocalDateTime restrictionEndDate;

    public static String initiateRole(String roles) throws RoleNameNotFound {
        switch(roles.toLowerCase()){
            case "admin":
                return "ROLE_ADMIN,ROLE_STAFF,ROLE_SHOP_OWNER,ROLE_DRIVER,ROLE_CLIENT";
            case "staff":
                return "ROLE_STAFF,ROLE_SHOP_OWNER,ROLE_DRIVER,CLIENT";
            case "shop":
            case "shop_owner":
            case "owner":
                return "ROLE_SHOP_OWNER,ROLE_CLIENT";
            case "driver":
                return "ROLE_DRIVER,ROLE_CLIENT";
            case "client":
            case "user":
                return "ROLE_CLIENT";
            default:
                throw new RoleNameNotFound(roles);
        }
    }

    @Override
    public String getUsername() {
        return this.email;
    }

    @Override
    public String getPassword() {
        return this.password;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return Arrays.stream(getRoles().split(","))
                .map(SimpleGrantedAuthority::new)
                .toList();
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }
}

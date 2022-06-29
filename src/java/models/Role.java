package models;

import java.io.Serializable;

public class Role implements Serializable {

    private int roleId;
    private int roleName;

    public Role() {
    }

    public Role(int roleId, int roleName) {
        this.roleId = roleId;
        this.roleName = roleName;
    }

    public int getRoleName() {
        return roleName;
    }

    public void setRoleName(int roleName) {
        this.roleName = roleName;
    }

    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }

}

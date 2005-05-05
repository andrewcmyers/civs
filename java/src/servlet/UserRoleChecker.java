package servlet;

/**
 * Interface to allow checking if a user security principal
 * has a particular role.
 */
interface UserRoleChecker {
    boolean isUserInRole(UserPrincipal u, RolePrincipal r);
}

const apiUrl = 'http://localhost:8080/api';

export const ApiEndpoints = {
    Auth: {
        Register: `${apiUrl}/auth/register`,
        Login: `${apiUrl}/auth/login`,
        Profile: `${apiUrl}/profile`,
    }
}

export const LocalStorage = {
    token: 'USER_TOKEN',
}